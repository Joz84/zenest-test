class CreateCompetencies < ActiveRecord::Migration[5.2]
  def change
    create_table :competencies do |t|
      t.references :praticien, foreign_key: true
      t.references :massage_category, foreign_key: true

      t.timestamps
    end
  end
end
