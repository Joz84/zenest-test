# Fields of the Model
# :employee, foreign_key: true
# :event, foreign_key: true
#  :status
#  :price
# :payment_json

class Attendee < ApplicationRecord

  after_save :update_associations_counter_caches
  after_destroy :update_associations_counter_caches

  belongs_to :employee
  belongs_to :event
  delegate :massage_category, to: :event
  delegate :start_date, to: :event
  delegate :end_date, to: :event

  validates :employee, presence: true
  validates :event, uniqueness: { scope: :employee }

  validates_with BookingMaxValidator, if: :attendee_with_employee_and_confirmed
  validates_with EventCapacityValidator, if: :attendee_with_employee_and_confirmed

  validates :employee, uniqueness: { scope: :event ,
    message: "Vous êtes déjà inscrit à cet événement"}

  enum status: { confirmed: 0, cancelled: 1 }
  scope :filtered_by_company, -> (user) { includes(:employees).where(employees: {company: user.actable.company }) }
  scope :filtered_by_periodicity, -> (periodicity, value) { where('extract(? from events.start_date) = ?', periodicity, value) }
  scope :group_by_employee, -> { group_by(&:employee) }

  def attendee_with_employee_and_confirmed
    employee && confirmed?
  end

  def update_associations_counter_caches
    event.update_counter_caches
  end

  def self.name_list
    all.map{|attendee| attendee.employee.name }.join(", ")
  end

  def event_month
    event.start_date.month
  end

  def event_week
    event.start_date.to_date.cweek
  end

  def self.filtered_by_employee_and_massage_category(employee,massage_category)
    includes(:event, :employee)
    .where(events: {massage_category: massage_category}, employee: employee)
  end
end
