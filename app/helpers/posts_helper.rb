module PostsHelper
  
  def initialize_new_post
    session[:return_to] = request.request_uri
    @current_user = current_user
    @post = @current_user.posts.new
  end
  
end
