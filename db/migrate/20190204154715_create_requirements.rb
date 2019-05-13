class CreateRequirements < ActiveRecord::Migration[5.2]
  def change
    create_table :requirements do |t|
      t.references :massage_category, foreign_key: true
      t.references :calendar_day, foreign_key: true
      t.integer :nb_praticiens
      t.monetize :amount

      t.timestamps
    end
  end
end
