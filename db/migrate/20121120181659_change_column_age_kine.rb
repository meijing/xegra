class ChangeColumnAgeKine < ActiveRecord::Migration
  def up
    remove_column :kine, :years
    add_column :kine, :date_born,    :date
  end

  def down
    remove_column :kine, :date_born
    add_column :kine, :years,    :integer
  end
end
