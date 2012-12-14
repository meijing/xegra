class CreateFacturationMilks < ActiveRecord::Migration
  def change
    create_table :facturation_milks do |t|
      t.date :date
      t.integer :liters

      t.timestamps
    end
  end
end
