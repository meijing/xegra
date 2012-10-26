class AddIsActivCowAndDate < ActiveRecord::Migration
  def up
    add_column :kine, :is_active, :boolean
    add_column :kine, :date_down, :date
  end

  def down
    remove_column :kine, :is_active
    remove_column :kine, :date_down
  end
end
