# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::ImageOptimizer
  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  
  process :resize_to_limit => [700, 700], :if => :request?
  process :optimize, :if => :request?

   version :thumb, :if => :request? do
     process :resize_to_fill => [100, 60]
     process :optimize
   end

   def extension_white_list
     %w(jpg jpeg gif png)
   end

   def request?(image)
      return false
   end

end
