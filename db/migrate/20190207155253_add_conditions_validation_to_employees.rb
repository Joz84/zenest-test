class AddConditionsValidationToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :conditions_validation, :boolean, default: false
  end
end
