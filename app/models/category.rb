class Category < ActiveRecord::Base
  attr_accessible :category_name_lv, :category_name_ru , :category_slug

  has_many :places
  has_many :types

  translates :category_name

  scope :categories_all, includes(:types).limit(100)

  def display_name
    "#{self.category_name} (#{self.places.where(approved: 1).all.size})"
  end
end
