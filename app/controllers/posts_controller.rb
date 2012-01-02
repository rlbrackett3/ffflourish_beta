class PostsController < ApplicationController
  include ActiveModel::Validations
  include PostsHelper
  #-- Filters --#
  before_filter :authenticate_user!, :except => [:create_before_account]
  before_filter :initialize_new_post, :only => [:index, :new]


  #-- Responders --#
  respond_to :js, :html, :xml, :json

  #-- Methods --#
#----------------------------------------------------------------------#
  #--GET /users/1/posts
  #--GET /users/1/posts.xml
  #--GET /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def index
    @search_path = user_feed_path(@user)
    @user = User.find_by_slug(params[:user_id])
    @posts = @user.posts.csearch(params[:search]).page(params[:page]).per(50).order('created_at DESC') #.search(params[:search])

    @page_title = "ffflourishes"
    @title = "#{@user.profile.name}'s ffflourishes"
    respond_with(@user, @posts)
  end
#----------------------------------------------------------------------#
  def commented_on
    @user = User.find_by_slug(params[:user_id])
    @commented_posts = @user.commented_on_posts.page(params[:page]).per(50)

     @post = @user.posts.new
  end
#----------------------------------------------------------------------#
  #--GET /users/1/posts/1
  #--GET /users/1/posts/1.xml
  #--GET /users/1/posts/1.json                              HTML and AJAX
  #---------------------------------------------------------------------#
  def show
    @user = User.find_by_slug(params[:user_id])
    unless @user.posts == nil
      @post = @user.posts.find(params[:id])
      @image = @post.image
      @comments = @post.comments.all
    end

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

    @title = "new post"

    respond_with(@user, @post)
  end
#----------------------------------------------------------------------#
  #--POST /users/1/posts
  #--POST /users/1/posts.xml
  #--POST /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create
    @user = User.find_by_slug(params[:user_id])
    @posts = @user.posts.csearch(params[:search]).desc(:created_at).page(params[:page]).per(50) #.search(params[:search]) #to redirect to index
    @post = @user.posts.create(params[:post])

#    @user.profile.increment_posts_count

    if @post.save
#      respond_with(@user, @post, :layout => !request.xhr?) #to post through ajax
      respond_to do |format|
        format.html { redirect_back_or_default(@user)
#                     redirect_to(@user,
#                     flash[:notice] = 'Post created successfully!'
                    }
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
  #--POST /users/1/posts
  #--POST /users/1/posts.xml
  #--POST /users/1/posts.json                                HTML and AJAX
  #---------------------------------------------------------------------#
  def create_before_account

    @post = Post.new(params[:post])
    if @post.save
      session[:post_content] = @post.content
      @post.destroy
      respond_with(@post, :location => signup_path)
    else
      flash[:notice] = "Oops, something went wrong, please try again."
      redirect_to root_path
    end

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
    @posts = @user.posts.csearch(params[:search]).desc(:created_at).page(params[:page]).per(50) #.search(params[:search])

    #there seems to be an issue with the default 'respond_with' response for update_attributes and devise??

#    flash[:notice] = "Post successfully updated!" if @post.update_attributes(params[:post])
#    respond_with(@user)

    if @post.update_attributes(params[:post])
      respond_to do |format|
        format.html { redirect_back_or_default(@user)
                    }
        format.xml  { render :xml => @post,
                             :status => :created,
                             :location => @post }
        format.js   { render :layout => !request.xhr?}
      end
    else
      respond_with(@user)
#      flash[:notice] = "There was an error editing your post, please try again."
#      redirect_back_or_default(@user)
    end
#
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

    respond_with(@user, :location => user_posts_path(@user))
  end

  def like
    @user = User.find_by_slug(params[:user_id])
    @post = @user.posts.find(params[:id])
    @post.vote 1, current_user
    unless @post.voted?(current_user) == false
      @post.add_user_likes(current_user) #tests for this method
      @post.update_popscore
    else
      flash.now[:notice] = "You may only like a post once."
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

