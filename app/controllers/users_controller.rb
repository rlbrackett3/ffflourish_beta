class UsersController < ApplicationController
 #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json, :js

#-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users
  #--GET /users.xml
  #--GET /users.json                                       HTML and AJAX
  #----------------------------------------------------------------------#
  def index
    @search_path = users_path
    @users = User.search(params[:search]).asc(:name).paginate(:page => params[:page], :per_page => 10)
    @title = "members"

    respond_with(@users)
  end
#----------------------------------------------------------------------#
  #--GET /users/1
  #--GET /users/1.xml
  #--GET /users/1.json                                       HTML and AJAX
  #----------------------------------------------------------------------#
  def show
    @user = User.find_by_slug(params[:id])
    @posts = @user.posts.search(params[:search]).desc(:created_at).paginate(:page => params[:page], :per_page => 10)
    @post = @user.posts.new
    @title = @user.profile.name

    respond_with(@user)
  end
#----------------------------------------------------------------------#
  # actions for following users
  #----------------------------------------------------------------------#
  def follow
    @user = User.find_by_slug(params[:id])
    unless @user == current_user
      @me = current_user
    end

    @me.follow!(@user)
    current_user.profile.increment_following_count #test and move to model?
    @user.profile.increment_follower_count #test and move to model?

    if @me.update_attributes(params[:user])
#      redirect_to user_following_path(@me)
      respond_with(@user, :layout => !request.xhr?)
    end
  end
  #----------------------------------------------------------------------#
  def unfollow
    @user = User.find_by_slug(params[:id])
    unless @user == current_user
      @me = current_user
    end

    @me.unfollow!(@user)
    current_user.profile.decrement_following_count #test and move to model?
    @user.profile.decrement_follower_count #test and move to model?

    if @me.update_attributes(params[:user])
#      redirect_to user_following_path(@me)
      respond_with(@user, :layout => !request.xhr?)
    end
  end
  #----------------------------------------------------------------------#
  def following
    @search_path = following_user_path
    @page_title = "is following"
    @title = "following"
    @user = User.find_by_slug(params[:id])
    @users = @user.following.search(params[:search]).desc(:name).paginate(:page => params[:page], :per_page => 25)
    render 'show_follow'
  end
  #----------------------------------------------------------------------#
  def followers
    @search_path = followers_user_path
    @page_title = "is followed by"
    @title = "followers"
    @user = User.find_by_slug(params[:id])
    @users = @user.followers.search(params[:search]).desc(:name).paginate(:page => params[:page], :per_page => 25)
    render 'show_follow'
  end
#----------------------------------------------------------------------#
end

