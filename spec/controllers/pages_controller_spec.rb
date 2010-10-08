require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers
  render_views
  
  before(:each) do
    @base_title = "ffflourish"
  end
#------------------------------------------------#
  describe "GET 'home'" do
  #------------------------------------------------#
    describe "when not signed in" do
    
      it "should successfully get the 'home' page" do
        get :home
        response.should be_success
      end
    
      it "should display the correct title" do
        get :home
        response.should have_selector("title", :content => @base_title+ " | home")
      end
    end
  end
#------------------------------------------------#
  describe "GET 'about'" do
    
    it "should successfully get the 'about' page" do
      get :about
      response.should be_success
    end
    
    it "should display the correct title" do
      get :about
      response.should have_selector("title", :content => @base_title+ " | about")
    end
    
  end
#------------------------------------------------#
  describe "GET 'tour'" do
    
    it "should successfully get the 'tour' page" do
      get :tour
      response.should be_success
    end
    
    it "should display the correct title" do
      get :tour
      response.should have_selector("title", :content => @base_title+ " | tour")
    end
    
  end
#------------------------------------------------#
  describe "GET 'terms'" do
    
    it "should successfully get the 'terms' page" do
      get :terms
      response.should be_success
    end
    
    it "should display the correct title" do
      get :terms
      response.should have_selector("title", :content => @base_title+ " | terms & conditions")
    end
    
  end
#------------------------------------------------#
  describe "GET 'contact'" do
    
    it "should successfully get the 'contact' page" do
      get :contact
      response.should be_success
    end
    
    it "should display the correct title" do
      get :contact
      response.should have_selector("title", :content => @base_title+ " | contact")
    end
    
  end
#------------------------------------------------#

end
