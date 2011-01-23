class FollowingPostsController < ApplicationController
  include PostsHelper
  before_filter :initialize_new_post, :only => :index
  before_filter :authenticate_user!
  
  def index
    @search_path = user_following_path(@user)
    @user = current_user
    @profile = @user.profile
    @feed_items = @user.following_feed.search(params[:search]).paginate(:page => params[:page], :per_page => 50)
    if request.xhr?
#      sleep(3) # make request a little bit slower to see loader :-)
      render :partial => "shared/feed"
    end
    #--Page Title--#
    @title = "#{current_user.name}'s | following feed"
    @page_title = "following"
  end

end
