class Category < ActiveRecord::Base
  attr_accessible :category_name, :slug, :translations_attributes
  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations

  translates :category_name

  accepts_nested_attributes_for :translations
end
