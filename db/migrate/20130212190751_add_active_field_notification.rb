class AddActiveFieldNotification < ActiveRecord::Migration
  def up
    add_column :notifications, :active , :integer
  end

  def down
    remove_column :notifications, :active
  end
end
