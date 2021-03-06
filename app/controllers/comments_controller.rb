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
    @comments = @post.comments.all.asc(:created_at)

    #keeping track of when a user views a posts comments

    respond_with(@post, @comment, :layout => !request.xhr?)
  end
#----------------------------------------------------------------------#
  def commented_on
    @search_path = commented_on_path
    @user = User.find_by_slug(params[:user_id])
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
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])

    @comment.commenter = current_user.profile.name #test and move to model?
    @comment.user_id = current_user.id #test

    if @comment.save(params[:comment])
      current_user.add_comment_id_to_user(@comment) #test and move to model?
      @post.update_popscore
      flash.now[:notice] = "Comment created successfully!"
    end
    respond_with(@post, @comment, :layout => !request.xhr?)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1/comments/1
  #--GET /users/1/posts/1/comments/1.xml
  #--GET /users/1/posts/1/comments/1.json                   HTML and AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find_by_slug(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    @user.delete_comment_from_comment_ids(@comment)
    @post.update_popscore

    respond_with(@user, :location => user_following_path(@user))
  end

end

