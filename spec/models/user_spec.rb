require 'spec_helper'

describe User do
#------------------------------------------------#
  # Defines a sample user with the following attributes
  before(:each) do
    @attr = { :first_name => "Robert",
              :last_name => "Brackett",
              :email => "rob@test.com",
              :password => "foobar",
              :password_confirmation => "foobar" 
              }
  end
  
  # Testing basic conroller actions with required data
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a first name" do
    no_name_user = User.new(@attr.merge(:first_name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a last name" do
    no_name_user = User.new(@attr.merge(:last_name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_name_user = User.new(@attr.merge(:email => ""))
    no_name_user.should_not be_valid
  end
  
  # Testing validations of users data
  
  
  
#------------------------------------------------# 
end
