class CreateCalendarDays < ActiveRecord::Migration[5.2]
  def change
    create_table :calendar_days do |t|
      t.references :calendar, foreign_key: true
      t.date :date
      t.integer :nb_praticiens

      t.timestamps
    end
  end
end
