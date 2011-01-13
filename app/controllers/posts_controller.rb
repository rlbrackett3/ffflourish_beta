class PostsController < ApplicationController
  include ActiveModel::Validations
  #-- Filters --#
  before_filter :authenticate_user!

  #-- Responders --#
  respond_to :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def index
    @search_path = user_posts_path
    @user = User.find(params[:user_id])
    @posts = @user.posts.search(params[:search]).desc(:created_at).paginate(:page => params[:page], :per_page => 10)
#    @posts = Post.search(params[:search]).where(:user_id => @user._id).desc(:created_at).paginate(:page => params[:page])
    @post = @user.posts.new

    @title = "#{@user.name}'s posts"
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
    @image = @post.image
    @comments = @post.comments.all

    @title = @post.title

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

    @title = "new post"

    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find(params[:user_id])
    @posts = @user.posts.desc(:created_at).paginate(:page => params[:page]) #to redirect to index
    @post = @user.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        format.html { redirect_to(root_path,
                             :notice => 'Post created successfully!') }
        format.xml  { render :xml => @post,
                             :status => :created,
                             :location => @post }
      else
        format.html { render :action => 'index' }
        format.xml  { render :xml => @post.errors,
                             :status => :unprocessable_entity }
      end
    end
#    flash[:notice] = 'Post created successfully!' if @post.valid?
#    respond_with(@user, @posts)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/edit
  #--GET /users/1/posts/edit.xml
  #--GET /users/1/posts/edit.json                           HTML and AJAX
  #---------------------------------------------------------------------#
  def edit
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @post_title = "editing your post"
    @title = "editing #{@post.title}" if @post.title?
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

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

#    if @post.destroy
#      flash[:notice] = "Post successfully deleted!"
#      redirect_to user_posts_path(@user)
#    end
#    flash[:notice] = "Post successfully deleted!" if @post.update_attributes(params[:post])
    respond_with(@user, :location => user_posts_path(@user))
  end

  def like
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.vote 1, current_user
    @post.add_user_likes(current_user, @post.id)

    if @post.update_attributes(params[:post])
      redirect_to user_posts_path(@user)
    end
  end

end

