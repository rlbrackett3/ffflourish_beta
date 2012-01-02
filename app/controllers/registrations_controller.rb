class RegistrationsController < Devise::RegistrationsController

  def create
    build_resource
    resource.role = "user"
    if session[:post_content]
      @post_content = session[:post_content]
    end

    if resource.save

      if @post_content
         resource.posts.create(:content => @post_content)
         session[:post_content] = nil if resource.valid?
      else
        nil
      end

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up
        sign_in_and_redirect(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up,
                                   :reason => resource.inactive_message.to_s
        expire_session_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords(resource)
      render_with_scope :new
    end
  end

  def token
    #@user = User.where(:id => params[:user_id]).first
    #@user.reset_authentication_token!
    redirect_to edit_user_registration_path(@user)
  end

end

