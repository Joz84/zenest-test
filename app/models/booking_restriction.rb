class BookingRestriction < ApplicationRecord
  belongs_to :company
  belongs_to :massage_category

  enum periodicity: { month: 0, week: 1 }

  validates :rate, presence: true
  validates :periodicity, presence: true

  validates :company, uniqueness: { scope: :massage_category ,
    message: "Une restriction existe déjà pour cette catégorie de massage"}

  scope :filtered_by_attendee, -> (attendee) { find_by(company: attendee.employee.company, massage_category: attendee.massage_category) }

end
