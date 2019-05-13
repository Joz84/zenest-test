class CreateAttendees < ActiveRecord::Migration[5.2]
  def change
    create_table :attendees do |t|
      t.references :employee, foreign_key: true
      t.references :event, foreign_key: true
      t.integer :status, default: 0
      t.monetize :price
      t.text :payment_json

      t.timestamps
    end
  end
end
