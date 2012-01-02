require 'spec_helper'

describe Comment do
#------------------------------------------------#
  describe "fields" do

    it { should have_field :content }
    it { should have_field :commenter}
    it { should have_field :created_at }
    it { should have_field :updated_at }
    it { should have_field :user_id }
    it { should have_field :viewed }

  end
#------------------------------------------------#
  describe "associations" do

    it { should be_referenced_in(:user) }
    it { should be_embedded_in(:post).as_inverse_of(:comments) }

  end
#------------------------------------------------#
  describe "validations" do

    it { should validate_presence_of :content }
    it { should validate_length_of :content }
    it { should validate_presence_of :commenter }

  end
#------------------------------------------------#
end

