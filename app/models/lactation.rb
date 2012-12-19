class Lactation < ActiveRecord::Base
  belongs_to :cow
  attr_accessible :cell, :date, :greasy_kg, :greasy_percentage, :lactation_duration, :milk_kg, :protein_kg, :protein_percentage, :cow_id
  validates :cell, :date, :greasy_kg, :greasy_percentage, :lactation_duration, :milk_kg, :protein_kg, :protein_percentage, :presence => true

  scope :for_month, lambda {|month|
    
    @month_to_rest = DateTime.now.month - month.to_i
    @start_date = DateTime.now.ago(@month_to_rest.months).beginning_of_month
    @end_date = DateTime.now.ago(@month_to_rest.months).end_of_month
    
    where("date between ? and ?",@start_date, @end_date)
  }
end
