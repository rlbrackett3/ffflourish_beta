class RandomPostsController < ApplicationController
  #-- Responders --#
  respond_to :js, :html, :xml, :json
  def show
    @random_post = Post.random
    respond_with @random_post
  end
end
