class CreateBlogAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :blog_authors do |t|
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
  end
end
