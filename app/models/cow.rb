class Cow < ActiveRecord::Base
  has_many :lactations
  has_many :reproductions
  
  attr_accessible :father, :name, :num_borns, :ring, :date_born, :short_ring, :is_milk
  validates :ring, :presence => true, :uniqueness => true
  #, :length => { :is => 6 }
  validates :num_borns, :presence => true
  validates_length_of :num_borns, :minimum => 0

  scope :is_active, lambda {
    where('is_active=1')
  }

  def self.get_notification_lactation
    @notifications = []

    @start_date = DateTime.now.ago(7.months)
    @end_date = DateTime.now.advance(:days => 5).ago(7.months)

    @reproductions = Reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @reproductions.each do |r|
      if r.cow.is_milk
        @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
      end
    end
    return @notifications
  end

  def self.get_notification_parturition
    @notifications = []

    @start_date = DateTime.now.ago(9.months)
    @end_date = DateTime.now.advance(:days => 5).ago(9.months)

    @reproductions = Reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date,@end_date])

    @reproductions.each do |r|
      @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
    end
    return @notifications
  end

  def get_last_insemination
    return Reproduction.where('cow_id = '+self.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+self.id.to_s+' and reproduction_simbol_id = 6)')
  end

  def get_last_parturitiun(last_insemination)
    return Reproduction.find(:all,:conditions=>['cow_id = ? and date between ? and ? and reproduction_simbol_id = 1 or reproduction_simbol_id=2',self.id,last_insemination.date,DateTime.now])
  end
end
