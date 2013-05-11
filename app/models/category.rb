class Category < ActiveRecord::Base
  attr_accessible :category_name_lv, :category_name_ru , :category_slug

  has_many :places
  has_many :types

  translates :category_name

  scope :categories_all, includes(:types).limit(100)

  def display_name
    "#{self.category_name} (#{self.places_count})"
  end

  def self.recount
  	categories_base = Category.includes(:places).all

  	categories_base.each do |category|
  		c = category.places.where(approved:1).all.size
  		category.places_count = c
  		category.save
  	end 
  end
end
