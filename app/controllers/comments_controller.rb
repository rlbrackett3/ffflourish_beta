class CommentsController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!, :except => [:index, :show]

  #-- Responders --#
  respond_to :html, :xml, :json, :js
  #-- Methods --#
#----------------------------------------------------------------------#
  def index
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comments = @post.comments.all.desc(:created_at)

    respond_with(@post, @comment, :layout => !request.xhr?)
  end
#----------------------------------------------------------------------#
  def commented_on
    @user = User.find_by_slug(params[:user_id])
    @post
  end
#----------------------------------------------------------------------#
  def new
    @comment = Comment.new
  end
#----------------------------------------------------------------------#
  #--GET /users/posts/comments
  #--GET /users/posts/comments.xml
  #--GET /users/posts/comments.json                         HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])

    @comment.commenter = current_user.profile.name#test and move to model?

    if @comment.save(params[:comment])
      current_user.comments << @comment #test and move to model?
      current_user.profile.increment_comments_count#test and move to model?
      flash[:notice] = "Comment created successfully!"
    end
#    respond_with(@user, :location => user_following_path(@user))
    respond_with(@post, @comment, :layout => !request.xhr?)
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

    @user.profile.decrement_comments_count

    respond_with(@user, :location => user_following_path(@user))
  end

end

