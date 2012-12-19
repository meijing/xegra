class ChangeCowIdFromLactation < ActiveRecord::Migration
  def up
    remove_column :lactations, :cow_id
    add_column :lactations, :cow_id , :integer ,:references=>"cow"
  end

  def down
    add_column :lactations, :cow_id, :integer
    remove_column :lactations, :cow_id
  end
end
