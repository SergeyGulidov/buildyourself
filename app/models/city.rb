class City < ActiveRecord::Base
  attr_accessible :city_name_lv, :city_name_ru, :city_slug
  has_many :places
  
  translates :city_name

  scope :cities_all, all


  def add_count
    self.count_all += 1
    self.save
  end

  def minus_count
    self.count_all -= 1
    self.save
  end

  def display_name
    "#{self.city_name} (#{self.places.where(approved: 1).size}) "
  end
end