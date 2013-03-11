class Place < ActiveRecord::Base

  before_save{|place| place.email = place.downcase.email}

  attr_accessible :aproved, :city, :country, :email, :manytypes,
  	 :message, :name, :phone, :street, :type, :website, :translations_attributes

  translates :message, :name, :type

  
  accepts_nested_attributes_for :translations

  validates :email,
   :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
   :presence => true, :uniqueness => true


  validates :city, :country, :name, :presence => true, :length => { :in => 4..249 }
  validates :website, :phone, :name, :uniqueness => true
end
