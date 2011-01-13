class UsersController < ApplicationController
 #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

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
    @user = User.find(params[:id])
    @title = @user.name

    respond_with(@user)
  end
#----------------------------------------------------------------------#
  #actins for folloeing users
  #----------------------------------------------------------------------#
  def follow
    @user = User.find(params[:id])
    unless @user == current_user
      @me = current_user
    end

    @me.follow!(@user)

    if @me.update_attributes(params[:user])
      redirect_to user_profile_path(@user)
    end
  end
  #----------------------------------------------------------------------#
  def unfollow
    @user = User.find(params[:id])
    unless @user == current_user
      @me = current_user
    end

    @me.unfollow!(@user)

    if @me.update_attributes(params[:user])
      redirect_to root_path
    end
  end
  #----------------------------------------------------------------------#
  def following
    @search_path = following_user_path
    @page_title = "is following"
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following.search(params[:search]).desc(:name).paginate(:page => params[:page], :per_page => 25)
    render 'show_follow'
  end
  #----------------------------------------------------------------------#
  def followers
    @search_path = followers_user_path
    @page_title = "is followed by"
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.search(params[:search]).desc(:name).paginate(:page => params[:page], :per_page => 25)
    render 'show_follow'
  end
#----------------------------------------------------------------------#
end

