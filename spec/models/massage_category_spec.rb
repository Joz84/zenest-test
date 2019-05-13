require 'rails_helper'

# Fields of the model
# :photo
# :name
# :price

RSpec.describe MassageCategory, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:photo) }
    it { is_expected.to respond_to(:price_cents) }
    it { is_expected.to respond_to(:individual) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:competencies) }
    it { is_expected.to have_many(:praticiens) }
  end
end
