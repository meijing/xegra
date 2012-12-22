class AddReferencesUserCow < ActiveRecord::Migration
  def up
    add_column :kine, :user_id , :integer ,:references=>"User"
  end

  def down
    remove_column :kine, :user_id
  end
end
