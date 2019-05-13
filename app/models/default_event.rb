class DefaultEvent < ApplicationRecord
  attr_accessor :massage_by_slot, :duplication, :duration

  belongs_to :event_group
  belongs_to :massage_category

  monetize :price_cents
end
