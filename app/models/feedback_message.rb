class FeedbackMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  
  attr_accessible :title, :body, :status, :category
  
  referenced_in :user, :inverse_of => :feedback_messages
  
  field :title
  field :body
  field :status, :default => "open"
  field :category
  
  CATS = ["just saying hello", "I have a suggestion", "I have a problem", "about design", "feature request", "other"]
  
  search_in :title, :body
  
  validates :title,     :length => { :within => 5..60 }
  validates :body,      :length => { :within => 5..254 }
  
end
