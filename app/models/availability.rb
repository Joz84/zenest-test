class Availability < ApplicationRecord
  belongs_to :praticien
  belongs_to :requirement
  after_create :send_availability_request

  delegate :calendar_day, to: :requirement

  enum status: { pending: 0, available: 1, unavailable: 2, approved: 3, declined: 4 }

  validates :praticien, uniqueness: { scope: :requirement }

  scope :filtered_by_praticien, -> (user) { where(praticien: user.actable) }

  private

  def send_availability_request
    PraticienMailer.availability_request(self).deliver_now
  end

end
