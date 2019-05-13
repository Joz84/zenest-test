class ChangeLinkToAvailability < ActiveRecord::Migration[5.2]
  def change
    remove_reference :availabilities, :calendar_day, index: true, foreign_key: true
    add_reference :availabilities, :requirement, index: true, foreign_key: true
    remove_column :calendar_days, :nb_praticiens
  end
end
