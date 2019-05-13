class AddMorningToDefaultEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :default_events, :morning, :boolean
  end
end
