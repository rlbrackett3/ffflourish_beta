class ApplicationController < ActionController::Base
  protect_from_forgery
#  before_filter :random_post
  
  # generate a random post on any page
  def random_post
    @random_post = Post.random
  end

  # change devise defaul signin redirect
  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && user_signed_in?
      user = current_user
      user_following_url(user)
    else
      super
    end
  end

end

