class CurrentPostsController < ApplicationController
  include PostsHelper
  before_filter :authenticate_user!
  before_filter :initialize_new_post, :only => :index
  #-- Responders --#
  respond_to :js, :html, :xml, :json


  def index
    @search_path = recent_path
    @title = "recent posts"
#    @page_title = "recent"

    @user = current_user
    @recent_posts = Post.recent.page(params[:page]).per(31)
  end

  def show
  end

end

