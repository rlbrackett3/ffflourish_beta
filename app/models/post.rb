require 'carrierwave/orm/mongoid'
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Voteable
#  include Mongoid::Taggable
  include Mongoid::Search

  attr_protected  :_id
  #--Associations--#
  referenced_in   :user
  embeds_many     :comments
  mount_uploader  :image, ImageUploader

#  field           :permissions, :type => Integer, :default => 2
  #--data fields--#
#  field           :title
  field           :content
#  field           :link
  #--source fields--#
#  field           :source_name
#  field           :source_url

  #-- search on --#
  search_in(:content,
            { :user => :name },
            { :user => :urlname},
            { :allow_empty_search => true}
            )

  #--indexes--#
  index           :created_at
  index           :updated_at
  index           :user_id
  index "comments.created_at"

  #--validations--#
#  validates       :title,
#                  :length => { :within => 2..140, :message => "is too short." },
#                  :allow_blank => true
  validates       :content,
                  :length => { :within => 2..201 }

#--Scopes--#
#  default_scope :order => Post.desc(:created_at)

#  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids << user.id).and(:permissions.gt => 1 ).desc(:created_at) }

  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids).desc(:created_at)}

  scope :newest_posts, where(:created_at.gt => 1.day.ago).desc(:created_at)

  scope :pop_posts, order_by(:votes.desc)

#--Methods--#
  def add_user_likes(user, post) #add tests for me!!!!!
    if post.voted?(user) == false
      user.likes << post.id
      user.save
    end
  end

  private

end

