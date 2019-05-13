class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :company, foreign_key: true
      t.string :name
      t.integer :capacity

      t.timestamps
    end
  end
end
