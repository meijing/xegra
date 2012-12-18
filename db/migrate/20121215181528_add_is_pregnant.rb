class AddIsPregnant < ActiveRecord::Migration
  def up
    add_column :kine, :is_pregnant, :integer
  end

  def down
    remove_column :kine, :is_pregnant
  end
end
