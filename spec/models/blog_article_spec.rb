require 'rails_helper'

# Fields of the model
# t.string :title
# t.text :content
# t.string :photo
# t.string :slug
# t.datetime :published_at
# t.references :blog_author, foreign_key: true

RSpec.describe BlogArticle, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:photo) }
    it { is_expected.to respond_to(:published_at) }
    it { is_expected.to respond_to(:author) }
    it { is_expected.to respond_to(:slug) }
  end
   describe 'associations' do
    it { is_expected.to have_many(:blog_meta) }
    it { is_expected.to belong_to(:author) }
  end
end
