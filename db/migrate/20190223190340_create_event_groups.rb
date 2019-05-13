class CreateEventGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :event_groups do |t|
      t.references :calendar, foreign_key: true
      t.references :massage_category, foreign_key: true
      t.references :room, foreign_key: true
      t.text :description
      t.string :photo
      t.monetize :price
      t.string :title
      t.integer :duration
      t.integer :massage_by_slot
      t.time :morning_date
      t.integer :morning_duplication, default: 0
      t.time :afternoon_date
      t.integer :afternoon_duplication, default: 0
      t.integer :max_attendees, default: 15
      t.integer :min_attendees, default: 1
      t.timestamps
    end
  end
end
