require 'rails_helper'

# Fields of the model
# :photo

RSpec.describe Praticien, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:photo) }
    it { is_expected.to respond_to(:email) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:competencies) }
    it { is_expected.to have_many(:massage_categories) }
    it { is_expected.to have_many(:availabilities) }
  end

end
