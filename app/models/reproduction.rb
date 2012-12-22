class Reproduction < ActiveRecord::Base
  belongs_to :cow
  belongs_to :reproduction_simbol
  belongs_to :user
  attr_accessible :comment, :month, :year

  def check_is_pregnant
    @last_insemination = self.cow.get_last_insemination
    @exists_born = self.cow.get_last_parturitiun(@last_insemination[0])
    if @exists_born.length <= 1
      @num_months_pregnant = DateTime.now.month - @last_insemination[0].date.month
      if @num_months_pregnant < 9
        self.cow.set_is_pregnant(1)
      else
        self.cow.set_is_pregnant(nil)
      end
    end
  end
end
