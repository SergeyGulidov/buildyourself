class Interval < ActiveRecord::Base
  attr_accessible :interval_name, :interval_slug

  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations
  has_many :categories, through: :categorizations


  translates :interval_name

end
