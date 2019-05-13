class CreateMassageCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :massage_categories do |t|
      t.string :name
      t.string :photo
      t.boolean :individual, default: false
      t.monetize :price

      t.timestamps
    end
  end
end
