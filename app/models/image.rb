require 'carrierwave/mongoid'
class Image
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected :_id

  embedded_in :post, :inverse_of => :images
  referenced_in :user

  field :title, :type => String

  mount_uploader :image, ImageUploader

  #--validations--#
  validates_presence_of :image

end

