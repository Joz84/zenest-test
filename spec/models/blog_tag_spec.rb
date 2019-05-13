require 'rails_helper'

# Fields of the model
# t.string :name
# t.string :slug


RSpec.describe BlogTag, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:slug) }
  end
   describe 'associations' do
    it { is_expected.to have_many(:blog_articles) }
    it { is_expected.to have_many(:blog_article_tags) }
  end
end
