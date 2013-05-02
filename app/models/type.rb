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

  scope :types_all, lambda { all }

  def add_count
    self.count_all += 1
    self.save
  end

  def minus_count
    self.count_all -= 1
    self.save
  end
  
  def display_name
    "#{self.type_name} (#{self.places.size}) "
  end
end
