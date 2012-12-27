class FacturationMilk < ActiveRecord::Base
  attr_accessible :date, :liters
  belongs_to :user

  def self.get_totals_for_month(current_user)
    @cont_liters = []
    (1..12).each do |m|
      @initial_date = DateTime.now.year.to_s+"-12-01"
      @initial_date = @initial_date.to_date
      @month_to_rest = @initial_date.month - m.to_i
      @start_date = @initial_date.ago(@month_to_rest.months).beginning_of_month
      @end_date = @initial_date.ago(@month_to_rest.months).end_of_month

      @total_fact_month = current_user.FacturationMilk.sum(:liters, :conditions=>["date between ? and ? ",@start_date,@end_date])
      @cont_liters[m-1]=@total_fact_month
    end

    @sum_total_year = 0
    @cont_liters.each do |l|
      @sum_total_year = @sum_total_year + l.to_i
    end

    @cont_liters[12] = @sum_total_year
    return @cont_liters
  end
end
