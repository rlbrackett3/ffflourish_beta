require 'carrierwave/orm/mongoid'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable, :invitable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_protected    :_id
  #--fields--#
  field :first_name
  field :last_name
  field :likes, :type => Array, :default => []
  mount_uploader :avatar, AvatarUploader
  #--indecies--#
  index :email

  #--User Profile --#
  embeds_one        :profile, :cascade_callbacks => true
  accepts_nested_attributes_for :profile

  #--User Blog--#
  references_many   :posts, :stored_as => :array,
                            :inverse_of => :user,
                            :dependent => :delete
  references_many   :comments, :stored_as => :array,
                               :inverse_of => :user
  references_many   :following, :stored_as => :array,
                                :class_name => 'User',
                                :inverse_of => :followers
  references_many   :followers, :stored_as => :array,
                                :class_name => 'User',
                                :inverse_of => :following
  
  #--callbacks--#
  after_create :seed_profile

#--Email contents validation--##
  # email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

#--Validations--#
  validates :first_name,    :presence => true,
                            :length => { :maximum => 60 }
  validates :last_name,     :presence => true,
                            :length => { :maximum => 60 }
  validates :email,         :presence => true,
                            :confirmation => true,
                            :uniqueness => { :case_sensitive => false }
  validates :profile,       :associated => true
#--Combine first and last name to user's full name--#
  def full_name
    [first_name, last_name].join(" ")
  end

  def url_name
    [first_name, last_name].join()
  end

  def add_likes(likes)

  end
  
  def follow!(user)
    following << user
    self.save
  end
  
  def following?(user)
    following_ids.include? user.id
  end
  
  def unfollow!(user)
    following_ids.delete user.id
    user.follower_ids.delete self.id
    user.save!
    self.save!
  end

protected
#--Seed the user's profile with a name and nil data--#
  def seed_profile
    self.profile = Profile.new( :user_name => full_name,
                                :about_me => "Describe yourself",
                                :birthday => ""
                                )
    self.profile.locations.create!
    self.profile.websites.create!
    self.profile.stats.create!
    self.save
  end

end

