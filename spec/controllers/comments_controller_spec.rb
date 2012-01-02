require 'spec_helper'

describe CommentsController do
  include Devise::TestHelpers
  include Mongoid::Matchers
  render_views
#------------------------------------------------#
  describe "POST 'create'" do
    let(:user) { Factory(:user) }
    let(:post) { Factory(:post, :user => user) }
  #------------------------------------------------#
    describe "for non-signed-in users" do

      it "should deny access" do
        post :create
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end

    end
  #------------------------------------------------#
    describe 'for signed in users' do
      before do
        sign_in(user)
      end
      
      it 'should POST "create"' do 
        post :create
        response.should be_success
      end

    end
  #------------------------------------------------#
  end
#------------------------------------------------#
  describe "GET 'destroy'" do
    let(:user) { Factory(:user) }
    let(:post) { Factory(:post, :user => user) }
    
    describe "for non-signed-in users" do

      it "should deny access" do
        get :destroy
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
      end
    end

    describe "for signed in user" do
      before do
        sign_in(user)
      end
      
      it "should be successful" do
        get :destroy
        response.should be_success
      end
    end
  end
end

