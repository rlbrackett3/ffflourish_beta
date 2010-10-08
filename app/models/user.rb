class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name
  field :last_name
  
  attr_accessible :first_name, :last_name, 
                  :email, :email_confirmation,
                  :password, :password_confirmation

# Email contents validation
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
# Validations
  validates :first_name,    :presence => true,
                            :length => { :maximum => 60 }
  validates :last_name,     :presence => true,
                            :length => { :maximum => 60 }
  validates :email,         :presence => true,
                            :confirmation => true,
                            :uniqueness => { :case_sensitive => false },
                            :format => { :with => email_regex }
  validates :password,      :presence => true,
                            :confirmation => true,
                            :length => { :within => 6..40 }



end
