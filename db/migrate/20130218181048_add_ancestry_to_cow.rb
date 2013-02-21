class AddAncestryToCow < ActiveRecord::Migration
  def up
    add_column :kine, :ancestry , :string
    add_index :kine, :ancestry
  end

  def down
    remove_column :kine, :ancestry
    remove_index :kine, :ancestry
  end
end
