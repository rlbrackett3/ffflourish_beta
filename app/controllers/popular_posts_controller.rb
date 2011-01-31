class PopularPostsController < ApplicationController
  include PostsHelper
  before_filter :initialize_new_post, :only => :index
  before_filter :authenticate_user!
  #-- Responders --#
  respond_to :js, :html, :xml, :json

  def index
    @title = "popular ffflourishes"
    @page_title = "popular"
    
    @user = current_user
    @popular_posts = Post.popular.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

end

