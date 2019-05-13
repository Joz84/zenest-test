class CreateCalendars < ActiveRecord::Migration[5.2]
  def change
    create_table :calendars do |t|
      t.references :company, foreign_key: true
      t.integer :google_id
      t.string :name
      t.boolean :active, default: false
      t.boolean :payable, default: false

      t.timestamps
    end
  end
end
