class Category < ActiveRecord::Base
  attr_accessible :category_name_lv, :category_name_ru , :category_slug

  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations
  #has_many :intervals, through: :categorizations
  #has_many :locations, through: :categorizations

  translates :category_name

  scope :categories_all, find(:all)

end
