class CreateBlogArticleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_article_tags do |t|
      t.references :blog_article, foreign_key: true
      t.references :blog_tag, foreign_key: true

      t.timestamps
    end
  end
end
