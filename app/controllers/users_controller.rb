class UsersController < ApplicationController
 #-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

#-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1
  #--GET /users/1.xml
  #--GET /users/1.json                                       HTML and AJAX
  #----------------------------------------------------------------------#
  def show
    @user = User.find(params[:user_id])
    @title = "#{current_user.first_name}'s Profile"

    respond_with(@user, @profile)
  end
#----------------------------------------------------------------------#
#----------------------------------------------------------------------#
  #--GET /profile/(1)user_name/edit
  #--GET /profile/(1)user_name/edit.xml
  #--GET /profile/(1)user_name/edit.json                    HTML AND AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = User.find(params[:id])
    @profile = @user.profile
    @profile.locations =[ Location.new ] if @profile.locations.empty?
    @profile.websites =[ Website.new ] if @profile.websites.empty?

    @title = "updating #{current_user.first_name}'s ffflourish.stats"

    respond_with(@user)
  end
#---------------------------------------------------------------------#
  #--PUT /profile/1
  #--PUT /profile/1.xml
  #--PUT /profile/1.json                                      HTML AND AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find(params[:id])
    @user.profile.update_attributes(params[:user])
    @profile = @user.profile
    @profile.update_attributes(params[:profile])
    @location = @profile.locations
    @location.update_attributes(params[:location])
    @website = @profile.websites
    @website.update_attributes(params[:website])
#    flash[:notice] = "Profile successfully updated!" if @user.update_attributes(params[:user])
#    respond_with(@profile)
#    respond_with(@user) do |format|
#      format.html { redirect_to profile_path(@user) }
#    end
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'Profile was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sample_rest.errors, :status => :unprocessable_entity }
      end
    end

  end
#---------------------------------------------------------------------#
  #--DELETE /profile/1
  #--DELETE /profile/1.xml
  #--DELETE /profile/1.json                                   HTML AND AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(@user, :location => root_url)

  end
#---------------------------------------------------------------------#

end

