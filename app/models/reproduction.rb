class Reproduction < ActiveRecord::Base
  belongs_to :cow
  belongs_to :reproduction_simbol
  attr_accessible :comment, :month, :year
end
