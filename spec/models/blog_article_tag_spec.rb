require 'rails_helper'

# Fields of the model
# t.references :blog_article, foreign_key: true
# t.references :blog_tag, foreign_key: true

RSpec.describe BlogArticleTag, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:blog_tag) }
    it { is_expected.to respond_to(:blog_article) }
  end
   describe 'associations' do
    it { is_expected.to belong_to(:blog_article) }
    it { is_expected.to belong_to(:blog_tag) }
  end
end
