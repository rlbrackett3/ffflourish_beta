require 'spec_helper'

describe User do
#------------------------------------------------#
  # Defines a sample user with the following attributes
  before(:each) do
    @attr = { :first_name                 => "Robert",
              :last_name                  => "Brackett",
              :email                      => "rob@test.com",
              :email_confirmation         => "rob@test.com",
              :password                   => "foobar",
              :password_confirmation      => "foobar" 
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
  
  it "should require a matching email confirmation" do
    User.new(@attr.merge(:email_confirmation => "invalid@example.com")).should_not be_valid
  end
  
  it "should require a password" do
    User.new(@attr.merge( :password => "", 
                          :password_confirmation => "")).should_not be_valid
  end
  
  it "should require a matching password confirmation" do
    User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
  end
  
  # Testing validations of users data
  #------------------------------------------------# 
  describe "name validations" do
    
    it "should reject first names that are too long" do
      long_name = "a" * 61
      long_name_user = User.new(@attr.merge(:first_name => long_name))
      long_name_user.should_not be_valid
    end
    
    it "should reject first names that are too long" do
      long_name = "a" * 61
      long_name_user = User.new(@attr.merge(:last_name => long_name))
      long_name_user.should_not be_valid
    end
  end
  
  #------------------------------------------------# 
  # Email validation tests
  describe "email validations" do
    
    it "should accept valid email addresses" do
      valid_endings = %w[com org net edu es jp me nu info]
      valid_emails = valid_endings.collect do |ending|
        "foo.bar_1-9@baz-quux0.example.#{ending}"
      end
      valid_emails.each do |email|
        valid_email_user = User.new(@attr.merge(:email => email,
                                                :email_confirmation => email))
        valid_email_user.should be_valid
      end
    end
    
    it "should reject invalid email addresses" do
#      invalid_emails = %w[foobar@example.c @example.com f@com foo@bar..com foobar@example.infod foobar.example.com foo,@example.com foo@example,com]
      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      invalid_emails.each do |email|
        invalid_email_user = User.new(@attr.merge(:email => email,
                                                  :email_confirmation => email))
        invalid_email_user.should_not be_valid
      end
    end
    
    it "should reject duplicate email addresses" do
      # Put a user with given email address into the database
      User.create!(@attr)
      # Attempt to add the same user
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
    
    it "should reject email addresses identical to upcase" do
      upcased_email = @attr[:email].upcase
      upcased_email_confirm = @attr[:email_confirmation].upcase
      User.create!(@attr.merge( :email => upcased_email,
                                :email_confirmation => upcased_email_confirm))
      user_with_duplicate_email = User.new(@attr)
      user_with_duplicate_email.should_not be_valid
    end
    
  end
  #------------------------------------------------# 
  # Password validations
  describe "password validations" do
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  #------------------------------------------------# 
  
#------------------------------------------------# 
end
