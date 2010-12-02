require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include Mongoid::Matchers
  render_views
#------------------------------------------------#
  describe "POST 'create'" do
  #------------------------------------------------#
    describe "for non-signed-in users" do

      before(:each) do
        @user = Factory(:user)
        @post = Factory(:post, :user => @user)
      end

      it "should deny access" do
        post :create, :user_id => @user._id.to_s, :post_id => @post._id.to_s
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end

    end
  #------------------------------------------------#
    describe 'for signed in users' do
      before(:each) do
        @user = Factory(:user)
        @post = Factory(:post, :user => @user)
        sign_in@user
      end

      it 'should POST "create"' do #stub validations or mock model
        post :create, :user_id => @user._id.to_s, :post_id => @post._id.to_s
        response.should be_success
      end

    end
  #------------------------------------------------#
  end
#------------------------------------------------#


#  describe "GET 'destroy'" do
#    it "should be successful" do
#      get 'destroy'
#      response.should be_success
#    end
#  end

end

