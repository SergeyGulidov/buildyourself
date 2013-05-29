class Photo < ActiveRecord::Base
  require 'file_size_validator' 

  attr_accessible :image, :name, :place_id, :photo, :request_id
  belongs_to :place
  belongs_to :request
  mount_uploader :photo, PhotoUploader



  validates :photo, 
    #:presence => false, 
    :file_size => { 
      :maximum => 3.megabytes.to_i 
    } 
end
