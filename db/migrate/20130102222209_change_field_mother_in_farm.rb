class ChangeFieldMotherInFarm < ActiveRecord::Migration
  def up
    remove_column :kine, :is_mother_in_farm
    add_column :kine, :mother_in_farm , :integer ,:references=>"cow"
  end

  def down
    add_column :kine, :is_mother_in_farm , :boolean
    remove_column :kine, :mother_in_farm
  end
end
