class CommentsController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!, :except => [:index, :show]

  #-- Responders --#
  respond_to :html, :xml, :json, :js
  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/posts/comments
  #--GET /users/posts/comments.xml
  #--GET /users/posts/comments.json                         HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create!(params[:comment])
    current_user.comments << @comment

    flash[:notice] = "Comment created successfully!" if @comment.save(params[:comment])
    respond_with(@user, :location => user_following_path(@user))
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1/comments/1
  #--GET /users/1/posts/1/comments/1.xml
  #--GET /users/1/posts/1/comments/1.json                   HTML and AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_with(@user, :location => user_following_path(@user))
  end

end

