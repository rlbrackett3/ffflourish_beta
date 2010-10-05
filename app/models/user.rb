class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :first_name
  field :last_name
  validates_presence_of   :first_name,
                          :last_name,
                          :password_confirmation
  validates_uniqueness_of :email, 
                          :case_sensitive => false
                          
  attr_accessible :first_name, :last_name, 
                  :email, 
                  :password, :password_confirmation

end
