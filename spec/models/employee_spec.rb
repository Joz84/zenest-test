require 'rails_helper'

# Fields of the model
# :stripe_id
# :admin_company, default: false
# :company, foreign_key: true

RSpec.describe Employee, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:stripe_id) }
    it { is_expected.to respond_to(:email) }
    it { is_expected.to respond_to(:company) }
    it { is_expected.to respond_to(:admin_company) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:attendees) }
    it { is_expected.to have_many(:events) }
  end
end
