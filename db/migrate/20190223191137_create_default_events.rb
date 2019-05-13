class CreateDefaultEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :default_events do |t|
      t.references :event_group, foreign_key: true
      t.datetime :start_date
      t.datetime :end_date
      t.references :massage_category, foreign_key: true
      t.references :room, foreign_key: true
      t.text :description
      t.string :photo
      t.monetize :price
      t.string :title
      t.integer :max_attendees, default: 15
      t.integer :min_attendees, default: 1
      t.timestamps
    end
  end
end
