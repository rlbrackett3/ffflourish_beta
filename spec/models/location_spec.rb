require 'spec_helper'

describe Location do
   describe 'fields' do
    it { should have_field :city }
    it { should have_field :state }
    it { should have_field :country }
    it { should have_field :postal_code }
    it { should have_fields(:created_at, :updated_at) }
  end

  describe 'associations' do
    it { should be_embedded_in :profile }
  end
  
  describe 'validations' do

  end

end

