class Category < ActiveRecord::Base
  attr_accessible :category_name_lv, :category_name_ru , :category_slug

  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations

  translates :category_name

  scope :categories_all, lambda { includes(:types).all }

  def add_count
  	self.count_all += 1
    self.save
  end

  def minus_count
  	self.count_all -= 1
    self.save
  end
  
  def display_name
    "#{self.category_name} (#{self.places.size}) "
  end
end
