require 'rails_helper'

# Fields of the model
# :address
# :name
# :siret
# :company_code
# :booking_max
# :active, default: true


RSpec.describe Company, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:siret) }
    it { is_expected.to respond_to(:company_code) }
    it { is_expected.to respond_to(:booking_max) }
    it { is_expected.to respond_to(:active) }
    it { is_expected.to respond_to(:zipcode) }
    it { is_expected.to respond_to(:city) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'associations' do
    #it { is_expected.to belong_to(:rooms) }
    it { is_expected.to have_many(:email_extensions) }
    it { is_expected.to have_many(:employees) }
    it { is_expected.to have_many(:rooms) }
    it { is_expected.to have_many(:calendars) }
    it { is_expected.to have_many(:calendar_days) }
    it { is_expected.to have_many(:events) }
    # it { is_expected.to have_and_belong_to_many(:blog_tags) }
  end

  # describe 'scopes' do

  #   describe '.published' do
  #     let(:published_article) { create(:published_article) }
  #     let(:unpublished_article) { create(:unpublished_article) }
  #     it { expect(described_class.published).to include(published_article) }
  #     it { expect(described_class.published).to_not include(unpublished_article) }
  #   end

  #   describe '.featured' do
  #     let(:featured_article) { create(:featured_article) }
  #     let(:unfeatured_article) { create(:unfeatured_article) }
  #     it { expect(described_class.featured).to include(featured_article) }
  #     it { expect(described_class.featured).to_not include(unfeatured_article) }
  #   end
  # end
end
