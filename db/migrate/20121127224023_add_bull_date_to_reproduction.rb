class AddBullDateToReproduction < ActiveRecord::Migration
  def change
    add_column :reproductions, :bull, :string
    add_column :reproductions, :date, :date
  end
end
