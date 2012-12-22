class AddRelationUserFacturationMilk < ActiveRecord::Migration
  def up
    add_column :facturation_milks, :user_id , :integer ,:references=>"User"
  end

  def down
    remove_column :facturation_milks, :user_id
  end
end
