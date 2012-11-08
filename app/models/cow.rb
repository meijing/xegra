class Cow < ActiveRecord::Base
  has_many :reproduction
  attr_accessible :father, :name, :num_borns, :ring, :years, :short_ring, :is_milk
  validates :ring, :presence => true, :uniqueness => true
  #, :length => { :is => 6 }
  validates :years, :is_milk, :num_borns, :presence => true
  validates_length_of :years, :minimum => 0

end
