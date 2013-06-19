class Request < ActiveRecord::Base
  require 'file_size_validator' 
  attr_accessible :address, :phone, :photos_attributes, :email, :message, :source_1, :source_2, :source_3, :source_4, :website, :simple_place, :age_min, :age_max

  validates :address, :presence => true
  validates :simple_place, :presence => true
  validates :age_min, :presence => true, :numericality => true, :length => { :maximum => 3, :minimum => 1 }
  validates :age_max, :presence => true, :numericality => true, :length => { :maximum => 3, :minimum => 1 }
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
      :maximum => 20.megabytes.to_i 
    } 
end
