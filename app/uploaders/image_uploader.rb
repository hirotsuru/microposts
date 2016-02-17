# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  
  include CarrierWave::MiniMagick

  process resize_to_limit: [400, 400]

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def filename
    super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
  end

  def filename
    time = Time.now
    name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
    name.downcase
  end

end
