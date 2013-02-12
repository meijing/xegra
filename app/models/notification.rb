class Notification < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :cow
  attr_accessible :start_date, :end_date, :description, :cow_id

end
