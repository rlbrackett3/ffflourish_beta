module PostsHelper
  
  def initialize_new_post
    @current_user = current_user
    @post = @current_user.posts.new
  end
  
end
