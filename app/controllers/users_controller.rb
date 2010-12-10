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
    @users = User.search(params[:search]).asc(:first_name).paginate(:page => params[:page])
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
    @title = @user.first_name

    respond_with(@user)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/avatar
  #--GET /users/1/avatar.xml
  #--GET /users/1/avatar.json                                HTML and AJAX
  #----------------------------------------------------------------------#
  def edit
    @user = User.find(params[:id])

    @user.avatar.build if ! @user.avatar?

    @title = "#{@user.first_name}'s avatar"
    respond_with(@user)
  end
#----------------------------------------------------------------------#
  #--POST /users/1/avatar
  #--POST /users/1/avatar.xml
  #--POST /users/1/avatar.json                               HTML and AJAX
  #----------------------------------------------------------------------#
  def update
    @user = User.find(params[:id])
    @profile = @user.profile

    flash[:notice] = "Avatar successfully updated!" if @user.update_attributes(params[:user])
    respond_with(@user, @profile)
#    if @user.update_attributes(params[:user])
#      redirect_to user_profile_path(@user, @profile)
#    end
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
    @title = "following"
    @user = User.find(params[:id])
    @users = @user.following.desc(:name).paginate
    render 'show_follow'
  end
  #----------------------------------------------------------------------#
  def followers
    @title = "followers"
    @user = User.find(params[:id])
    @users = @user.followers.desc(:name).paginate
    render 'show_follow'
  end
#----------------------------------------------------------------------#
end

