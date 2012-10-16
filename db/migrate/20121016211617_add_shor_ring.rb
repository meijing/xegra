class AddShorRing < ActiveRecord::Migration
  def up
    add_column :kine, :short_ring,    :integer
  end

  def down
    remove_column :kine, :short_ring
  end
end
