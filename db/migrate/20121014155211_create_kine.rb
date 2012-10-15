class CreateKine < ActiveRecord::Migration
  def change
    create_table :kine do |t|
      t.string :ring
      t.string :name
      t.integer :years
      t.integer :num_borns
      t.string :father

      t.timestamps
    end
  end
end
