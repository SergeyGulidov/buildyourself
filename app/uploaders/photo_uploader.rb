# encoding: utf-8

class PhotoUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.place_id}"
  end



  process :resize_to_fill => [700, 700]

   version :thumb do
     process :resize_to_fill => [100, 60]
   end

   def extension_white_list
     %w(jpg jpeg gif png)
   end
end
