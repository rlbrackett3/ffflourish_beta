class StatsController < ApplicationController
#-- Filters --#
  before_filter :authenticate_user!

#-- Responders --#
  respond_to :html, :xml, :json

#-- Methods --#
  #--GET /users/1
  #--GET /users/1.xml
  #--GET /users/1.json                                       HTML and AJAX
  #----------------------------------------------------------------------#
  def show
    @user = current_user
    @stat = Stat.find(params[:id])
    
    @title = "hello #{current_user.first_name}"

    respond_with(@user, @stat)
  end
#----------------------------------------------------------------------#
  #--GET /stats/new
  #--GET /stats/new.xml
  #--GET /stats/new.json                                    HTML AND AJAX
  #---------------------------------------------------------------------#
  def new
    @user = current_user
    @stat = Stat.new
    @stat.locations.build(:attrs => {}, :type => nil)
    @stat.websites.build(:attrs => {}, :type => :nil)

    @title = "setting up #{current_user.first_name}'s ffflourish.stats"

    respond_with(@user, @stat)

  end
#---------------------------------------------------------------------#
  #--GET /stats/1/edit
  #--GET /stats/1/edit.xml
  #--GET /stats/1/edit.json                                 HTML AND AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = current_user
    @stat = Stat.find(params[:id])
    @title = "updating #{current_user.first_name}'s ffflourish.stats"

    respond_with(@stat, @location, @website)
  end
#---------------------------------------------------------------------#
  #--POST /stats
  #--POST /stats.xml
  #--POST /stats.json                                       HTML AND AJAX
  #---------------------------------------------------------------------#
  def create
    @user = current_user

    @stat = Stat.new(params[:stat])

    @user.stats << @stat
    @location = Location.new(params[:location])
    @stat.locations << @location
    @website = Website.new(params[:website])
    @stat.websites << @website

    flash[:notice] = "Your stats were successfully created." if @stat.save
    respond_with(@stat, @location, @website)
#    respond_to do |format|
#      if @stat.save
#        format.html { redirect_to( @user,
#                  :notice => 'Your stats were successfully created.') }
#        format.xml  { render  :xml => @user,
#                              :status => :created, :location => @stat }
#      else
#        format.html { render  :action => "new" }
#        format.xml  { render  :xml => @stat.errors,
#                              :status => :unprocessable_entity }
#      end
#    end

  end
#---------------------------------------------------------------------#
  #--PUT /stats/1
  #--PUT /stats/1.xml
  #--PUT /stats/1.json                                      HTML AND AJAX
  #---------------------------------------------------------------------#
  def update
    @stat = Stat.find(params[:id])
    @stat.update_attributes #(params(:stat))

    flash[:notice] = "Profile successfully updated!" if @contact.update_attributes
    respond_with(@stat)

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
  #--DELETE /stats/1
  #--DELETE /stats/1.xml
  #--DELETE /stats/1.json                                   HTML AND AJAX
  #---------------------------------------------------------------------#
  def destroy
    @stat = Stat.find(params[:id])
    @stat.destroy

    respond_with(@stat, :location => root_url)

#    respond_to do |format|
#      format.html { redirect_to(stats_url) }
#      format.xml  { head :ok }
#    end

  end
#---------------------------------------------------------------------#
end

