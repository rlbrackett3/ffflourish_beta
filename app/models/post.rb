require 'carrierwave/orm/mongoid'
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Voteable
  include Mongoid::Taggable
  include Mongoid::Search

  attr_protected  :_id
  #--Associations--#
  referenced_in   :user
  embeds_many     :comments
  mount_uploader :image, ImageUploader

  #--boolean values for controlling visability of posts--#
  field           :public,      :type => Boolean, :default => false
  field           :followers,   :type => Boolean, :default => true
  field           :private,     :type => Boolean, :default => false
  #--data fields--#
  field           :title
  field           :content
  field           :link
  #--source fields--#
  field           :source_name
  field           :source_url

  #-- search on --#
  search_in(:title,
            :content,
            { :user => :first_name },
            { :user => :last_name },
            { :allow_empty_search => true})

  #--indexes--#
  index           :created_at
  index           :updated_at
  index           :user_id
  index "comments.created_at"

  #--validations--#
  validates       :title,
                  :length => { :within => 2..140, :message => "is too short." },
                  :allow_blank => true
  validates       :content,
                  :length => { :within => 2..2048 },
                  :allow_blank => true

#--Scopes--#
#  default_scope :order => Post.desc(:created_at)

  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids << user.id).desc(:created_at) }

#--Methods--#
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

end

