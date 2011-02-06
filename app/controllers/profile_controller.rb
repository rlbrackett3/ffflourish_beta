class ProfileController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json, :js

#-- Methods --#
#----------------------------------------------------------------------#
  def show
    @user = User.find_by_slug(params[:user_id])
    @profile = @user.profile

    @title = "#{current_user.name}'s Profile"

    respond_with(@user, @profile)
  end
#----------------------------------------------------------------------#
  def edit
    @page_title = "updating your profile"
    @title = "updating #{current_user.name}'s profile"
    @user = User.find_by_slug(params[:user_id])
    if @user == current_user
      @profile = @user.profile
      @user.profile.locations.build if @user.profile.locations.empty?
      @user.profile.websites.build if @user.profile.websites.empty?

      respond_with(@user, @profile)
    else
      redirect_to(user_feed_path(@user), :alert => "You may not update another users profile.")
    end
  end
#---------------------------------------------------------------------#
  def update
    @user = User.find_by_slug(params[:user_id])
    @profile = @user.profile
#    @avatar = @profile.avatar.build(params[:avatar])
    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??
    flash[:notice] = "Profile successfully updated!" if @profile.update_attributes(params[:profile])
    respond_with(@user)
#    respond_with(@profile)
  end
#---------------------------------------------------------------------#
end

