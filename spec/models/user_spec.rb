require 'spec_helper'

describe User do
#------------------------------------------------#
  # Defines a sample user with the following attributes
  before(:each) do
    @attr = { :urlname                    => "Robert",
              :name                       => "Robert Brackett",
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

  it "should require a urlname" do
    no_name_user = User.new(@attr.merge(:urlname => ""))
    no_name_user.should_not be_valid
  end

  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end

#  it "should respond to a full_name method" do
#    user = User.create!(@attr)
#    user.should respond_to(:full_name)
#  end

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

    describe 'long names' do
      it "should reject urlnames that are too long" do
        long_name = "a" * 61
        long_name_user = User.new(@attr.merge(:urlname => long_name))
        long_name_user.should_not be_valid
      end

      it "should reject names that are too long" do
        long_name = "a" * 61
        long_name_user = User.new(@attr.merge(:name => long_name))
        long_name_user.should_not be_valid
      end
    end

    describe 'short names' do
      it "should reject urlnames that are too short" do
        long_name = "a" * 3
        long_name_user = User.new(@attr.merge(:urlname => long_name))
        long_name_user.should_not be_valid
      end

      it "should reject names that are too short" do
        long_name = "a" * 1
        long_name_user = User.new(@attr.merge(:name => long_name))
        long_name_user.should_not be_valid
      end
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
  describe 'seeding profile data' do

    it 'should have a "seed_profile" method' do
      @user = Factory(:user)
      @user.profile.should be_true
    end

  end
  #------------------------------------------------#
  #--mongoid tests--#
  describe "Mongoid" do
    #------------------------------------------------#
    describe "fields" do
      it { should have_field :urlname }
      it { should have_field :name }
      it { should have_field :email }
      it { should have_field :following_ids }
      it { should have_field :follower_ids }
      #--Devise--#
#      it { should have_field :email_confirmation }
#      it { should have_field :password }
#      it { should have_field :password_confirmation}

    end
    #------------------------------------------------#
    describe 'associations' do
      it { should embed_one :profile }
      #it { should accept_nested_attributes_for :profile }
      it { should reference_many(:posts).stored_as(:array) }
      it { should reference_many(:comments).stored_as(:array) }

      it { should reference_many(:following).stored_as(:array) }
#      it { should be_referenced_in(:followers).as_inverse_of(:following) }
      it { should reference_many(:followers).stored_as(:array) }
#      it { should be_referenced_in(:following).as_inverse_of(:followers) }

    end
    #------------------------------------------------#
    describe 'validations' do

      it { should validate_associated :profile }
      describe 'email' do
        it { should validate_presence_of :email }
        it { should validate_confirmation_of :email }
        it { should validate_uniqueness_of :email }
        it { should validate_format_of :email}
      end

      describe 'password' do
        it { should validate_presence_of :password }
      end

    end
  end
  #------------------------------------------------#
  describe 'following' do
    before do
      @u1 = Factory(:user)
      @u2 = Factory(:user, :email => Factory.next(:email))
    end

    it "should have a follow! method" do
      @u1.should respond_to(:follow!)
    end

    it "should have a following? method" do
      @u1.should respond_to(:following?)
    end

    it "should have an unfollow! method" do
      @u1.should respond_to(:unfollow!)
    end

    it "should add a user's id to following array" do
      @u1.follow!(@u2)
      @u1.following.include?(@u2).should be_true
    end

    it "should check if a user is already followed" do
      @u1.follow!(@u2)
      @u1.following?(@u2).should be_true
    end

    it "should remove a user's id from following" do
      @u1.follow!(@u2)
      @u1.unfollow!(@u2)
      @u1.should_not be_following(@u2)
    end

  end
  #------------------------------------------------#
  describe 'followers' do
    before do
      @u1 = Factory(:user)
      @u2 = Factory(:user, :email => Factory.next(:email))
    end

    it 'should add a user id to followers' do
      @u1.follow!(@u2)
      @u2.followers.include?(@u1).should be_true
    end

    it "should remove a user's id from followers" do
      @u1.follow!(@u2)
      @u1.unfollow!(@u2)
      @u2.followers.include?(@u1).should_not be_true
    end

  end

#------------------------------------------------#
#  describe 'following fbot for initial feed posts' do

#    it 'should create a following relationship with fbot' do
#      @user = Factory(:user)
#      @user.following?(@fbot).should be_true
#    end

#  end
#------------------------------------------------#
  describe "post feed" do
    before(:each) do
      @user = Factory(:user)

      @p1 = @user.posts.create!(:content => 'bar')
      @p2 = @user.posts.create!(:content => 'world')
    end

    it "should have a feed" do
      @user.should respond_to(:following_feed)
    end

    it "should include a user's posts" do
      @user.posts.include?(@p1).should be_true
      @user.posts.include?(@p2).should be_true
    end

    it "should not include a different user's posts" do
      p3 = Factory(:post,
                    :user => Factory(:user, :email => Factory.next(:email)))
      @user.posts.include?(p3).should be_false
    end

  end
#------------------------------------------------#
  describe "feed me + following" do
    before(:each) do
      @user = Factory(:user)
      @other_user = Factory(:user, :email => Factory.next(:email))

      @p1 = @user.posts.create!(:content => 'bar')
      @p2 = @user.posts.create!(:content => 'world')
      @p3 = @other_user.posts.create!(:content => "bar")
    end

    it "should have a following_feed" do
      @user.should respond_to(:following_feed)
    end

    it "should not include the user's posts" do
      @user.following_feed.should_not include(@p1)
      @user.following_feed.should_not include(@p2)
    end

    it "should not include posts fron non-followed users" do
      @user.following_feed.should_not include(@p3)
    end

    it "should include the posts of followed users" do
      followed = @other_user
      @user.follow!(followed)
      @user.following_feed.should include(@p3)
    end

  end
#------------------------------------------------#
  describe 'likes' do
    let(:user) { Factory(:user) }
    let(:post) { Factory(:post) }

    it { should respond_to(:likes) }
    it { should respond_to(:likes_count) }
    
    describe 'adding post ids to likes' do
      it 'increment likes_count when a user likes a post' do
        post.vote(1, user)
        post.add_user_likes(user)
        user.likes_count.should == 1
      end
    end
  end
#------------------------------------------------#
end

