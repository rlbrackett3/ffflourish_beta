class PostsController < ApplicationController
  include ActiveModel::Validations
  include PostsHelper
  #-- Filters --#
  before_filter :authenticate_user!
  before_filter :initialize_new_post, :only => [:index, :new]
  before_filter :rendom_post, :only => :index

  #-- Responders --#
  respond_to :js, :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def index
    @search_path = user_posts_path
    @user = User.find_by_slug(params[:user_id])
    @posts = @user.posts.search(params[:search]).desc(:created_at).paginate(:page => params[:page], :per_page => 10)
    @post = @user.posts.new

    @title = "#{@user.profile.name}'s posts"
    respond_with(@user, @posts)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def show
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:id])
    @image = @post.image
    @comments = @post.comments.all

    @title = @post.created_at

    respond_with(@user, @post)

  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/new
  #--GET /users/1/posts/new.xml
  #--GET /users/1/posts/new.json                            HTML and AJAX
  #---------------------------------------------------------------------#
  def new
    @user = User.find_by_slug(params[:user_id])
#    @post = @user.posts.new

    @title = "new post"

    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find_by_slug(params[:user_id])
    @posts = @user.posts.search(params[:search]).desc(:created_at).paginate(:page => params[:page], :per_page => 10) #to redirect to index
    @post = @user.posts.build(params[:post])

    @user.profile.increment_posts_count

    if @post.save
#      respond_with(@user, @post, :layout => !request.xhr?) #to post through ajax
      respond_to do |format|
        format.html { redirect_to(@user,
                             :notice => 'Post created successfully!') }
        format.xml  { render :xml => @post,
                             :status => :created,
                             :location => @post }
        format.js   { render :layout => !request.xhr?}
      end
    else
      respond_with(@user)
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
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:id])

    @post_title = "editing your post"
#    @title = "editing #{@post.title}" if @post.title?
    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def update
    @user = User.find_by_slug(params[:user_id])
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
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.destroy

    @user.profile.decrement_posts_count

    respond_with(@user, :location => user_posts_path(@user))
  end

  def like
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.vote 1, current_user
    unless @post.voted?(current_user) == false
      @post.add_user_likes(current_user) #tests for this method
      current_user.profile.increment_likes_count #tests for this method
    else
      flase[:notice] = "You may only like a post once."
    end

    if @post.update_attributes(params[:post])
#      redirect_to(user_following_path(current_user))
      respond_with(@user, @post, :layout => !request.xhr?)
    else
      respond_with(current_user)
    end
  end
  
  def likers # add tests for this method
    @post = Post.find(params[:id])
    @likers = @post.liked_by
    
    respond_with(@post, @likers, :layout => !request.xhr?)
  end

end

