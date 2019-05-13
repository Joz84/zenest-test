# Fields of the model
# t.string :name
# t.string :slug

class BlogTag < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :blog_article_tags, dependent: :destroy
  has_many :blog_articles, through: :blog_article_tags

  def self.display_tags
    self.all.map{ |tag| "##{tag.name.downcase}"}.join(' ')
  end

  def self.display_tags_with_coma
    self.pluck(:name).join(', ')
  end

end
