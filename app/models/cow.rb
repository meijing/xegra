class Cow < ActiveRecord::Base
  has_many :lactations
  has_many :reproductions
  belongs_to :user
  
  attr_accessible :father, :name, :num_borns, :ring, :date_born, :short_ring, :is_milk
  validates :ring, :presence => true, :length => { :is => 14 }
  validates :num_borns, :presence => true
  validates_length_of :num_borns, :minimum => 0

  scope :is_active, lambda {
    where('is_active=1')
  }

  def self.get_notification_lactation(current_user)
    @notifications = []

    @start_date = DateTime.now - 7.months - 1.day
    @end_date = DateTime.now.advance(:days => 5) - 7.months + 1.day

    @reproductions = current_user.reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])
    
    @reproductions.each do |r|
      if r.cow.is_milk
        @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
      end
    end

    return @notifications
  end

  def self.get_notification_parturition(current_user)
    @notifications = []

    @start_date = DateTime.now - 9.months - 1.day
    @end_date = DateTime.now.advance(:days => 5) - 9.months + 1.day

    @reproductions = current_user.reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @reproductions.each do |r|
      @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
    end
    return @notifications
  end

  def get_last_insemination(current_user)
    return current_user.reproduction.where('cow_id = '+self.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+self.id.to_s+' and reproduction_simbol_id = 6)')
  end

  def get_last_parturitiun(last_insemination, current_user)
    return current_user.reproduction.order('date desc').find(:all,:conditions=>['cow_id = ? and date between ? and ? and reproduction_simbol_id = 1 or reproduction_simbol_id=2',self.id,last_insemination.date,DateTime.now])
  end

  def set_is_pregnant(is_or_not_pregnant)
    self.update_column('is_pregnant',is_or_not_pregnant)
  end

  def set_last_failed_insemination(date)
    self.update_column('last_failed_insemination',date)
  end

  def increment_num_borns
    self.update_column('num_borns',self.num_borns + 1)
  end

  def decrement_num_borns
    if (self.num_borns.to_i - 1) > 0
      self.update_column('num_borns',self.num_borns.to_i - 1)
    end
  end

  def set_ring_data
    self.is_active=1
    self.short_ring = self.ring[self.ring.length-4..self.ring.length]
  end
end
