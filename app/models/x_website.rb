class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_protected  :_id
  
  field :name
  field :url
  field :info
  
  embedded_in :stat,  :inverse_of => :websites
  
end
