class AddRelationsUserReproduction < ActiveRecord::Migration
  def up
    add_column :reproductions, :user_id , :integer ,:references=>"User"
  end

  def down
    remove_column :reproductions, :user_id
  end
end
