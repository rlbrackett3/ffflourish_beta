class CurrentPostsController < ApplicationController
  include PostsHelper
  before_filter :initialize_new_post, :only => :index
  before_filter :authenticate_user!

  def index
  end

  def show
  end

end

