class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :birthday, :datetime
    add_column :users, :address, :string
    add_column :users, :zipcode, :string
    add_column :users, :city, :string
    add_column :users, :phone, :string
    add_column :users, :complement, :string
    add_reference :users, :actable, polymorphic: true, index: true
    add_column :users, :active, :boolean, default: true
    add_column :users, :accepted_conditions, :boolean, default: false
  end
end
