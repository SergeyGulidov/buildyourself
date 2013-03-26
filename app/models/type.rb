class Type < ActiveRecord::Base
  attr_accessible :translations_attributes, :category, :slug, :title
  has_many :assignments
  has_many :places, through: :assignments

  #acts_as_gmappable

  translates :title, :category
  accepts_nested_attributes_for :translations

  validates :title, :presence => true, :length => { :in => 3..200 }

  scope :all, order("title desc")

  def to_param
    "#{id}-#{slug}".parameterize
  end
end
