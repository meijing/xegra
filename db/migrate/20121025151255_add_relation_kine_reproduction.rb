class AddRelationKineReproduction < ActiveRecord::Migration
  def up
    create_table :reproductions do |t|
      t.references :cow
      t.references :reproduction_simbol
      t.integer :year
      t.integer :month
      t.string :comment

      t.timestamps
    end
  end

  def down
    drop table :reproductions
  end
end
