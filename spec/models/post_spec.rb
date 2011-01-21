require 'spec_helper'

describe Post do
#------------------------------------------------#
  # Defines a sample user
#  before do
#    @user = Factory(:user)
#  end
#------------------------------------------------#
  describe "fields" do

    it { should have_field :content }
    it { should have_field :created_at }
    it { should have_field :updated_at }
    it { should have_field :user_id }

    it { should have_field :image_filename }

    describe "voting" do
      it { should have_field :votes }
      it { should have_field :voters }
    end

  end
#------------------------------------------------#
  describe "associations" do

    it { should be_referenced_in :user }
    it { should embed_many :comments }

  end
#------------------------------------------------#
  describe "validations" do

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
  describe 'query scopes' do
    before(:each) do
      # create sample users
      @user = Factory(:user)
      @other_user = Factory(:user, :email => Factory.next(:email))
      @third_user = Factory(:user, :email => Factory.next(:email))
      # create sample posts for users
      @user_post = @user.posts.create!(:content => "foo", :created_at => 1.hour.ago)
      @other_post = @other_user.posts.create!(:content => "bar", :created_at => 1.day.ago)
      @third_post = @third_user.posts.create!(:content => "squirrel", :created_at => 2.days.ago)
      @oldpost = @user.posts.create!(:content => "foo", :created_at => 4.days.ago)

      @user.follow!(@other_user)
    end
    #------------------------------------------------#
    describe 'from_users_followed_by' do

      it 'it should have a from_users_followed_by class method' do
        Post.should respond_to(:from_users_followed_by)
      end

      it "adds the scope to the scopes" do
        Post.scopes.should include(:from_users_followed_by)
      end

      it "should include the followed user's posts" do
        Post.from_users_followed_by(@user).should include(@other_post)
      end

#      it "should include the user's own posts" do
#        Post.from_users_followed_by(@user).should include(@user_post)
#      end

      it "should not include an unfollowed user's posts" do
        Post.from_users_followed_by(@user).should_not include(@third_post)
      end

      it 'should display current posts in desc order' do
        Post.from_users_followed_by(@user).options[:sort].should == [[:created_at, :desc]]
      end
    end
    #------------------------------------------------#
    describe 'current' do

      it 'should have a current_posts class method' do
        Post.should respond_to(:current)
      end

      it "adds the 'current' scope to the scopes" do
        Post.scopes.should include(:popular)
      end

      it 'should include all users posts within 3 days' do
        Post.current.should include(@user_post)
        Post.current.should include(@other_post)
        Post.current.should include(@third_post)
      end

      it 'should not include posts older than 3 days ago' do
        Post.current.should_not include(@oldpost)
      end

      it 'should display current posts in desc order' do
        Post.current.options[:sort].should == [[:created_at, :desc]]
      end
    end
    #------------------------------------------------#
    describe 'popular' do

      it 'should have a current_posts class method' do
        Post.should respond_to(:popular)
      end

      it "adds the 'popular' scope to the scopes" do
        Post.scopes.should include(:popular)
      end
    end
  end
#------------------------------------------------#
  describe 'voting' do
    let(:user)      { Factory(:user) }
    let(:poster)    { Factory(:user, :email => Factory.next(:email)) }
    let(:post)      { Factory(:post, :user => poster)}

    it { should respond_to(:vote) }
    it { should respond_to(:votes) }
    it { should respond_to(:vote_count) }
    it { should respond_to(:voted?) }

    describe 'user likes a post' do
      before(:each) do
        post.vote 1, user
      end

      it 'should increment votes by one' do
        post.votes.should == 1
      end

      it 'should store the user id of voted users' do
        post.voters.should include(user.id)
      end

      it "should add the post id to the user's likes" do
        post.add_user_likes(user)
        user.likes.should include(post.id)
      end

      describe 'multiple votes' do

        it 'should not accept a second vote' do
          post.vote(1, user).should == nil
        end
      end
    end
  end
#------------------------------------------------#
end

