# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
Factory.find_definitions
require 'remarkable/active_model'
require 'remarkable/mongoid'
require 'database_cleaner'
require 'fabrication'

include Devise::TestHelpers

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  config.mock_with :rspec
  
  #--mongoid-rspec--#
  config.include Mongoid::Matchers
  
  # config.before :each do
  #   Mongoid.master.collections.select{|c| c.name !~ /system/ }.each(&:drop)
  # end
  
  #--use database cleaner to clear mongoDB test data--#
  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.orm = "mongoid"
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
  
  #--My Nethods--#
  
  def test_sign_in(user)
    controller.current_user = user
  end

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  # config.use_transactional_fixtures = true
end
