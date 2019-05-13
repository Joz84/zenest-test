require 'rails_helper'


# Fields of the model
# t.string :first_name
# t.string :last_name
# t.string :slug

RSpec.describe BlogAuthor, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:first_name) }
    it { is_expected.to respond_to(:last_name) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:slug) }
  end
   describe 'associations' do
    it { is_expected.to have_many(:blog_articles) }
  end

end
