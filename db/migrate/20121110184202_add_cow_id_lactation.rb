class AddCowIdLactation < ActiveRecord::Migration
  def up
    add_column :lactations, :cow_id, :integer
  end

  def down
    remove_column :lactations, :cow_id
  end
end
