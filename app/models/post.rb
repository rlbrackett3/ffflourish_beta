require 'carrierwave/orm/mongoid'
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Voteable
#  include Mongoid::Taggable
  include Mongoid::Search
#  attr_protected :_id
  attr_accessible :content, :image, :image_filename, :image_cache
  #--Associations--#
  referenced_in   :user
  embeds_many     :comments
  mount_uploader  :image, ImageUploader

#  field           :permissions, :type => Integer, :default => 2
  #--data fields--#
  field           :content

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
  validate :content_or_image_present?

#--Scopes--#
#  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids << user.id).and(:permissions.gt => 1 ).desc(:created_at) }
  scope :liked_by, lambda { |user| where(:votes.in => user.id)}

  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids).desc(:created_at)}

  scope :current, where(:created_at.lt => 3.days.ago).desc(:created_at)

  scope :popular, order_by(:votes.desc)

#--Methods--#

  def add_user_likes(user)
    if self.voted?(user) == true && user.likes.include?(self.id) == false
      user.likes << self.id
      user.save
    end
  end
  
#  def liked_by
#    voters.each do |u|
#      BSON::ObjectId.from_string(u.to_params)
#    end
#  end
  
  def hyperlink_regex(text)
    regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
    text.gsub!( regex, '<a href="\1">\1</a>' )
  end

  protected

  def content_or_image_present?
    if self.content.blank? && self.image == []
      errors[:base] << 'Post must contain content or an image'
    end
  end

  private

end

