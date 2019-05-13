# Fields of the model
# t.string :title
# t.text :content
# t.references :blog_article, foreign_key: true

class BlogMetum < ApplicationRecord
  belongs_to :blog_article, optional: true
end
