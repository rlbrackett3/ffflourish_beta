require 'carrierwave/orm/mongoid'
class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Mongoid::Slug
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :timeoutable, :invitable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable

  attr_accessible :name, :urlname, :likes, :email, :email_confirmation,
                  :profile, :password, :password_confirmation, :comment_ids
  #--fields--#
  field :urlname, :type => String
  field :name, :type => String
  field :likes, :type => Array, :default => []
  field :comment_ids, :type => Array, :default => []

  # user management through cancan and roles
  field :role

  ROLES = %w[admin user]

  slug  :urlname, :index => true

  search_in(:name,
            :urlname,
            :email,
            { :posts => :content },
            { :allow_empty_search => true })
#--Indexed fields--#

#--User Profile --#
  embeds_one        :profile#,   :cascade_callbacks => true
  accepts_nested_attributes_for :profile

#--User Blog--#
  references_many :posts, :dependent => :delete, :index => true
  references_and_referenced_in_many :following,
                                    :class_name => 'User',
                                    :inverse_of => :followers
  references_and_referenced_in_many :followers,
                                    :class_name => 'User',
                                    :inverse_of => :following
#--Feedback--# no tests for this yet
  references_many :feedback_messages

#--Validations--#
  validates :urlname,       :uniqueness => true,
                            :length => 5..60#,
                            #:format => { :with => /^[\w \.\-@]+$/ }
  validates :name,          :presence => true,
                            :length => 2..60#,
                            #:format => { :with => /^[\w \.\-@]+$/ }
  validates :email,         :presence => true,
                            :confirmation => true,
                            :uniqueness => { :case_sensitive => false }
  validates :profile,       :associated => true
#  validates :role,          :presence => true

#--Callbacks--#
  after_create  :default_role
  after_create  :seed_profile
  after_update  :update_name

#--Combine first and last name to user's full name--#
#  def full_name
#    [first_name, last_name].join(" ")
#  end

#  def url_name
#    [first_name, last_name].strip!.join()
#  end

  def add_comment_id_to_user(comment) #write tests for me
    self.comment_ids << comment.id
    self.save
  end

  def delete_comment_from_comment_ids(commenter)
    self.comment_ids.delete commenter.id
    self.save!
  end

# stat counts
  def posts_count
    posts.count
  end

  def likes_count
    likes.count
  end

  def comments_count
    comment_ids.count
  end

  def following_count
    following.count
  end

  def follower_count
    followers.count
  end

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

#--Method for feed me + following--#
  def following_feed
    Post.from_users_followed_by(self)
  end

  def commented_on_posts
    Post.commented_on_by_user(self)
  end


protected

  def update_name
    self.name = self.profile.name
  end

  # set default user role
  def default_role
    self.role = "user"
  end

#--Seed the user's profile with a name and nil data--#
  def seed_profile
    self.profile = Profile.new( :name => self.name,
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

