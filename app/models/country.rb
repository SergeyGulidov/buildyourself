class Country < ActiveRecord::Base
  attr_accessible :country_name_lv, :country_name_ru, :country_slug
  has_many :places
  has_many :byways
  
  translates :country_name

  scope :countries_all, all
end