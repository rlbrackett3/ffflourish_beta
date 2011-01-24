class CurrentPostsController < ApplicationController
  include PostsHelper
  before_filter :authenticate_user!
  before_filter :initialize_new_post, :only => :index
  

  def index
    @title = "recent posts"
  end

  def show
  end

end

