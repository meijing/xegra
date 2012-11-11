class Lactation < ActiveRecord::Base
  belongs_to :cow
  attr_accessible :cell, :date, :greasy_kg, :greasy_percentage, :lactation_duration, :milk_kg, :protein_kg, :protein_percentage, :cow_id
end
