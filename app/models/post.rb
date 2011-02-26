require 'carrierwave/orm/mongoid'
class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Voteable
#  include Mongoid::Taggable
  include Mongoid::Search

#  attr_protected :_id
  attr_accessible :content, :image, :image_filename, :image_cache, :created_at, :comments

  #--Associations--#
  referenced_in   :user, :inverse_of => :posts, :index => true
  embeds_many     :comments
  accepts_nested_attributes_for :comments

  mount_uploader  :image, ImageUploader

#  field           :permissions, :type => Integer, :default => 2
  #--data fields--#
  field           :content
  field           :pop_score, :type => Float, :default => 0.0

  #-- search on --#
  search_in(:content,
            { :allow_empty_search => true }
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
                  :length => { :within => 2..257 }
  validates       :comments,
                  :associated => true
  validate :content_or_image_present?

#--Scopes--#
#  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids << user.id).and(:permissions.gt => 1 ).desc(:created_at) }
#  scope :liked_by, lambda { |user| where(:voters.in => user.id)}

  scope :from_users_followed_by, lambda { |user| where(:user_id.in => user.following_ids).desc(:created_at)}

  scope :recent, where(:created_at.gt => 5.days.ago).desc(:created_at)#write tests for me

  scope :popular, where(:created_at.gt => 3.day.ago).order_by(:votes.desc)#write tests for me
  
  scope :commented_on_by_user, lambda { |user| where( { "comments.user_id" => user.id } ).desc(:updated_at) }


before_save :strip_content
before_update :strip_content

#--Methods--#

  def strip_content
    self.content.strip!
    self.content.gsub!(/\r\n/, " ")
  end

  def self.random
    if (c = count) != 0
      find(:first, :skip =>rand(c))
    end
  end

  # comment methods
  def comments_count #write tests for me
    self.comments.count
  end

  def commenters(user) #write tests for me
    self.comments.each do |c|
      if c.user_id == user.id
        return true
      else
        nil
      end
    end
  end
  
  def comments_viewed_by
    
  end

  def add_user_likes(user) #write tests for me
    if self.voted?(user) == true && user.likes.include?(self.id) == false
      user.likes << self.id
      user.save
    end
  end

  def liked_by #write tests for me
    if self.voters.any?
      User.find(self.voters)
    else
      nil
    end
  end

  def hyperlink_regex(text)
    regex = Regexp.new '((https?:\/\/|www\.)([-\w\.]+)+(:\d+)?(\/([\w\/_\.]*(\?\S+)?)?)?)'
    text.gsub!( regex, '<a href="\1">\1</a>' )
  end
  
#  def self.pop_score
#    votes*0.25 + comments_count*5
#  end
  
  

  protected

  def content_or_image_present? #should be a custom validator??
    if self.content.blank? && self.image == []
      errors[:base] << 'Post must contain content or an image'
    end
  end

  private
  
  

end

