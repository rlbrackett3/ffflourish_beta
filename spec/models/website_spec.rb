require 'spec_helper'

describe Website do
   describe 'fields' do
    it { should have_field :name }
    it { should have_field :url }
    it { should have_field :info }
    it { should have_fields(:created_at, :updated_at) }
  end

  describe 'associations' do
    it { should be_embedded_in :profile }
  end
  
  describe 'validations' do

  end

end

