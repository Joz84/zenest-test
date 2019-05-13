class AddCancelledAttendeesCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :cancelled_attendees_count, :integer, default: 0
  end
end
