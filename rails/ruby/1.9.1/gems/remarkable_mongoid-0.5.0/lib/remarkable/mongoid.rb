module Remarkable
  module Mongoid
  end
end

require 'remarkable/active_model'
require 'remarkable/mongoid/fields'
require 'remarkable/mongoid/associations'
require 'remarkable/mongoid/validate_uniqueness_of'
require 'remarkable/mongoid/validate_association'

if defined?(RSpec) # RSpec 2.x
  RSpec.configure do |config|
    config.include(Remarkable::Mongoid::Matchers)
  end
elsif defined?(Spec) # RSpec 1.x
  Spec::Runner.configure do |config|
    config.include(Remarkable::Mongoid::Matchers)
  end
end
