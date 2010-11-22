require 'carrierwave/orm/mongoid'
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Voteable

  attr_protected  :_id
  #--Associations--#
  referenced_in   :user
  embeds_many     :comments
#  embeds_many     :images, :cascade_callbacks => true
#  accepts_nested_attributes_for :images
  mount_uploader :image, ImageUploader

  #--boolean values for controlling visability of posts--#
  field           :public,      :type => Boolean, :default => false
  field           :followers,   :type => Boolean, :default => true
  field           :private,     :type => Boolean, :default => false

  #--data fields--#
  field           :title
  field           :content

  #--validations--#
  validates       :title,
                  :presence => { :message => "Your post is empty, what are you doing?" },
                  :length => { :within => 2..140 } 
  validates       :content, 
                  :length => { :within => 2..512 }, 
                  :allow_blank => true

#  after_save  :resave_child_if_has_attachment

#  def resave_child_if_has_attachment
#    self.images.each do |cf|
#      cf.save if cf.image?
#    end
#  end


end

