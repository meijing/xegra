class AddFieldMother < ActiveRecord::Migration
  def up
    add_column :kine, :ring_mother , :string
    add_column :kine, :is_mother_in_farm , :boolean
  end

  def down
    remove_column :kine, :ring_mother
    remove_column :kine, :is_mother_in_farm
  end
end
