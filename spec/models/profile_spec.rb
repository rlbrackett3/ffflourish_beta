require 'spec_helper'

describe Profile do

  describe 'fields' do
    it { should have_field :name }
    it { should have_field :handle }
    it { should have_field :avatar_filename }
    it { should have_field :about_me }
    it { should have_field(:birthday).of_type(Date) }
    it { should have_fields(:created_at, :updated_at) }

    describe 'count fields' do
      it { should have_field :likes_count }
      it { should have_field :posts_count }
      it { should have_field :comments_count }
      it { should have_field :following_count }
      it { should have_field :follower_count }

    end

  end

  describe 'associations' do
    it { should be_embedded_in :user }
    it { should embed_many :locations }
    it { should embed_many :websites }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of :name }
    it { should validate_length_of :handle }
  end

  # this stuff is nasty and repetative
  # refactor
  describe 'incrementing and decrementing count fields' do
    let(:user)          { Factory(:user) }
    let(:other_user)    { Factory(:user, :email => Factory.next(:email)) }
    let(:post)          { Factory(:post, :user => other_user)}

    it { should respond_to(:increment_likes_count) }
    it { should respond_to(:increment_posts_count) }
    it { should respond_to(:decrement_posts_count) }
    it { should respond_to(:increment_comments_count) }
    it { should respond_to(:decrement_comments_count) }
    it { should respond_to(:increment_following_count) }
    it { should respond_to(:decrement_following_count) }
    it { should respond_to(:increment_follower_count) }
    it { should respond_to(:decrement_follower_count) }

    describe 'likes count' do

      it 'should be set to "0"' do
        user.profile.likes_count.should == 0
      end

      it 'should increase the users likes_count by 1' do
        user.profile.increment_likes_count
        user.profile.likes_count.should == 1
      end
    end

    describe 'posts count' do

      it 'should be set to "0"' do
        user.profile.posts_count.should == 0
      end

      it 'should increment the users likes_count by 1' do
        user.profile.increment_posts_count
        user.profile.posts_count.should == 1
      end

      it 'should decrement the users likes_count by 1' do
        user.profile.increment_posts_count
        user.profile.decrement_posts_count
        user.profile.posts_count.should == 0
      end
    end

    # This one is trickier because users can delete their own comments and
    # they may delete comments from other users on their posts
    # these are initial tests but should be revisited #################
    describe 'comments count' do

      it 'should be set to "0"' do
        user.profile.comments_count.should == 0
      end

      it 'should increment the users likes_count by 1' do
        user.profile.increment_comments_count
        user.profile.comments_count.should == 1
      end

      it 'should decrement the users likes_count by 1' do
        user.profile.increment_comments_count
        user.profile.decrement_comments_count
        user.profile.comments_count.should == 0
      end
    end

    describe 'following count' do

      it 'should be set to "0"' do
        user.profile.following_count.should == 0
      end

      it 'should increment the users likes_count by 1' do
        user.profile.increment_following_count
        user.profile.following_count.should == 1
      end

      it 'should decrement the users likes_count by 1' do
        user.profile.increment_following_count
        user.profile.decrement_following_count
        user.profile.following_count.should == 0
      end
    end

    describe 'follower count' do

      it 'should be set to "0"' do
        user.profile.follower_count.should == 0
      end

      it 'should increment the users likes_count by 1' do
        user.profile.increment_follower_count
        user.profile.follower_count.should == 1
      end

      it 'should decrement the users likes_count by 1' do
        user.profile.increment_follower_count
        user.profile.decrement_follower_count
        user.profile.follower_count.should == 0
      end
    end
  end
end

