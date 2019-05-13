require 'rails_helper'

# Fields of the Model
# :employee, foreign_key: true
# :event, foreign_key: true
#  :status
#  :price
# :payment_json

RSpec.describe Attendee, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:employee) }
    it { is_expected.to respond_to(:event) }
    it { is_expected.to respond_to(:price_cents) }
    it { is_expected.to respond_to(:status) }
    it { is_expected.to respond_to(:payment_json) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:event) }
    it { is_expected.to belong_to(:employee) }
  end
end
