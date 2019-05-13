class AddSlugToBlogArticle < ActiveRecord::Migration[5.2]
  def change
    add_column :blog_articles, :slug, :string
    add_index :blog_articles, :slug, unique: true
    add_column :blog_authors, :slug, :string
    add_index :blog_authors, :slug, unique: true
    add_column :blog_tags, :slug, :string
    add_index :blog_tags, :slug, unique: true
  end
end
