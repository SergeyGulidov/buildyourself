class Place < ActiveRecord::Base
  attr_accessible :aproved, :city, :country, :email, :manytypes, :message, :name, :phone, :street, :type, :website
  translates :message, :name, :type
  attr_accessible :translations_attributes
  accepts_nested_attributes_for :translations
end
