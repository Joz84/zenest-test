require 'rails_helper'

# Fields of the model
# :name
# :company, foreign_key: true

RSpec.describe EmailExtension, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:company) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
