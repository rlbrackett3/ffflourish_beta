class ProfileController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

#-- Methods --#
#----------------------------------------------------------------------#
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile

    @title = "#{current_user.name}'s Profile"

    respond_with(@user, @profile)
  end
#----------------------------------------------------------------------#
  def edit
    @user = User.find(params[:user_id])
    if @user == current_user
      @profile = @user.profile
      @user.profile.locations.build if @user.profile.locations.empty?
      @user.profile.websites.build if @user.profile.websites.empty?

      respond_with(@user, @profile)
    else
      redirect_to(root_path, :alert => "You may not update another users profile.")
    end

    @page_title = "updating your profile"
    @title = "updating #{current_user.name}'s profile"

  end
#---------------------------------------------------------------------#
  def update
    @user = User.find(params[:user_id])
    @profile = @user.profile

    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??
    flash[:notice] = "Profile successfully updated!" if @user.profile.update_attributes(params[:profile])
#    respond_with(@user, @profile)
    respond_with(@user)
  end
#---------------------------------------------------------------------#
end

