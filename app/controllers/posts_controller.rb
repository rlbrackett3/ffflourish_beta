class PostsController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!, :except => [:index, :show]

  #-- Responders --#
  respond_to :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /posts
  #--GET /posts.xml
  #--GET /posts.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.all
    respond_with(@user, @posts)
  end
#----------------------------------------------------------------------#
  #--GET /posts/1
  #--GET /posts/1.xml
  #--GET /posts/1.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def show
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /posts/new
  #--GET /posts/new.xml
  #--GET /posts/new.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def new
    @user = User.find(params[:user_id])
    @post = @user.posts.new
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /posts
  #--GET /posts.xml
  #--GET /posts.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find(params[:user_id])
    @post = @user.posts.create!(params[:post])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /posts/edit
  #--GET /posts/edit.xml
  #--GET /posts/edit.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /posts/1
  #--GET /posts/1.xml
  #--GET /posts/1.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.first

    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??
    flash[:notice] = "Post successfully updated!" if @post.update_attributes(params[:post])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /posts/1
  #--GET /posts/1.xml
  #--GET /posts/1.json                                    HTML and AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy
    respond_with(@user, @post)
  end
end

