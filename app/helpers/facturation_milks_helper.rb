module FacturationMilksHelper

  def get_array_days_of_month(last_day)
    @days = []
    (1..last_day).each do |d|
      @days << d
    end
    
    return @days
  end
end
