# t.bigint "calendar_id"
# t.bigint "massage_category_id"
# t.bigint "room_id"
# t.text "description"
# t.string "photo"
# t.integer "price_cents", default: 0, null: false
# t.string "price_currency", default: "EUR", null: false
# t.string "title"
# t.integer "duration"
# t.integer "massage_by_slot"
# t.time "morning_date"
# t.integer "morning_duplication"
# t.time "afternoon_date"
# t.integer "afternoon_duplication"
# t.integer "max_attendees", default: 15
# t.integer "min_attendees", default: 1

class EventGroup < ApplicationRecord
  belongs_to :calendar
  has_many :events
  has_many :default_events
  belongs_to :massage_category

  monetize :price_cents

  validates :calendar,              presence: true
  validates :massage_category,      presence: true
  validates :price,                 presence: true
  validates :duration,              presence: true
  validates :massage_by_slot,       presence: true
  validates :morning_duplication,   presence: true
  validates :afternoon_duplication, presence: true
  validates :max_attendees,         presence: true
  validates :min_attendees,         presence: true
  validates_presence_of :morning_date,   if: -> { self.morning_duplication && self.morning_duplication > 0 }
  validates_presence_of :afternoon_date, if: -> { self.afternoon_duplication && self.afternoon_duplication > 0 }

  after_create :create_default_events

  def create_default_events
    self.massage_by_slot.times do
      self.morning_duplication.times do |i|
        start_date = self.morning_date.to_datetime + self.duration.minutes * i
        end_date = start_date + self.duration.minutes

        DefaultEvent.create!(
          event_group: self,
          start_date: start_date,
          massage_category: self.massage_category,
          end_date: end_date,
          description: self.description,
          price: self.price,
          price_currency: "EUR",
          title: self.title,
          max_attendees: self.max_attendees,
          min_attendees: self.min_attendees,
          morning: start_date.hour < 12
        )

      end

      self.afternoon_duplication.times do |i|
        start_date = self.afternoon_date.to_datetime + self.duration.minutes * i
        end_date = start_date + self.duration.minutes

        DefaultEvent.create!(
          event_group: self,
          start_date: start_date,
          massage_category: self.massage_category,
          end_date: end_date,
          description: self.description,
          price: self.price,
          price_currency: "EUR",
          title: self.title,
          max_attendees: self.max_attendees,
          min_attendees: self.min_attendees,
          morning: start_date.hour < 12
        )

      end
    end
  end
end
