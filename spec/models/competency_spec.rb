require 'rails_helper'

#Fields Model
# :praticien, foreign_key: true
# :massage_category, foreign_key: true

RSpec.describe Competency, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:praticien) }
    it { is_expected.to respond_to(:massage_category) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:massage_category) }
    it { is_expected.to belong_to(:praticien) }
  end
end
