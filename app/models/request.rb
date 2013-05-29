class Request < ActiveRecord::Base
  require 'file_size_validator' 
  attr_accessible :address, :phone, :photos_attributes, :email, :message, :source_1, :source_2, :source_3, :source_4

  validates :address, :presence => true
  validates :phone, :presence => true, :numericality => true, :length => { :maximum => 12, :minimum => 8 }

  validates :email,
    :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create },
    :presence => true

  validates :message, :presence => true

  mount_uploader :source_1, SourceUploader
  mount_uploader :source_2, SourceUploader
  mount_uploader :source_3, SourceUploader
  mount_uploader :source_4, SourceUploader



  validates :source_1, :source_2, :source_3, :source_4, 
    #:presence => false,
    :allow_blank => true,
    :file_size => { 
      :maximum => 3.megabytes.to_i 
    } 
end
