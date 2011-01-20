require 'carrierwave/orm/mongoid'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable, :timeoutable, :invitable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :name, :urlname, :likes, :email, :profile, :password
  #--fields--#
  field :urlname
  field :name
  field :likes, :type => Array, :default => []

  key   :urlname

  search_in(:name,
            :urlname,
            :email,
            { :allow_empty_search => true })
  #--indecies--#
  index :email

  #--User Profile --#
  embeds_one        :profile#,   :cascade_callbacks => true
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

#--Validations--#
  validates :urlname,       :uniqueness => true,
                            :length => 5..20
  validates :name,          :presence => true,
                            :length => 2..25
  validates :email,         :presence => true,
                            :confirmation => true,
                            :uniqueness => { :case_sensitive => false }
  validates :profile,       :associated => true

  #--callbacks--#
  after_create  :seed_profile
  after_update    :update_name

  def update_name
    self.name = self.profile.name
  end

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
    self.profile = Profile.new(:name => self.name,
                                :handle => "new ffflourisher",
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

