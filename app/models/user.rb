require 'carrierwave/orm/mongoid'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable, :invitable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_protected    :_id
  #--fields--#
  field :username
  field :name
  field :likes, :type => Array, :default => []

  key   :username
  #validates :_id, :uniqueness => true

  search_in(:name,
            :username,
            :email,
            { :allow_empty_search => true })
  #--indecies--#
  index :email

  #--User Profile --#
  embeds_one        :profile,   :cascade_callbacks => true
  accepts_nested_attributes_for :profile

  #--User Blog--#
  references_many   :posts,     :stored_as => :array,
                                :inverse_of => :user,
                                :dependent => :delete,
                                :index => true
  references_many   :comments,  :stored_as => :array,
                                :inverse_of => :user,
                                :index => true
  references_many   :following, :stored_as => :array,
                                :class_name => 'User',
                                :inverse_of => :followers
  references_many   :followers, :stored_as => :array,
                                :class_name => 'User',
                                :inverse_of => :following
#--Email contents validation--##
  # email_regex = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
#--Validations--#
  validates :username,      :uniqueness => true,
                            :length => 5..16
  validates :name,          :presence => true,
                            :length => { :maximum => 60 }
  validates :email,         :presence => true,
                            :confirmation => true,
                            :uniqueness => { :case_sensitive => false }
  validates :profile,       :associated => true

  #--callbacks--#
  after_create :seed_profile

#--Combine first and last name to user's full name--#
#  def full_name
#    [first_name, last_name].join(" ")
#  end

#  def url_name
#    [first_name, last_name].strip!.join()
#  end

#--Methods for following and unfollowing users--#
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

  def following_count
    following.count
  end

  def followers_count
    followers.count
  end

#--Method for feed me + following--#
  def following_feed
    Post.from_users_followed_by(self)
  end


protected
#--Seed the user's profile with a name and nil data--#
  def seed_profile
    self.profile = Profile.new( :handle => "new ffflourisher",
                                 :about_me => "Tell us a little about yourself."
                                )
    self.profile.locations.create!( :city => "City",
                                     :state => "State",
                                     :country => "Country",
                                     :postal_code => "00000"
                                    )
    self.profile.websites.create!( :name => "The name of my awesome website or blog.",
                                    :url => "www.example.com",
                                    :info => "Why my website is awesome."
                                   )
    self.save
  end

end

