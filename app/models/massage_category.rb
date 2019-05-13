# Fields of the model
# :photo
# :name
# :price
# t.boolean :individual, default: false

class MassageCategory < ApplicationRecord

  after_save :creation_booking_restrictions
  has_many :competencies
  has_many :events
  has_many :praticiens, through: :competencies

  has_many :requirements
  has_many :availabilities, through: :requirements

  has_many :event_groups
  has_many :default_events

  validates :name, presence: true

  monetize :price_cents
  mount_uploader :photo, PhotoUploader

  accepts_nested_attributes_for :requirements, allow_destroy: true
  accepts_nested_attributes_for :availabilities, allow_destroy: true

  def creation_booking_restrictions
    Company.all.each do |company|
      BookingRestriction.find_or_create_by(massage_category: self, company: company, rate: 100000)
    end
  end

end
