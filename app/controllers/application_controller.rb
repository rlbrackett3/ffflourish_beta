class ApplicationController < ActionController::Base
  protect_from_forgery
#  before_filter :ensure_domain if Rails.env.production?
  
  # rescue from permissions errors
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  # generate a random post on any page
  def random_post
    @random_post = Post.random
  end

  # change devise defaul signin redirect
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && user_signed_in?
      user = current_user
      recent_url
    else
      super
    end
  end
  
#  if Rails.env.production?
#    TheDomain = 'www.ffflourish.com'
#    
#    def ensure_domain
#      if request.env['HTTP_HOST'] != TheDomain
#        redirect_to TheDomain
#      end
#    end
#  end
  
  private
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default, :notice => "Success!")
    session[:return_to] = nil
  end
end

