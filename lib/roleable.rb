module Rolable 
  extend ActiveSupport::Concern 
  
  ROLES = %w[super admin user] 
  
  included do 
    field :roles,  :type => Array, :default => [] 
  end 
  
  module InstanceMethods 
    def has_role?(role) 
      self.roles.include?(role) 
    end 
