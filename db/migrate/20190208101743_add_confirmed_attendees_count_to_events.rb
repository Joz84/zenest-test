class AddConfirmedAttendeesCountToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :confirmed_attendees_count, :integer, default: 0
  end
end
