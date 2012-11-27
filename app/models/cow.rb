class Cow < ActiveRecord::Base
  has_many :lactation
  has_many :reproduction
  
  attr_accessible :father, :name, :num_borns, :ring, :date_born, :short_ring, :is_milk
  validates :ring, :presence => true, :uniqueness => true
  #, :length => { :is => 6 }
  validates :num_borns, :presence => true
  validates_length_of :num_borns, :minimum => 0

end
