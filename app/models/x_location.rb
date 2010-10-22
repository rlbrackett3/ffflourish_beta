class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_protected  :_id
  
  field :city
  field :state
  field :country
  field :postal_code
  
  embedded_in :stat,  :inverse_of => :locations
  
end
