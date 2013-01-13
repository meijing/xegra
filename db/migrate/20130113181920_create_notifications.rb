class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.references :cow
      t.date :start_date
      t.date :end_date
      t.string :description

      t.timestamps
    end
  end
end
