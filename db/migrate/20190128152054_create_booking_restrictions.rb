class CreateBookingRestrictions < ActiveRecord::Migration[5.2]
  def change
    create_table :booking_restrictions do |t|
      t.references :company, foreign_key: true
      t.references :massage_category, foreign_key: true
      t.integer :periodicity, default: 0
      t.integer :rate

      t.timestamps
    end
  end
end
