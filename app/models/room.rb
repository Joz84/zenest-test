# Fields of the model
# :company, foreign_key: true
# :name
# :capacity

class Room < ApplicationRecord
  belongs_to :company
  has_many :events

  validates :name, presence: true
  validates :name, uniqueness: { scope: :company_id }
  validates :capacity, numericality: { greater_than: 0 }

  scope :filtered_by_company, -> (user) { where(company: user.actable.company) }
  scope :ordered_by_id_desc, -> { order(id: :desc) }
end
