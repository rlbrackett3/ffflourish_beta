class PagesController < ApplicationController

  #--GET /home
  #--GET /home.xml
  #--GET /home.json                                       HTML and AJAX
  #-------------------------------------------------------------------#
  def home
    if user_signed_in?
      @user = current_user
      @followed = @user.following_ids
      @profile = @user.profile
      @feed_items = @user.following_feed.paginate(:per_page => 10)
      #listing all users for development
      @users = User.all
      #--Page Title--#
      @title = "#{current_user.first_name}'s feed me+following"
    else
      @title = "home"
    end
  end
  #--GET /about
  #--GET /about.xml
  #--GET /about.json                                      HTML and AJAX
  #-------------------------------------------------------------------#
  def about
    if user_signed_in?
      @user = current_user
    end
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

