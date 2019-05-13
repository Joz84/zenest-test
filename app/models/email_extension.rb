# Fields of the model
# :name
# :company, foreign_key: true

class EmailExtension < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, uniqueness: { scope: :company }
end
