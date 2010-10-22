require 'spec_helper'
#------------------------------------------------#
  describe "stats/show.html.haml" do
    before(:each) do
      @stat = assign(:stat, stub_model(Stat))
    end
#------------------------------------------------#
    describe "general information" do
      
      before(:each) do
        user_profile = Factory(:profile, :user => @user)
      end
      
      it "should include the user's full name" do
        get :show, :id => @user
        response.should have_selector("th", :content => @user.full_name)
      end
    
      it "should have a profile image" do
        get :show, :id => @user 
        response.should have_selector("img", :class => "profile_img")
      end
    
      it "should include a description 'about me'" do
        get :show, :id => @user
        response.should have_selector("tb", :content => @user.stat.about_me)
      end
    end
  #------------------------------------------------#
end

