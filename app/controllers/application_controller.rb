class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :ensure_domain if Rails.env.production?
  
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
      user_feed_url(user)
    else
      super
    end
  end
  

  
  if Rails.env.production?
    TheDomain = 'ffflourish.com'
    
    def ensure_domain
      if request.env['HTTP_HOST'] != TheDomain
        redirect_to TheDomain
      end
    end
  end
end

