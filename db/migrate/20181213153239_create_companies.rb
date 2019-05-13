class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :address
      t.string :name
      t.string :siret
      t.string :city
      t.string :logo
      t.string :zipcode
      t.string :company_code
      t.integer :booking_max
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
