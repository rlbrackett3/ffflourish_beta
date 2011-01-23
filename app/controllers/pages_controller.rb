class PagesController < ApplicationController
  include PostsHelper
  before_filter :initialize_new_post, :only => :home
  #--GET /home
  #--GET /home.xml
  #--GET /home.json                                       HTML and AJAX
  #-------------------------------------------------------------------#
  def home
    if user_signed_in?
      @search_path = root_path
      @user = current_user
      @profile = @user.profile
#      @feed_items = @user.following_feed.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
      #--Page Title--#
      @title = "#{current_user.name}'s feed | following"
      @page_title = "following"
    else
      @title = "home"
    end
  end
  #--GET /about
  #--GET /about.xml
  #--GET /about.json                                      HTML and AJAX
  #-------------------------------------------------------------------#
  def about
    @title = "about"
  end
  #--GET /tour
  #--GET /tour.xml
  #--GET /tour.json                                       HTML and AJAX
  #-------------------------------------------------------------------#
  def tour
    @title = "tour"
  end
  #--GET /terms
  #--GET /terms.xml
  #--GET /terms.json                                      HTML and AJAX
  #-------------------------------------------------------------------#
  def terms
    @title = "terms & conditions"
  end
  #--GET /contact
  #--GET /contact.xml
  #--GET /contact.json                                    HTML and AJAX
  #-------------------------------------------------------------------#
  def contact
    @title = "contact"
  end

end

