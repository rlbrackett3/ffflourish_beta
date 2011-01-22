require 'spec_helper'

describe Profile do

  describe 'fields' do
    it { should have_field :name }
    it { should have_field :handle }
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
  
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_length_of :name }
    it { should validate_length_of :handle }
  end

end

