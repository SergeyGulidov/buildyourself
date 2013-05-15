class Request < ActiveRecord::Base
  attr_accessible :address, :phone, :photos_attributes, :photo, :email, :message

  validates :address, :presence => true
  validates :phone, :presence => true, :numericality => true, :length => { :maximum => 12, :minimum => 8 }


  has_many :photos, :dependent => :destroy
  accepts_nested_attributes_for :photos


  validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true,
    :uniqueness => true

  validates :message, :presence => true

end
