class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name
  field :last_name
  #--User Profile --#
  references_one    :profile, :class_name => 'Profile', :dependent => :destroy
  accepts_nested_attributes_for :profile
  #--User Blog--#
  embeds_many       :posts
  references_many   :comments#, :stored_as => :array, :inverse_of => :users


  attr_protected  :_id

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
#                            :format => { :with => email_regex }
#  validates :password,      :presence => true,
#                            :confirmation => true,
#                            :length => { :within => 6..40 }

#--Combine first and last name to user's full name--#
  def full_name
    [first_name, last_name].join(" ")
  end

  def url_name
    [first_name, last_name].join()
  end

#--Seed the user's profile with a name and nil data--#
  def seed_profile
    profile = Profile.create( :user_name => full_name,
                              :status => 4,
                              :about_me => "Describe yourself",
                              :birthday => "",
                              )
    self.profile = profile
    self.profile.save
  end

end

