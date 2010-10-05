class PagesController < ApplicationController
  
  def home 
    @users = User.all
    @title = "home"   
  end
  
  def about
    @title = "about"
  end
  
  def tour
    @title = "tour"
  end
  
  def terms
    @title = "terms & conditions"
  end
  
  def contact
    @title = "contact"
  end
  
end
