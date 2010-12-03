require 'spec_helper'

describe Post do
#------------------------------------------------#
  # Defines a sample user
#  before do
#    @user = Factory(:user)
#  end
#------------------------------------------------#
  describe "fields" do

    it { should have_field :title }
    it { should have_field :content }
    it { should have_field :created_at }
    it { should have_field :updated_at }
    it { should have_field :user_id }

    it { should have_field :image_source_name }
    it { should have_field :image_source_url }
    it { should have_field :source_name }
    it { should have_field :source_url }

    it { should have_field :image_filename }

    describe "voting" do
      it { should have_field :votes }
      it { should have_field :voters }
    end

    describe "feed classification" do
      it { should have_field(:public).of_type(Boolean).with_default_value_of(false)}
      it { should have_field(:followers).of_type(Boolean).with_default_value_of(true)}
      it { should have_field(:private).of_type(Boolean).with_default_value_of(false)}
    end

  end
#------------------------------------------------#
  describe "associations" do

    it { should be_referenced_in :user }
    it { should embed_many :comments }

  end
#------------------------------------------------#
  describe "validations" do

#    it { should validate_presence_of :title }
    it { should validate_length_of :title }
    it { should validate_length_of :content }

  end
#------------------------------------------------#
#  describe "build post" do
#    pending
#  end
#------------------------------------------------#
  describe "deleting dependencies" do
    before do
      @user = Factory(:user)
    end

    it "should delete a post's comments on destroy" do
      post = @user.posts.create!(:title => 'hello', :content => 'world')
      post.comments.create!(:content => "comment")
      post.destroy
      Post.all(:id => post.id).empty?.should == true
      Comment.all(:text => "comment").empty?.should == true
    end

  end
#------------------------------------------------#
  describe 'from_users_followed_by' do
    before(:each) do
      @user = Factory(:user)
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))

      @user_post = @user.posts.create!(:title => "Hello", :content => "foo")
      @other_post = @other_user.posts.create!(:title => "Hello", :content => "foo")
      @third_post = @third_user.posts.create!(:title => "Hello", :content => "foo")

      @user.follow!(@other_user)
    end

    it 'it should have a from_users_followed_by class method' do
      Post.should respond_to(:from_users_followed_by)
    end

    it "should invlude the followed user's posts" do
      Post.from_users_followed_by(@user).should include(@other_post)
    end

    it "should include the user's own posts" do
      Post.from_users_followed_by(@user).should include(@user_post)
    end

    it "should not include an unfollowed user's posts" do
      Post.from_users_followed_by(@user).should_not include(@third_post)
    end

  end
#------------------------------------------------#
end

