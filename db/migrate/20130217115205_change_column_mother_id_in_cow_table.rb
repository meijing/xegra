class ChangeColumnMotherIdInCowTable < ActiveRecord::Migration
  def up
    rename_column :kine, :mother_in_farm, :parent_id
  end

  def down
    rename_column :kine, :parent_id, :mother_in_farm
  end
end
