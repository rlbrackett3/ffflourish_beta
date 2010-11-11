class PostsController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!, :except => [:index, :show]

  #-- Responders --#
  respond_to :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all

    respond_with(@user, @posts)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @comments = @post.comments.all

    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/new
  #--GET /users/1/posts/new.xml
  #--GET /users/1/posts/new.json                            HTML and AJAX
  #---------------------------------------------------------------------#
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create!(params[:post])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/edit
  #--GET /users/1/posts/edit.xml
  #--GET /users/1/posts/edit.json                           HTML and AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.first

    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??
    flash[:notice] = "Post successfully updated!" if @post.update_attributes(params[:post])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
#    flash[:notice] = "Post successfully deleted!" if @post.update_attributes(params[:post])
    respond_with(@user, :location => user_posts_path)
  end

  def like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.vote 1, current_user
    
    if @post.update_attributes(params[:post])
      redirect_to user_posts_path
    end
  end

end

