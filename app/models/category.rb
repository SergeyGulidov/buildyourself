class Category < ActiveRecord::Base
  attr_accessible :category_name_lv, :category_name_ru , :category_slug

  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations

  translates :category_name

  scope :categories_all, includes(:types).all

  def display_name
    "#{self.category_name} (#{self.places.where(approved: 1).size})"
  end
end
