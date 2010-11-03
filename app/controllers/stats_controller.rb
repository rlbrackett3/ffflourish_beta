class StatsController < ApplicationController
#-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

#-- Methods --#
#---------------------------------------------------------------------#
  #--GET /stats/1/edit
  #--GET /stats/1/edit.xml
  #--GET /stats/1/edit.json                                 HTML AND AJAX
  #---------------------------------------------------------------------#
  def edit
    @profile = Profile.current_user

    @title = "updating #{current_user.first_name}'s ffflourish.stats"

    respond_with(@profile)
  end
#---------------------------------------------------------------------#
  #--PUT /stats/1
  #--PUT /stats/1.xml
  #--PUT /stats/1.json                                      HTML AND AJAX
  #---------------------------------------------------------------------#
  def update
    @profile = Profile.find(params[:id])

    flash[:notice] = "Profile successfully updated!" if @profile.update_attributes
    respond_with(@profile)

#    respond_to do |format|
#      if @stat.update_attributes(params[:stat])
#        format.html { redirect_to(@stat, :notice => 'Stat was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @stat.errors, :status => :unprocessable_entity }
#      end
#    end

  end
#---------------------------------------------------------------------#
end

