class ImagesController < ApplicationController
  #-- Filters --#
  before_filter :authenticate_user!

  #-- Responders --#
  respond_to :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1/images
  #--GET /users/1/posts/1/images.xml
  #--GET /users/1/posts/1/images.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @image = Image.build(params[:image])
    @user.images << @image
    @post.images << @image
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @image = @post.images.find(params[:id])
    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??
    flash[:notice] = "Image successfully updated!" if @image.update_attributes(params[:image])
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def destroy
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:post_id])
    @image = @post.images.find(params[:id])
    @image.destroy
#    flash[:notice] = "Image successfully deleted!" if @post.update_attributes(params[:post])
    respond_with(@user, @post, :location => user_post_path)
  end

end

