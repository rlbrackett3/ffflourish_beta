require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However, 
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require 'factory_girl_rails'
Factory.find_definitions
require 'remarkable/active_model'
require 'remarkable/mongoid'
require 'database_cleaner'
require 'fabrication'

include Devise::TestHelpers

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}


end

Spork.each_run do
  # This code will be run each time you run your specs.
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

  end
  
end


  

