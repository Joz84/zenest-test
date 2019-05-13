require 'rails_helper'

# Fields of the model
#   :first_name, :string
#   :last_name, :string
#   :birthday, :datetime
#   :address, :string
#   :zipcode, :string
#   :city, :string
#   :phone, :string
#   :complement, :string
#   :gender, :integer
#   :active, :boolean, default: true
#   :actable_id, :integer
#   :actable_type, :string

RSpec.describe User, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:birthday) }
    it { is_expected.to respond_to(:address) }
    it { is_expected.to respond_to(:zipcode) }
    it { is_expected.to respond_to(:city) }
    it { is_expected.to respond_to(:phone) }
    it { is_expected.to respond_to(:complement) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
  end

  describe 'scopes' do

    # describe '.employees' do
    #   let(:published_article) { create(:published_article) }
    #   let(:unpublished_article) { create(:unpublished_article) }
    #   it { expect(described_class.published).to include(published_article) }
    #   it { expect(described_class.published).to_not include(unpublished_article) }
    # end

  #   describe '.featured' do
  #     let(:featured_article) { create(:featured_article) }
  #     let(:unfeatured_article) { create(:unfeatured_article) }
  #     it { expect(described_class.featured).to include(featured_article) }
  #     it { expect(described_class.featured).to_not include(unfeatured_article) }
  #   end
  end

end
