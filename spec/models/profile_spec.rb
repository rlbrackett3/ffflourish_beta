require 'spec_helper'

describe Profile do

  describe 'fields' do
    it { should have_field :user_name }
    it { should have_field :avatar_filename }
    it { should have_field :about_me }
    it { should have_field(:birthday).of_type(Date) }
    it { should have_fields(:created_at, :updated_at) }
  end

  describe 'associations' do
    it { should be_embedded_in :user }
    it { should embed_many :locations }
    it { should embed_many :websites }

  end
  
end

