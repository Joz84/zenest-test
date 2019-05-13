require 'rails_helper'

# Fields of the model
# :start_date
# :end_date
# :massage_category, foreign_key: true
# :room, foreign_key: true
# :calendar_day, foreign_key: true
# :praticien, foreign_key: true
# :description
# :photo
# :price
# :status
# :title
# :max_attendees

RSpec.describe Event, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:start_date) }
    it { is_expected.to respond_to(:end_date) }
    it { is_expected.to respond_to(:massage_category) }
    it { is_expected.to respond_to(:room) }
    it { is_expected.to respond_to(:calendar_day) }
    it { is_expected.to respond_to(:praticien) }
    it { is_expected.to respond_to(:description) }
    it { is_expected.to respond_to(:photo) }
    it { is_expected.to respond_to(:price_cents) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:max_attendees) }
    it { is_expected.to respond_to(:min_attendees) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:room) }
    it { is_expected.to belong_to(:massage_category) }
    it { is_expected.to belong_to(:praticien) }
    it { is_expected.to belong_to(:calendar_day) }
    it { is_expected.to have_many(:attendees) }
    it { is_expected.to have_many(:employees) }
  end
end
