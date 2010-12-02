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

#--Scopes--#
#  default_scope :order => Post.desc(:created_at)

  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids << user.id).desc(:created_at) }

#--Mthods--#
  def add_user_likes(user, post) #add tests for me!!!!!
    user.likes << post
    user.save
  end

#  after_save  :resave_child_if_has_attachment

#  def resave_child_if_has_attachment
#    self.images.each do |cf|
#      cf.save if cf.image?
#    end
#  end

  private
#    class << self
#      def followed_by(user)
#        criteria.where(:user_id.in => user.following.only(:_id).map{ |user| user.id } << user.id)
#      end
#    end

end

