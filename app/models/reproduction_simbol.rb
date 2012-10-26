class ReproductionSimbol < ActiveRecord::Base
  has_many :reproduction
  attr_accessible :meaning, :simbol
end
