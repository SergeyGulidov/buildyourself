# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include CarrierWave::ImageOptimizer
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


   process :resize_to_fit => [700, 700]
   


   version :thumb do
     process :resize_to_fill => [250, 150]
     process :optimize
   end

   def extension_white_list
     %w(jpg jpeg gif png)
   end




end
