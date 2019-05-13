#Fields Model
# :praticien, foreign_key: true
# :massage_category, foreign_key: true

class Competency < ApplicationRecord
  belongs_to :praticien
  belongs_to :massage_category
end
