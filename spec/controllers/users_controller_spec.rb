require 'spec_helper'

describe UsersController do
  render_views
#  
##------------------------------------------------#
#  describe "GET 'show'" do
#  #------------------------------------------------#
#    describe "for non-signed-in users" do
#      
#      before(:each) do
#        @user = Factory(:user)
#      end
#      
#      it "should deny access" do
#        get :show, :id => @user
#        response.should redirect_to(new_user_session_path)
#        flash[:alert].should =~ /sign in/
#      end
#      
#    end
#  #------------------------------------------------#
#    describe "for signed-in-users" do
#      
#      before(:each) do
#        @user = Factory(:user)
#        sign_in @user
#      end
#      
#      it "should be successful" do
#        get :show, :id => @user
#        response.should be_success
#      end
#    
#      it "should find the correct user" do
#        get :show,  :id => @user
#        assigns(:user).should == @user
#      end
#      
#      it "should have the correct title" do
#        get :show,  :id => @user
#        response.should have_selector("title", 
#                    :content => @user.full_name)
#      end
#      
#    end
#  
#  end
#------------------------------------------------#
end
