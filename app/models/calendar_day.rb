# Fields of the model
# :calendar, foreign_key: true
# :date
# :nb_praticiens

class CalendarDay < ApplicationRecord
  belongs_to :calendar
  has_many :events
  has_many :praticiens, through: :events
  has_many :massage_categories, through: :events
  has_many :requirements
  has_many :availabilities, through: :requirements
  delegate :company, to: :calendar

  accepts_nested_attributes_for :requirements, allow_destroy: true
  accepts_nested_attributes_for :massage_categories, allow_destroy: true


  def display_events_date
    if events.present?
      list = []
      events.group_by_massage_category.each do |massage_category, events_list|
        list << "<li>Prestations de #{massage_category.name}</li>"
        events_list.each do |event|
          list << "<li>- de #{event.start_date.strftime('%Hh%M')} à #{event.end_date.strftime('%Hh%M')} </li>"
        end
      end
      return list.join
    else
      "Pas de prévues prestations à cette date"
    end
  end

end
