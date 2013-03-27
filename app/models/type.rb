class Type < ActiveRecord::Base
  attr_accessible :type_slug, :type_name, :type_name_ru, :type_name_lv
  has_many :assignments
  has_many :places, through: :assignments

  has_many :categories, through: :categorizations
  has_many :intervals, through: :categorizations

  #acts_as_gmappable

  translates :type_name

  validates :type_name, :presence => true, :length => { :in => 3..200 }


  def to_param
    "#{id}-#{type_slug}".parameterize
  end
end
