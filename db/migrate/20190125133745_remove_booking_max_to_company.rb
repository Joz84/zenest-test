class RemoveBookingMaxToCompany < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :booking_max
  end
end
