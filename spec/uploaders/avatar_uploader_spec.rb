require 'spec_helper'
require 'carrierwave/test/matchers'

describe 'AvatarUploader' do
  include CarrierWave::Test::Matchers
  
  before(:each) do
    AvatarUploader.enable_processing = true
    @user = Factory(:user)
    @uploader = AvatarUploader.new(@user.profile, :avatar) 
    @uploader.store!(File.open(Rails.root.join("public/images/Food_Pic.png")))
  end
  
  after(:each) do
    AvatarUploader.enable_processing = false
  end
  
  describe 'avatar' do
    it 'should resize an image to exactly 64 x 64 pixels' do
      @uploader.avatar.should have_dimension(64, 64)
    end
  end
  
  describe 'profile_image' do
    it 'should resize an image to exactly 50 x 50 pixels' do
      @uploader.avatar.should have_dimension(50, 50)
    end
  end
  
#  it 'should make the image readable only to the and not executable' do
#    uploader.should have_permissions(0600)
#  end
end
