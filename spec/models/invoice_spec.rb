require 'rails_helper'

# t.string :title
# t.string :url
# t.datetime :date
# t.references :invoiceable, polymorphic: true
# t.string :reference
# t.monetize :amount


RSpec.describe Invoice, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:url) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:reference) }
    it { is_expected.to respond_to(:amount_cents) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
