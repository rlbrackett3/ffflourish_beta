class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user, :inverse_of => :profile

  attr_accessible  :name, :handle, :status, :about_me, :birthday, :avatar,
                   :locations, :websites,
                   :likes_count
  accepts_nested_attributes_for :locations, :websites

  field :name
  field :handle
  field :status,          :type => Integer
  field :about_me
  field :birthday,        :type => Date

  field :likes_count,     :type => Integer, :default => 0
  field :posts_count,     :type => Integer, :default => 0
  field :comments_count,  :type => Integer, :default => 0
  field :following_count, :type => Integer, :default => 0
  field :follower_count,  :type => Integer, :default => 0

  mount_uploader :avatar, AvatarUploader

  index :name

  embeds_many     :locations
  embeds_many     :websites

  validates :name,        :presence => true,
                          :length => 2..25
  validates :handle,      :length => { :maximum => 240,
                                       :message => " is too long." },
                          :allow_blank => true

  protected

  # incrementing stats counts for user profile _count fields
  # this could all be DRYer but i needed to get it implemented first
  # refactor and test #################

  def increment_likes_count #write tests for me
    self.likes_count += 1
    self.save
  end

  def increment_following_count #write tests for me
    self.following_count += 1
    self.save
  end

  def decrement_following_count #write tests for me
    self.following_count += -1
    self.save
  end

  def increment_follower_count #write tests for me
    self.follower_count += 1
    self.save
  end

  def decrement_follower_count #write tests for me
    self.follower_count += -1
    self.save
  end

  def increment_posts_count
    self.posts_count += 1
    self.save
  end

  def decrement_posts_count
    self.posts_count += -1
    self.save
  end

  def increment_comments_count
    self.comments_count += 1
    self.save
  end

  def decrement_comments_count
    self.comments_count += -1
    self.save
  end

end


class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessible :city, :state, :country, :postal_code

  field :city
  field :state
  field :country
  field :postal_code

  embedded_in :profile,  :inverse_of => :locations

#  def locale
#    if ! postal_code.blank? and (city.blank? or state.blank?)
#      lookup = GeoDatum.find_by_zip_code(postal_code)
#      if lookup
#        self.city  = lookup.city.capitalize_each if city.blank?
#        self.state = lookup.state if state.blank?
#      end
#    end
#    [city, state, postal_code].join(" ")
#  end

end

class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessible :name, :url, :info

  field :name
  field :url
  field :info

  embedded_in :profile,  :inverse_of => :websites

end

