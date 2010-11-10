class PagesController < ApplicationController

  #--GET /home
  #--GET /home.xml
  #--GET /home.json                                       HTML and AJAX
  #-------------------------------------------------------------------#
  def home
    if user_signed_in?
      @user = current_user
      @profile = @user.profile
      #listing all users for development
      @users = User.all
      #--Page Title--#
      @title = "#{current_user.first_name}'s home"
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

