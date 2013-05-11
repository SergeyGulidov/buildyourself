class Type < ActiveRecord::Base
  attr_accessible :type_slug, :type_name, :type_name_ru, :type_name_lv, :category_id
  belongs_to :category
  has_many :places

  
  translates :type_name

  validates :type_name, :presence => true, :length => { :in => 3..200 }

  scope :types_all, limit(100)
  
  def display_name
    "#{self.type_name} (#{self.places_count}) "
  end

  def self.recount
  	types_base = Type.includes(:places).all

  	types_base.each do |type|
  		c = type.places.where(approved:1).all.size
  		type.places_count = c
  		type.save
  	end 
  end


end
