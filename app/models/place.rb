class Place < ActiveRecord::Base
  has_many :assignments
  has_many :types, through: :assignments

  has_many :photos

  acts_as_gmappable

  before_save{|place| place.email = place.email.downcase}

  attr_accessible :aproved, :city, :country, :email, :manytypes,
  	 :message, :name, :phone, :street, :website, :translations_attributes,
     :type_ids, :photos_attributes, :photo


  translates :message

  accepts_nested_attributes_for :translations, :photos

   validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true, :uniqueness => true


   validates :city, :country, :name, :presence => true, :length => { :in => 4..249 }
   validates :phone, :name, :uniqueness => true


   scope :recent, order("created_at desc").limit(10)

   def gmaps4rails_address
    "#{street}, #{city}, #{country}" 
   end


end
