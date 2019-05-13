class CreatePraticiens < ActiveRecord::Migration[5.2]
  def change
    create_table :praticiens do |t|
      t.integer :gender
      t.string :photo
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
