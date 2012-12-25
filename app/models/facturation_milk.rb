class FacturationMilk < ActiveRecord::Base
  attr_accessible :date, :liters
  belongs_to :user
  
end
