class CreateAvailabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :availabilities do |t|
      t.integer :status, default: 0
      t.references :praticien, foreign_key: true
      t.references :calendar_day, foreign_key: true

      t.timestamps
    end
  end
end
