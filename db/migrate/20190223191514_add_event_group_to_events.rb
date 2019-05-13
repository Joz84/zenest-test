class AddEventGroupToEvents < ActiveRecord::Migration[5.2]
  def change
    add_reference :events, :event_group, foreign_key: true
  end
end
