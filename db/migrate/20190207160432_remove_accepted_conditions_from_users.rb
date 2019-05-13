class RemoveAcceptedConditionsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :accepted_conditions, :boolean
  end
end
