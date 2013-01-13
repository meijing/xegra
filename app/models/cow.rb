class Cow < ActiveRecord::Base
  has_many :lactations
  has_many :reproductions
  belongs_to :user
  belongs_to :mother, :class_name => 'Cow', :foreign_key => 'mother_in_farm'
  has_many :children, :class_name => 'Cow', :foreign_key => 'mother_in_farm'
  
  attr_accessible :father, :name, :num_borns, :ring, :date_born, :short_ring, :is_milk, :ring_mother, :mother_in_farm
  validates :ring, :presence => true, :length => { :is => 14 }
  validates :name,:date_born,:num_borns, :presence => true
  validates_length_of :num_borns, :minimum => 0

  after_create :set_ring_data

  scope :is_active, lambda {
    where('is_active=1')
  }

  scope :is_pregnant, lambda {
    where('is_pregnant = 1')
  }

  scope :is_not_pregnant, lambda {
    where('is_pregnant = 0 or is_pregnant is null')
  }

  scope :is_milk, lambda {
    where({is_milk: true})
  }

  scope :is_not_milk, lambda {
    where({is_milk: false})
  }

  scope :without_born, lambda {
    where('num_borns = 0')
  }

  scope :with_born, lambda {
    where('num_borns > 0')
  }

  def self.get_notification_lactation(current_user)
    @notifications = []
    
    @start_date = DateTime.now - 7.months - 1.day
    @end_date = DateTime.now.advance(:days => 5) - 7.months + 1.day

    #@reproductions = current_user.reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date.to_date,@end_date.to_date])
    @reproductions = current_user.reproduction.joins('join reproductions r on r.cow_id = reproductions.cow_id').find(:all, :conditions=>["reproductions.date between ? and ? and reproductions.date = (select max(re.date) from reproductions re where re.cow_id = reproductions.cow_id and re.reproduction_simbol_id = 6)",@start_date.to_date,@end_date.to_date])

    @reproductions.each do |r|
      if r.cow.is_milk && r.cow.is_pregnant == 1 && r.cow.is_active == 1 && r.cow.num_borns>0
        @notifications << [r.cow.id, r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")]
      end
    end
    
    return @notifications
  end

  def self.get_notification_parturition(current_user)
    @notifications = []

    @start_date = DateTime.now - 9.months - 1.day
    @end_date = DateTime.now.advance(:days => 5) - 9.months + 1.day

    @reproductions = current_user.reproduction.find(:all, :conditions=>["date between ? and ? ",@start_date.to_date,@end_date.to_date])

    @reproductions.each do |r|
      if r.cow.is_pregnant == 1 && r.cow.is_active == 1
        @notifications << r.cow.short_ring.to_s+' ('+r.cow.name+') - '+r.date.strftime("%d/%m/%Y")
      end
    end
    return @notifications
  end

  def self.watch_inseminations(current_user)
    @notifications = []
    @not_from_born = []
    @not_last_part = []

    current_user.cow.is_active.each do |cow|
      @last_ins = cow.get_last_insemination(current_user)
      @diff_days = (DateTime.now.to_date - cow.date_born).to_i
    
      if @diff_days > 445 && @diff_days < 460 && cow.num_borns == 0 && @last_ins==[]
        @not_from_born << cow.name + ' (' + cow.short_ring.to_s + '): ' + (@diff_days/30.0).ceil.to_s
      end

      if !@last_ins.nil? && @last_ins != [] && cow.num_borns > 0
        @last_parturition = cow.get_last_parturitiun(@last_ins[0], current_user)
        if !@last_parturition.nil? && @last_parturition != []
          @diff_days_part = (DateTime.now.to_date - @last_parturition[0].date.to_date).to_i
          p @diff_days_part
          if @diff_days_part > 35 && @diff_days_part < 43
            @not_last_part << cow.name + ' (' + cow.short_ring.to_s + '): ' + @diff_days_part.to_s
          end
        end
      end
    end

    @notifications << @not_from_born
    @notifications << @not_last_part
    p @notifications
  end

  def get_last_insemination(current_user)
    return current_user.reproduction.where('cow_id = '+self.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+self.id.to_s+' and reproduction_simbol_id = 6)')
  end

  def get_date_last_insemination(current_user)
    @last = current_user.reproduction.where('cow_id = '+self.id.to_s+' and date = (select max(date) from reproductions where cow_id = '+self.id.to_s+' and reproduction_simbol_id = 6)')
    if !@last.nil?
      return @last.first.date
    end
  end

  def get_last_parturitiun(last_insemination, current_user)
    return current_user.reproduction.find(:all, :conditions=>["cow_id = ? and date between ? and ?  and (reproduction_simbol_id = 1 or reproduction_simbol_id=2 or reproduction_simbol_id=3 or reproduction_simbol_id=4)",self.id, last_insemination.date.to_date.to_s,(DateTime.now+ 1.day).to_date.to_s])
  end

  def set_is_pregnant(is_or_not_pregnant)
    self.update_column('is_pregnant',is_or_not_pregnant)
  end

  def set_last_failed_insemination(date)
    self.update_column('last_failed_insemination',date)
  end

  def set_is_milk(milk)
    self.update_column('is_milk',milk)
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
    self.save
  end

  def get_has_failed_insemination(current_user)
    @last_inse = self.get_last_insemination(current_user).first
    if !@last_inse.nil? && !self.last_failed_insemination.nil? && @last_inse.date.to_date == self.last_failed_insemination.to_date
      return true
    end
    return false
  end

  def get_has_not_borns
    if self.num_borns.nil? || self.num_borns == 0
      return true
    end
    return false
  end

  def set_mother(mother_farm, mother_text)
    if !mother_farm.nil? && mother_farm != '-1'
      self.mother_in_farm = mother_farm
      self.ring_mother = ''
    elsif !mother_text.nil?
      self.ring_mother = mother_text
      self.mother_in_farm = nil
    end
  end

  def save_mother_when_down
    @name = self.name.concat(' (').concat(self.short_ring.to_s).concat(')')
    self.children.each do |c|
      c.update_column('ring_mother', @name)
    end
  end

end
