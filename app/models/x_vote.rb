class Vote
  include Mongoid::Document
  include Mongoid::Timestamps
  
  attr_protected  :_id
  
  referenced_in   :post
  referenced_in   :user
  
end
