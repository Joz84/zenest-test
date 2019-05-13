class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true
      t.integer :stripe_id
      t.boolean :admin_company, default: false
      t.string :matricule
      t.text :complement_infos

      t.timestamps
    end
  end
end
