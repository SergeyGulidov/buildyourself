class Contact < ActiveRecord::Base
  attr_accessible :body, :email
  before_save{|contact| contact.email = contact.email.downcase}


  validates :email,
   :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
   :presence => true

  validates :body, :length => { :in => 5..1000 }


end
