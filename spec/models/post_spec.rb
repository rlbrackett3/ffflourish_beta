require 'spec_helper'

describe Post do
#------------------------------------------------#
  # Defines a sample user
#  before do
#    @user = Factory(:user)
#  end
#------------------------------------------------#
  describe "fields" do

    it { should have_field :title }
    it { should have_field :content }
    it { should have_field :created_at }
    it { should have_field :updated_at }
    it { should have_field :user_id }

    it { should have_field :image_filename }

    describe "voting" do
      it { should have_field :votes }
      it { should have_field :voters }
    end

    describe "feed classification" do
      it { should have_field(:public).of_type(Boolean).with_default_value_of(false)}
      it { should have_field(:followers).of_type(Boolean).with_default_value_of(true)}
      it { should have_field(:private).of_type(Boolean).with_default_value_of(false)}
    end

  end
#------------------------------------------------#
  describe "associations" do

    it { should be_referenced_in :user }
    it { should embed_many :comments }

  end
#------------------------------------------------#
  describe "validations" do

    it { should validate_presence_of :title }
    it { should validate_length_of :title }
    it { should validate_length_of :content }

  end
#------------------------------------------------#
  describe "build post" do

  end
#------------------------------------------------#
  describe "deleting dependencies" do
    before do
      @user = Factory(:user)
    end

    it "should delete a post's comments on destroy" do
      post = Factory(:post)
      post.comments.create(:content => "comment")
      post.destroy
      Post.all(:id => post.id).empty?.should == true
      Comment.all(:text => "comment").empty?.should == true
    end

  end
#------------------------------------------------#
end

