# Load the rails application
require File.expand_path('../application', __FILE__)
#--HAML Options--#
Haml::Template.options[:format] = :html5
Haml::Template.options[:escape_html] = true
Haml::Template.options[:ugly] = true

# Initialize the rails application
Ffflourish::Application.initialize!
