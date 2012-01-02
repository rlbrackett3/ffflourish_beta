source 'http://rubygems.org'
#--Rails--#
gem 'rails', '3.0.9'

#--Deploy with Heroku--#
gem 'heroku'
gem 'taps'
gem 'jammit'

#--Mongoid and MongoDB specific gems--#
gem 'mongoid', '~> 2.0'
#gem 'mongo', '~> 1.3'
gem 'bson_ext', '~> 1.3'
gem 'mongoid_voteable'
gem 'mongoid_slug'#, '0.5.1', :require => 'mongoid/slug' # freeze at 0.5.1 for mongoid beta 20
gem 'mongoid_taggable'
gem 'mongoid_search'#, :git => 'git://github.com/mauriciozaffari/mongoid_search.git'

#--Authentication with Devise--#
gem 'devise'
gem 'devise_invitable'#, '~> 0.3.5'
gem 'cancan'

#--Image uploads and storage--#
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
# gem 'carrierwave' #:git => 'git://github.com/jnicklas/carrierwave.git'
gem 'fog'
gem 'aws-s3'
gem 'mini_magick'

#--General Utility Gems--#
gem 'kaminari'
#gem "will_paginate_mongoid"
#gem 'will_paginate'
gem 'jquery-rails'
gem 'remotipart'
gem 'validated_fields', :git => 'http://github.com/alluniq/validated-fields.git'

#--generating test and sample data--#
gem 'factory_girl_rails'
gem 'ffaker'

#--HAML support--#
gem 'haml'
gem 'sass'

group :development, :test do
  gem 'mongrel', '>=1.2.0.pre2'
  #--Rspec--#
  gem "rspec-rails"#, '>=2.4.1'
  gem 'fuubar'
  #--Cucumber--#
  gem 'cucumber-rails'
  gem 'fuubar-cucumber'
  gem 'slowhandcuke'
  #--Cucumber extras--#
  gem 'pickle'
  gem 'pickle-mongoid'
  gem 'spork', :git => "git://github.com/chrismdp/spork.git"
  gem 'launchy' # So you can do Then show me the page
  #--Ruby debugger--#
  gem 'ruby-debug19' if RUBY_VERSION.include? "1.9"
  gem 'ruby-debug' if RUBY_VERSION.include? "1.8"
  #--Autotest--#
  gem 'autotest', '>=4.4.1'
  gem 'autotest-rails', '>=4.1.0'
  gem 'autotest-notification'
  #gem 'parallel_tests'
end

group :development do
  # heroku san to manage multiple devployment environments
#  gem 'heroku_san'
  gem 'heroku-rails'
  #misc
  gem 'rails3-generators'
  #--HAML support--#
  gem 'haml-rails'
#  gem 'sass-rails'
  gem 'hpricot'
  gem 'ruby_parser'
end

group :test do
  #--Rspec Helpers--#
  gem 'mongoid-rspec' #head required mongoid 2.0.0
  gem 'remarkable_activemodel', '4.0.0.alpha4'
  gem 'remarkable_mongoid'
  #--Browser simulation--#
  gem 'webrat' #for Rspec controller specs with views
  gem 'capybara' #for cucumber and javascript

  #--clearing the mongoDB for mongoid testing--#
  gem 'database_cleaner'
end

