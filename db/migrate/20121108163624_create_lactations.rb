class CreateLactations < ActiveRecord::Migration
  def change
    create_table :lactations do |t|
      t.integer :greasy_kg
      t.integer :protein_kg
      t.float :greasy_percentage
      t.float :protein_percentage
      t.integer :cell
      t.date :date
      t.integer :lactation_duration
      t.integer :milk_kg

      t.timestamps
    end
  end
end
