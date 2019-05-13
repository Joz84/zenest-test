require 'rails_helper'

# Fields of the model
# :calendar, foreign_key: true
# :date
# :nb_praticiens

RSpec.describe CalendarDay, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:calendar) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:nb_praticiens) }
  end
  describe 'associations' do
    it { is_expected.to belong_to(:calendar) }
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:availabilities) }
  end
end
