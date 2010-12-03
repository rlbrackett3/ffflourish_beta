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
  #------------------------------------------------#
    describe 'when signed in' do
      before(:each) do
        @user = (Factory(:user))
        @other_user = Factory(:user, :email => Factory.next(:email))
        @other_user.follow!(@user)
        sign_in@user

        30.times do
          Factory(:post, :user => @other_user)
        end
      end

      it "should display the correct title" do
        get :home
        response.should have_selector("title", :content => @base_title+ " | #{@user.first_name}'s feed me+following")
      end

      it 'should have follower/following counts' do
        get :home
        response.should have_selector('a', :href => following_user_path(@user),
                                           :content => "following")
        response.should have_selector('a', :href => followers_user_path(@user),
                                           :content => "followers")
        response.should have_selector('div', :id => 'following_count',
                                             :class => 'stat_value',
                                             :content => "1") #following fbot
        response.should have_selector('div', :id => 'followers_count',
                                             :class => 'stat_value',
                                             :content => "1")
      end

      it "should paginate feed items" do
        @user.follow!(@other_user)
        get :home
        response.should have_selector("div.pagination")
        response.should have_selector("span.disabled", :content => "Previous")
        response.should have_selector("a",  :href => "/?page=2",
                                            :content => "2")
        response.should have_selector("a",  :href => "/?page=2",
                                            :content => "Next")
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

