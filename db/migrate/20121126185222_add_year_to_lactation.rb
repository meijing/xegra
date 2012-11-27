class AddYearToLactation < ActiveRecord::Migration
  def up
    add_column :lactations, :year, :integer
  end

  def down
    remove_column :lactations, :year
  end
end
