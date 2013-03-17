class Photo < ActiveRecord::Base
	require 'file_size_validator' 

  attr_accessible :image, :name, :place_id, :photo
  belongs_to :place
  mount_uploader :photo, PhotoUploader

  validates :photo, 
    :presence => true, 
    :file_size => { 
      :maximum => 2.megabytes.to_i 
    } 
end
