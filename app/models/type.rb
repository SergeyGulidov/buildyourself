class Type < ActiveRecord::Base
  attr_accessible :translations_attributes
  has_many :assignments
  has_many :places, through: :assignments

  translates :title
  accepts_nested_attributes_for :translations

  validates :title, :presence => true, :length => { :in => 3..200 }

  scope :all, order("title desc")
end
