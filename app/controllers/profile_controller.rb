class ProfileController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

#-- Methods --#
#----------------------------------------------------------------------#
  #--GET /profile/1
  #--GET /profile/1.xml
  #--GET /profile/1.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def show
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @likes = @profile.stats.where(:like => true)

    @title = "#{current_user.name}'s Profile"

    respond_with(@user, @profile)
  end
#----------------------------------------------------------------------#

#---------------------------------------------------------------------#
  #--GET /profile/(1)user_name/edit
  #--GET /profile/(1)user_name/edit.xml
  #--GET /profile/(1)user_name/edit.json                    HTML AND AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = User.find(params[:user_id])
    @profile = @user.profile
    @user.profile.locations.build if @user.profile.locations.empty?
    @user.profile.websites.build if @user.profile.websites.empty?
    @user.profile.stats.build if @user.profile.stats.empty?

    @page_title = "updating your profile"
    @title = "updating #{current_user.name}'s profile"

    respond_with(@user, @profile)
  end
#---------------------------------------------------------------------#
  #--PUT /profile/1
  #--PUT /profile/1.xml
  #--PUT /profile/1.json                                      HTML AND AJAX
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

