class Location < ActiveRecord::Base
  attr_accessible :city_lv, :city_ru, :country_lv, :country_ru, :location_slug

  has_many :categorizations

  has_many :types,      through: :categorizations
  has_many :places,     through: :categorizations
  has_many :categories, through: :categorizations
  has_many :intervals,  through: :categorizations


  translates :city, :country

end
