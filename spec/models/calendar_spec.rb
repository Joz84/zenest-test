require 'rails_helper'

# Fields of the model
# :company, foreign_key: true
# :google_id
# :active
# :name
# :payable

RSpec.describe Calendar, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:google_id) }
    it { is_expected.to respond_to(:company) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:active) }
    it { is_expected.to respond_to(:payable) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to have_many(:calendar_days) }
    it { is_expected.to have_many(:events) }
    # it { is_expected.to have_and_belong_to_many(:blog_tags) }
  end
end
