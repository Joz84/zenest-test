# Fields of the model
# t.string :first_name
# t.string :last_name
# t.string :slug

class BlogAuthor < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged
  has_many :blog_articles

  def name
    "#{first_name} #{last_name}"
  end
end
