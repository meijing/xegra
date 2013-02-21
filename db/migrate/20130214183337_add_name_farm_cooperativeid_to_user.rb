class AddNameFarmCooperativeidToUser < ActiveRecord::Migration
  def up
    add_column :users, :farm_name , :string
    add_column :users, :cooperative_id , :integer ,:references=>"cooperative"
  end

  def down
    remove_column :users, :farm_name
    remove_column :users, :cooperative_id
  end
end
