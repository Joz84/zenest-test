class AddEmailExtensionActiveToCompanies < ActiveRecord::Migration[5.2]
  def change
    add_column :companies, :email_extension_active, :boolean, default: false
  end
end
