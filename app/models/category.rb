class Category < ActiveRecord::Base
	attr_accessible :category_name, :category_slug

  has_many :categorizations
  has_many :types, through: :categorizations
  has_many :places, through: :categorizations
  has_many :age_categories, through: :categorizations

  translates :category_name

end
