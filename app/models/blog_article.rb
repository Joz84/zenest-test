# Fields of the model
# t.string :title
# t.text :content
# t.string :slug
# t.string :photo
# t.datetime :published_at
# t.integer :status
# t.references :blog_author, foreign_key: true

class BlogArticle < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged

  enum status: { active: 0, archived: 1}

  belongs_to :author, class_name: 'BlogAuthor', foreign_key: 'blog_author_id', optional: true
  has_many :blog_meta, dependent: :destroy
  has_many :blog_article_tags, dependent: :destroy
  has_many :blog_tags, through: :blog_article_tags

  accepts_nested_attributes_for :blog_meta, allow_destroy: true

  mount_uploader :photo, PhotoUploader

  scope :ordered_by_published_at, -> { order(published_at: :desc) }

end
