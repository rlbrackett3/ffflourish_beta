class RegistrationsController < Devise::RegistrationsController 
  
  def create
    build_resource
    resource.role = "user"

    if resource.save
#      user = User.find(params[:user][:urlname])
#      @post.update_attributes!(:user_id => )
      if session[:post_content]
         resource.posts.create(:content => session[:post_content])
         session[:post_content] = nil if resource.valid?
      end
     
      if resource.active?
        set_flash_message :notice, :signed_up
        sign_in_and_redirect(resource_name, resource)
      else
        set_flash_message :notice, :inactive_signed_up, 
                                   :reason => resource.inactive_message.to_s
        expire_session_data_after_sign_in!
        redirect_to after_inactive_sign_up_path_for(resource)
      end
    else
      session[:post_content] = nil
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
