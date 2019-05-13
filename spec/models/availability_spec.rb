require 'rails_helper'

RSpec.describe Availability, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:praticien) }
    it { is_expected.to respond_to(:calendar_day) }
    it { is_expected.to respond_to(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:calendar_day) }
    it { is_expected.to belong_to(:praticien) }
  end
end
