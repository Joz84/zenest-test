# Fields of the model
# :start_date
# :end_date
# :massage_category, foreign_key: true
# :room, foreign_key: true
# :calendar_day, foreign_key: true
# :praticien, foreign_key: true
# :description
# :photo
# :price
# :status
# :title
# :max_attendees
# :min_attendees

class Event < ApplicationRecord
  before_create :check_price_value
  before_create :check_individual
  # after_update :send_availabilities_updates_email, if: :praticien_changed?
  before_destroy :event_with_payments?
  before_destroy :event_in_the_past?
  before_destroy :send_email_praticien_and_attendees, if: :event_calendar_active?

  belongs_to :event_group, optional: true
  belongs_to :massage_category
  belongs_to :truncated_massage_category,
             -> {select(:id, :name)},
             class_name: "MassageCategory",
             foreign_key: 'massage_category_id'

  belongs_to :room, optional: true
  belongs_to :calendar_day
  belongs_to :praticien, optional: true
  # a la creation d'un event, le praticien n'est pas défini
  has_many :attendees, dependent: :destroy
  has_many :employees, through: :attendees

  delegate :calendar, to: :calendar_day
  delegate :company, to: :calendar

  monetize :price_cents

  validates :title, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

  enum status: { active: 0, archived: 1 }

  mount_uploader :photo, PhotoUploader

  scope :group_by_future_past, -> { group_by(&:future_past) }
  scope :group_by_massage_category, -> { group_by(&:massage_category) }
  scope :group_by_calendar_day, -> { group_by(&:calendar_day) }
  scope :filtered_by_company, -> (user) { includes(calendar_day: :calendar).where(calendars: { company_id: user.actable.company }) }
  scope :ordered_by_praticien, -> { includes(praticien: :user).order("users.first_name")}
  scope :ordered_by_start_date, -> { order(start_date: :asc)}
  scope :filtered_by_employee, -> (user) { includes(:attendees).where(attendees: {employee: user.actable }) }
  scope :filtered_by_praticien, -> (user) { where(praticien: user.actable) }
  scope :filtered_by_massage_category, -> (massage_category) { where(massage_category: massage_category) }
  # scope :filtered_by_active_calendars, -> { joins(:) }
  scope :group_by_day_and_truncated_massage_category, -> {
    includes(:truncated_massage_category).group_by do |event|
      [event.truncated_massage_category, event.start_date.to_date]
    end
  }
  scope :filtered_by_date, -> (date) { where('DATE(start_date) = ?', date) }
  scope :filtered_by_calendar_day, -> (calendar_day) { where(calendar_day: calendar_day) }

  scope :filtered_by_avaialble_attendees, -> { where("events.max_attendees > events.confirmed_attendees_count") }

  scope :formated_for_modal_callendar, -> (employee) {
      self.includes(:massage_category, :praticien, :attendees, :calendar_day, :room)
          .ordered_by_start_date
          .ordered_by_praticien
          .group_by_massage_category.map do |category, events|
            event_dates = events.group_by do |event|
              [
                event.start_date.strftime('%Hh%M'),
                event.end_date.strftime('%Hh%M'),
                event.start_date.strftime("%d/%m/%Y")
              ]
            end
            event_dates = event_dates.map do |dates, date_events|
              truncated_date_events = date_events.map do |date_event|
                {
                  event_id: date_event.id,
                  praticien_username: date_event.praticien ? date_event.praticien.first_name.capitalize : 'non attribué',
                  praticien_full_name: date_event.praticien ? date_event.praticien.name : 'non attribué',
                  praticien_url: date_event.praticien ? date_event.praticien.default_photo_url : PICTO_PRATCIEN_URL,
                  max_attendees: date_event.max_attendees,
                  confirmed_attendees_count: date_event.confirmed_attendees_count,
                  available_attendees_count: date_event.available_attendees_count,
                  price: date_event.price_cents * 0.01,
                  employee_registration: date_event.attendees.count{ |attendee| attendee.employee_id == employee.id }.nonzero?,
                  show_url: Rails.application.routes.url_helpers.admin_employee_event_path(date_event),
                  room: date_event.room&.name || date_event.company.name,
                  payable: date_event.calendar.payable,
                  past: date_event.start_date - 1.day <= Date.today,
                  group: date_event.group?,
                  praticien_is_nil: date_event.praticien.nil?
                }
              end
              {
                start_date: dates[0],
                end_date: dates[1],
                daily_date: dates[2],
                events: truncated_date_events
              }
            end
            {
              id: category.id,
              name: category.name,
              url: category.photo,
              event_dates: event_dates,
              max_attendees: events.map(&:max_attendees).sum,
              available_attendees_count: events.map(&:available_attendees_count).sum
            }
          end
    }

