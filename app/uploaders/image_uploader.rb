# encoding: utf-8
require 'carrierwave/processing/mini_magick'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  #--Use Heroku's temp folder for uploads--#
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end
  #--For development and testing--#
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  #--Process files as they are uploaded--#
  process :resize_to_fit => [960, 960]
  #--Create different versions of your uploaded files--#
  #--Thumnails--#
  version :small do
    process :resize_to_fit => [24, 24]
  end

  version :medium do
    process :resize_to_fit => [48, 48]
  end

  version :large do
    process :resize_to_fit => [96, 96]
  end

  #--Images for posts--#
  version :post_image do
    process :resize_to_fit => [600, 600]
  end

  #--Image file extension white list--#
  def extension_white_list
    %w(jpg jpeg gif png)
  end

end

