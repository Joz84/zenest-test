require 'rails_helper'

# Fields of the model
# t.string :title
# t.text :content
# t.references :blog_article, foreign_key: true

RSpec.describe BlogMetum, type: :model do
  describe 'fields' do
    it { is_expected.to respond_to(:title) }
    it { is_expected.to respond_to(:content) }
    it { is_expected.to respond_to(:blog_article) }
  end
   describe 'associations' do
    it { is_expected.to belong_to(:blog_article) }
  end

end
