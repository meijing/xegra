class AddIsMilk < ActiveRecord::Migration
  def up
    add_column :kine, :is_milk,    :boolean
  end

  def down
    remove_column :kine, :is_milk
  end
end
