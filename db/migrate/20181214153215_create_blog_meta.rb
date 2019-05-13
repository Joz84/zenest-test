class CreateBlogMeta < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_meta do |t|
      t.string :title
      t.text :content
      t.references :blog_article, foreign_key: true

      t.timestamps
    end
  end
end
