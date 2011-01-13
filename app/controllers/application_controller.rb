class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource_or_scope)
    if resource_or_scope.is_a?(User) && user_signed_in?
      user = current_user
      user_url(user)
    else
      super
    end
  end

end

