class PopularPostsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @popular_posts = Post.pop_posts.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

end

