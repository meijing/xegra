class AddLastFailedInsemination < ActiveRecord::Migration
  def up
  add_column :kine, :last_failed_insemination, :date
  end

  def down
    remove_column :kine, :last_failed_insemination
  end
end
