# t.bigint "massage_category_id"
# t.bigint "calendar_day_id"
# t.integer "nb_praticiens"
# t.integer "amount_cents", default: 0, null: false

class Requirement < ApplicationRecord
  belongs_to :massage_category
  belongs_to :calendar_day
  has_many :availabilities
  has_many :events
  has_many :praticiens, through: :availabilities
  # has_many :booked_praticiens, through: :events, source: :praticiens

  monetize :amount_cents

  validates :calendar_day, uniqueness: { scope: :massage_category }
  scope :filtered_by_event, -> (event) { where(massage_category: event.massage_category, calendar_day: event.calendar_day)}
  scope :filtered_by_available_availabilities, -> { includes(:availabilities).where(availabilities: {status: 1})}

  accepts_nested_attributes_for :availabilities, allow_destroy: true
  accepts_nested_attributes_for :events, allow_destroy: true
end
