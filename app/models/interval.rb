class Interval < ActiveRecord::Base
  attr_accessible :interval_name_lv, :interval_name_ru, :interval_slug

  has_many :categorizations

  #has_many :types, through: :categorizations
  has_many :places, through: :categorizations
  #has_many :categories, through: :categorizations
  #has_many :locations, through: :categorizations


  translates :interval_name

  scope :intervals_all, all

end
