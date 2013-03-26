class Type < ActiveRecord::Base
  attr_accessible :translations_attributes, :slug, :title
  has_many :assignments
  has_many :places, through: :assignments

  has_many :categories, through: :categorizations

  #acts_as_gmappable

  translates :title
  accepts_nested_attributes_for :translations

  validates :title, :presence => true, :length => { :in => 3..200 }

  scope :all, order("title desc")

  def to_param
    "#{id}-#{slug}".parameterize
  end
end
