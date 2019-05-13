# Fields of the model
# :company, foreign_key: true
# :google_id
# :active
# :name
# :payable

class Calendar < ApplicationRecord
  belongs_to :company
  after_save :send_email_feedbacks_to_praticiens, if: :active_changed?
  has_many :calendar_days, dependent: :destroy
  has_many :events, through: :calendar_days
  has_many :requirements, through: :calendar_days
  has_many :availabilities, through: :requirements
  has_many :event_groups

  validates :name, presence: true
  validate :validate_active_status, if: :active_changed?

  accepts_nested_attributes_for :events, allow_destroy: true
  accepts_nested_attributes_for :event_groups, allow_destroy: true
  accepts_nested_attributes_for :calendar_days, allow_destroy: true
  accepts_nested_attributes_for :availabilities, allow_destroy: true
  accepts_nested_attributes_for :requirements, allow_destroy: true

  def send_email_feedbacks_to_praticiens
    if self.changes[:active] == [false, true]
      # A beaucoup beaucoup améliorer et bcp bcp à vérifier
      requirements.each do |requirement|
        praticien_booked = requirement.calendar_day.events.map(&:praticien).uniq
        praticien_booked.each do |praticien|
          PraticienMailer.availability_feedback_positive(praticien.user, requirement)
        end
        praticiens_not_booked = requirement.praticiens.uniq - praticien_booked
        praticien_not_booked.each do |praticien|
          PraticienMailer.availability_feedback_negative(praticien.user, requirement)
        end
      end
    end
  end
  
  private

  def validate_active_status
    if self.changes[:active] == [true, false]
      errors.add(:active, "Calendrier déjà actif - Non modifiable")
    end
  end
end
