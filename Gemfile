source 'http://rubygems.org'
#--Rails--#
gem 'rails', '3.0.3'


#--Deploy with Heroku--#
gem 'heroku'
gem 'heroku-rails'

#--Authentication with Devise--#
gem 'devise'#, '~>1.1.3'
gem 'devise_invitable'#, '~> 0.3.4'

#--Mongoid and MongoDB specific gems--#
gem 'mongoid', '~> 2.0.0.beta.20'
gem 'bson_ext'
gem 'mongoid_voteable'
#gem 'mongoid_slug', :require => 'mongoid/slug'
gem 'mongoid_taggable'
gem 'mongoid_search', :git => 'https://github.com/mauriciozaffari/mongoid_search.git'

#--Image uploads and storage--#
gem 'carrierwave', :git => 'http://github.com/jnicklas/carrierwave.git'
gem 'fog'
gem 'aws-s3'
gem 'mini_magick'

#--General Utility Gems--#
gem 'will_paginate', '~> 3.0.pre2'
gem 'jquery-rails'
gem 'ffaker'

#--HAML support--#
gem 'haml'

group :development, :test do
  gem 'mongrel', '>=1.2.0.pre2'
  #--Rspec--#
  gem "rspec-rails", '>=2.0.1'
  gem 'fuubar'
  #--Cucumber--#
  gem 'cucumber'
  gem 'cucumber-rails'
  #--Cucumber extras--#
  gem 'pickle'
  gem 'pickle-mongoid'
  gem 'spork'
  gem 'launchy' # So you can do Then show me the page
  #--generating test and sample data--#
  #gem 'fabrication'
  #gem 'factory_girl'
  gem 'factory_girl_rails'
#  gem 'faker'
  #--Ruby debugger--#
  # gem 'ruby-debug19'
  #--Autotest--#
  gem 'autotest', '>=4.4.1'
  gem 'autotest-rails', '>=4.1.0'
  gem 'autotest-notification'
  gem 'parallel_tests'
end

group :development do
  gem 'rails3-generators'
  #--HAML support--#
  gem 'haml-rails'
  gem 'hpricot'
  gem 'ruby_parser'
  #--Annotate-models--#
  gem 'annotate-models'
end

group :test do
  #--Rspec Helpers--#
  gem 'mongoid-rspec'
  gem 'remarkable_activemodel', '4.0.0.alpha4'
  gem 'remarkable_mongoid'
  #--Browser simulation--#
  gem 'webrat' #for Rspec controller specs with views
  gem 'capybara' #for cucumber and javascript

  #--clearing the mongoDB for mongoid testing--#
  gem 'database_cleaner'
end

