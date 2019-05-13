# Fields of the model
# t.references :blog_article, foreign_key: true
# t.references :blog_tag, foreign_key: true

class BlogArticleTag < ApplicationRecord
  belongs_to :blog_article
  belongs_to :blog_tag
end
