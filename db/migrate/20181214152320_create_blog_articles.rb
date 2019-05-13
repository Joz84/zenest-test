class CreateBlogArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_articles do |t|
      t.string :title
      t.text :content
      t.string :photo
      t.datetime :published_at
      t.integer :status, default: 0
      t.references :blog_author, foreign_key: true

      t.timestamps
    end
  end
end
