require 'spec_helper'

describe PopularPostsController do
  include Devise::TestHelpers
  render_views

#------------------------------------------------#
  describe "Access Control" do
    before do
      @user = Factory(:user)
      @post = Factory(:post, :user => @user)
    end

    it "should deny access to 'index'" do
        get 'index'
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'show'" do
        get 'show'
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end
  end
#------------------------------------------------#
  describe 'when signed in' do
    before do
      @user = Factory(:user)
      @post = Factory(:post, :user => @user)
      sign_in  @user
    end

    describe 'index' do
      describe "GET 'index'" do
        it "should be successful" do
          get 'index'
          response.should be_success
        end

        it "should have the correct title" do
          get 'index'
          response.should have_selector("title",
              :content => "ffflourish | popular posts")
        end
      end
    end

    describe 'show' do
      describe "GET 'show'" do
        it "should be successful" do
          get 'show'
          response.should be_success
        end
      end
    end
  end

end

