require 'spec_helper'

describe UsersController do
  include Devise::TestHelpers
  render_views

#------------------------------------------------#
  describe "GET 'show'" do
  #------------------------------------------------#
    describe "for non-signed-in users" do

      before(:each) do
        @user = Factory(:user)
      end

      it "should deny access" do
        get :show, :id => @user._id.to_s
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end

    end
  #------------------------------------------------#
    describe "for signed-in-users" do

      before(:each) do
        @user = Factory(:user)
        sign_in @user
      end

      it "should be successful" do
        get :show, :id => @user._id.to_s
        response.should be_success
      end

      it "should find the correct user" do
        get :show,  :id => @user._id.to_s
        assigns(:user).should == @user
      end

      it "should have the correct title" do
        get :show,  :id => @user._id.to_s
        response.should have_selector("title",
                    :content => "ffflourish | #{@user.first_name}")
      end

    end

  end
#------------------------------------------------#
  describe 'follow pages' do
  #------------------------------------------------#
    describe 'when not signed in' do

      it 'should protect "followers"' do
        get :followers, :id => 1
        response.should redirect_to(new_user_session_path)
      end

      it 'should protect "following"' do
        get :following, :id => 1
        response.should redirect_to(new_user_session_path)
      end

      it 'should protect "follow"' do
        get :follow, :id => 1
        response.should redirect_to(new_user_session_path)
      end

    end
  #------------------------------------------------#
    describe 'when signed in' do
      before(:each) do
        @user = Factory(:user)
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
        sign_in(@user)
      end

      it 'should show user following' do
        get :following, :id => @user._id.to_s
        response.should have_selector('a',  :href => user_posts_path(@other_user),
                                            :content => @other_user.full_name)
      end

      it 'should have the correct title for following' do
        get :following, :id => @user._id.to_s
        response.should have_selector('title',
                              :content => "ffflourish | following")
      end

      it 'should show user followers' do
        get :followers, :id => @other_user._id.to_s
        response.should have_selector('a',  :href => user_posts_path(@user),
                                            :content => @user.full_name)
      end

      it 'should have the correct title for following' do
        get :followers, :id => @user._id.to_s
        response.should have_selector('title',
                              :content => "ffflourish | followers")
      end

      it 'should paginate user following' do
        pending
      end

      it 'should paginate user followers' do
        pending
      end
    #------------------------------------------------#
      describe 'follow action' do
        pending
      end
    #------------------------------------------------#
      describe 'unfollow action' do
        pending
      end

    end

  end
#------------------------------------------------#
end

