class Notification < ActiveRecord::Base
  # attr_accessible :title, :body

  belongs_to :cow
  attr_accessible :start_date, :end_date, :description, :cow_id

  scope :is_active, lambda {
    where('active=1')
  }

  scope :is_desactive, lambda {
    where('active=0')
  }

  def self.check_custom_notifications
    @actual_date = DateTime.now.to_date
    @custom_notifications = Notification.find(:all, :conditions=>["? between start_date and end_date ",@actual_date])
    return @custom_notifications
  end

  def desactive
    self.active = 0
    self.update_column('active',0)
  end

  def active
    self.active = 1
    self.update_column('active',1)
  end
end
