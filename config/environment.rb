# Load the rails application
require File.expand_path('../application', __FILE__)
#--HAML Options--#
Haml::Template.options[:format] = :html5
Haml::Template.options[:escape_html] = true
Haml::Template.options[:ugly] = true

# Initialize the rails application
Ffflourish::Application.initialize!

#make rails aware of middleware folder
#%w(middleware).each do |dir|
#  config.load_paths << "#{RAILS_ROOT}/app/#{dir}"
#end

