class ChangeIsActveCow < ActiveRecord::Migration
  def up
    remove_column :kine, :is_active
    add_column :kine, :is_active, :integer
  end

  def down
    remove_column :kine, :is_active
    add_column :kine, :is_active, :integer
  end
end
