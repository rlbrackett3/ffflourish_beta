class FeedbackMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search

  attr_accessible :title, :body, :status, :category

  referenced_in :user, :inverse_of => :feedback_messages

  field :title, :type => String
  field :body, :type => String
  field :status, :type => String, :default => "open"
  field :category, :type => String

  CATS = ["just saying hello", "I have a suggestion", "I have a problem", "about design", "feature request", "other"]

  search_in :title, :body

  validates :title,     :length => { :within => 5..60 }
  validates :body,      :length => { :within => 5..254 }

end

