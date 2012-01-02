require 'spec_helper'

describe FollowingPostsController do
  include Devise::TestHelpers
  render_views

#------------------------------------------------#
  describe "Access Control" do
    before do
      @user = Factory(:user)
      @post = Factory(:post, :user => @user)
    end

    it "should deny access to 'index'" do
        get :index
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end
  end
#------------------------------------------------#
  describe 'when signed in' do
    before(:each) do
      @user = Factory(:user)
      @profile = @user.profile
      @other_user = Factory(:user, :email => Factory.next(:email))
      @other_user.follow!(@user)
      sign_in(@user)
      
      30.times do
        Factory(:post, :user => @other_user)
      end
    end
     
    it "should display the correct title" do
      get :index, :id => @user.slug
      response.should have_selector("title", 
              :content => @base_title+ " | #{@profile.name}'s following feed")
    end
     
    it 'should have follower/following counts' do
      get :index, :id => @user.slug
      response.should have_selector('a', :href => following_user_path(@user),
                                         :content => "following")
      response.should have_selector('a', :href => followers_user_path(@user),
                                         :content => "followers")
      response.should have_selector('div', :id => 'following_count',
                                           :class => 'stat_value',
                                           :content => "0") #following fbot
      response.should have_selector('div', :id => 'followers_count',
                                           :class => 'stat_value',
                                           :content => "1")
    end
    
#    it "should paginate feed items" do
#      @user.follow!(@other_user)
#      get :index, :id => @user.slug
#      response.should have_selector("div.pagination")
#      response.should have_selector("span.disabled", :content => "Previous")
#      response.should have_selector("a",  :href => "/?page=2",
#                                          :content => "2")
#      response.should have_selector("a",  :href => "/?page=2",
#                                          :content => "Next")
#    end
  end
#------------------------------------------------#
end