#@all_profiles = UserProfile.joins(:widgets).select('user_profiles.*, COUNT(*) AS widget_count').group('user_profiles.id').order('name ASC')


  scope :formated_for_calendar, -> {
    self.includes(:massage_category, :calendar_day)
        .group_by do |event|
          {
            massage_category: event.massage_category,
            calendar_day: event.calendar_day
          }
        end.map do |filters, events|
          {
            id: filters[:massage_category].id,
            title: "#{events.map(&:available_attendees_count).sum} / #{events.map(&:max_attendees).sum} - #{filters[:massage_category].name}",
            start: filters[:calendar_day].date,
            color: events.map(&:available_attendees_count).sum.zero? ? "#C82333" : "#218838",
            calendar_day_id: filters[:calendar_day].id
          }
        end
  }

# Event.all.includes(:massage_category, :calendar_day).group_by{ |e| e.massage_category }.map{ |k, v| [k,  v.group_by{ |e| e.calendar_day} ] }.to_h

  # scope :filter_by_today, , -> { where(praticien: user.actable).where("DATE(start_date) = ?", (DateTime.now).to_date}
  scope :filtered_by_calendar_active, -> { includes(calendar_day: :calendar).where(calendars: { active: true }) }

  ransacker :by_company_name,formatter: proc { |value|
    company = Company.find(value.to_i)
    data = Event.select{|event| event.company == company }.map(&:id)
    data = data.present? ? data : nil
  } do |parent|
    parent.table[:id]
  end

  def event_calendar_active?
    self.calendar.active
  end

  def available_attendees_count
    max_attendees - confirmed_attendees_count
  end

  def update_counter_caches
    update(
      confirmed_attendees_count: attendees.confirmed.size,
      cancelled_attendees_count: attendees.cancelled.size
    )
  end

  def today?
    start_date.to_date == (DateTime.now).to_date
  end

  def future_past
    end_date < DateTime.now ? "past" : "future"
  end

  def group?
    max_attendees > 1
  end

  def duration
    duration = end_date - start_date
    (duration / 1.minute).round
  end

  def attendee_for_current_user(user)
    Attendee.find_by(event: self, employee: user.actable )
  end

  def number_of_available_seats
    max_attendees - (attendees.confirmed.size)
  end

  def number_of_attendees
    attendees.confirmed.size
  end

  def default_title
    massage_category.name
  end

  def available?
    attendees.confirmed.size < max_attendees
  end

  def complete_date
    "#{start_date.strftime("%A %d %B %Y")} de #{start_date.strftime("%Hh%M")} à #{end_date.strftime("%Hh%M")}"
  end

  # def send_availabilities_updates_email

  # end

  private

  def check_individual
    max_attendees = 1 if massage_category.individual?
  end

  def check_price_value
    self.price_cents = massage_category.price_cents if price_cents == 0
  end

  def send_email_praticien_and_attendees
    attendees.each do |attendee|
      EmployeeMailer.cancellation_event(attendee).deliver_now
    end
    PraticienMailer.cancellation_event(self).deliver_now if self.praticien
  end

  def event_with_payments?
    if calendar.payable && calendar.active
      errors.add(:base, "cant be deleted with payments already done")
      throw(:abort)
    end
  end

  def event_in_the_past?
    if future_past == 'past'
      errors.add(:base, "cant delete event in the past")
      throw(:abort)
    end
  end
end
