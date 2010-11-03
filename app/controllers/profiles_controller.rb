class ProfilesController < ApplicationController
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
    @profile = Profile.find(params[:id])
    @user = current_user
    @likes = @profile.stats.where(:like => true)

    @title = "#{current_user.first_name}'s Profile"

    respond_with(@profile)
  end
#----------------------------------------------------------------------#

#---------------------------------------------------------------------#
  #--GET /profile/(1)user_name/edit
  #--GET /profile/(1)user_name/edit.xml
  #--GET /profile/(1)user_name/edit.json                    HTML AND AJAX
  #---------------------------------------------------------------------#
  def edit
    @profile = Profile.find(params[:id])
    @profile.locations.build if @profile.locations.empty?
    @profile.websites.build if @profile.websites.empty?
    @profile.stats.build if @profile.stats.empty?

    @user = current_user

    @likes = @profile.stats.where(:like => true)
#    @profile.stats.where(:like => true).each do |like|
#      @likes = like.find(params[:id])
#    end

    @title = "updating #{current_user.first_name}'s ffflourish.stats"

    respond_with(@profile)
  end
#---------------------------------------------------------------------#
  #--PUT /profile/1
  #--PUT /profile/1.xml
  #--PUT /profile/1.json                                      HTML AND AJAX
  #---------------------------------------------------------------------#
  def update
    @profile = Profile.find(params[:id])

    flash[:notice] = "Profile successfully updated!" if @profile.update_attributes(params[:profile])
    respond_with(@profile)

  end
#---------------------------------------------------------------------#
  #--DELETE /profile/1
  #--DELETE /profile/1.xml
  #--DELETE /profile/1.json                                   HTML AND AJAX
  #---------------------------------------------------------------------#
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_with(@profile, :location => root_url)

  end
#---------------------------------------------------------------------#

end

