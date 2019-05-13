require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:company) }
    it { is_expected.to respond_to(:capacity) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
