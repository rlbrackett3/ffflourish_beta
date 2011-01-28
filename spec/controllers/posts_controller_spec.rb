require 'spec_helper'

describe PostsController do
  include Devise::TestHelpers
  render_views
#------------------------------------------------#
  def get_user_post_id(action)
    get action, :user_id => @user.slug, :id => @post._id.to_s
  end

  def get_user_post(action)
    get action, :user_id => @user.slug
  end

  def post_user_post(action)
    post action, :user_id => @user.slug
  end

   def put_user_post(action)
    put action, :user_id => @user.slug, :id => @post._id.to_s
  end

  def delete_user_post(action)
    delete action, :user_id => @user.slug, :id => @post._id.to_s
  end
#------------------------------------------------#
  describe "Access Control" do
    before do
      @user = Factory(:user)
      @post = Factory(:post, :user => @user)
    end

    it "should deny access to 'index'" do
        get_user_post(:index)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'show'" do
        get_user_post_id(:show)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'new'" do
        get_user_post(:new)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'create'" do
        post_user_post(:create)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'edit'" do
        get_user_post_id(:edit)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'update'" do
        put_user_post(:update)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end

    it "should deny access to 'destroy'" do
        delete_user_post(:destroy)
        response.should redirect_to(new_user_session_path)
        flash[:alert].should =~ /sign in/
    end
  end
#------------------------------------------------#
  describe "Methods" do
    before do
      @user = Factory(:user)
      @post = Factory(:post, :user => @user)
      sign_in  @user
    end
  #------------------------------------------------#
    describe "GET index" do
      it "should allow access" do
        get_user_post(:index)
        response.should render_template(:index)#be_success
      end

      it "should have the correct title" do
        get_user_post(:index)
        response.should have_selector("title",
              :content => "ffflourish | #{@user.profile.name}'s posts")
      end
    end
  #------------------------------------------------#
    describe "GET show" do

      it "should allow access" do
        get_user_post_id(:show)
        response.should be_success
      end

      it "should have the correct title" do
        get_user_post_id(:show)
        response.should have_selector("title",
            :content => "ffflourish | #{@post.created_at}")
      end
    end
  #------------------------------------------------#
    describe "GET new" do

      it "should allow access" do
        get_user_post(:new)
        response.should be_success
      end

      it "should have the correct title" do
        get_user_post(:new)
        response.should have_selector("title",
            :content => "ffflourish | new post")
      end
    end
  #------------------------------------------------#
    describe "POST create" do
    #------------------------------------------------#
      describe "failure" do
        before do
          @attr = { :content => "" }
        end

        it "should not create a post" do
#          lambda do
#            post 'create', :user_id => @user._id.to_s
#          end.should_not change(Post, :count)
          lambda do
            post = Post.create(:content => "x")
          end.should_not change(Post, :count)
        end

        it "should re-render the 'index' page on failed save" do
          Post.stub!(:valid?).and_return(false)
          post = Post.create(:content => "x")
          response.should_not be_valid #render_template(:index)
        end
      end
    #------------------------------------------------#
      describe "success" do
        before do
          @attr = { :content => "Post content", :user_id => @user }
        end
        let(:user)          { Factory(:user) }
        let(:other_user)    { Factory(:user, :email => Factory.next(:email)) }
        let(:post)          { Factory(:post, :user => other_user)}

        it "create a new post" do
          lambda do
            p = Factory(:post, :user => user)
            p.save
          end.should change(Post, :count).by(1)
        end

        it "should redirect to the user's posts page" do
          post = Factory(:post, :user => user)
          redirect_to(user_posts_path(@user))#response.should be_success #
          flash[:notice].should contain("Post created successfully!")
        end

        describe 'posts count' do

          it 'should increment a users posts count on create' do
            p = Post.create!(:content => "bairs", :user_id => user)
            p.save
            user.profile.posts_count.should == 1
          end

        end
      end
    #------------------------------------------------#
    end
  #------------------------------------------------#
  end
#------------------------------------------------#
end

