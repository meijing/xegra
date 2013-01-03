class Reproduction < ActiveRecord::Base
  belongs_to :cow
  belongs_to :reproduction_simbol
  belongs_to :user
  attr_accessible :comment, :month, :year

  scope :actual_year, lambda {
    where('year = '+DateTime.now.year.to_s)
  }

  def check_is_pregnant(current_user)
    p '------------------------'
    p ' entra is preg'
    @last_insemination = self.cow.get_last_insemination(current_user)
    p 'volve las'
    p @last_insemination
    @exists_born = nil
    if !@last_insemination[0].nil?
      @exists_born = self.cow.get_last_parturitiun(@last_insemination[0], current_user)
    end
    p 'volves part'
    if !@exists_born.nil? && @exists_born.length <= 1
      @num_months_pregnant = DateTime.now.month - @last_insemination[0].date.month
      if @num_months_pregnant < 9
        self.cow.set_is_pregnant(1)
      else
        self.cow.set_is_pregnant(nil)
      end
    end
  end
end
