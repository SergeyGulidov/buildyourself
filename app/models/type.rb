class Type < ActiveRecord::Base
  attr_accessible :type_slug, :type_name, :type_name_ru, :type_name_lv, :category_ids

  has_many :categorizations
  
  has_many :places,     through: :categorizations
  has_many :categories, through: :categorizations
  #has_many :intervals,  through: :categorizations
  #has_many :locations,  through: :categorizations

  #acts_as_gmappable

  translates :type_name

  validates :type_name, :presence => true, :length => { :in => 3..200 }

  scope :types_all, all

end
