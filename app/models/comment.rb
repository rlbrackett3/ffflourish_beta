class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :content, :commenter
  #--Associations--#
  embedded_in     :post#, :inverse_of => :comments
  #--data fields--#
  field :content, :type => String
  field :commenter, :type => String, :index => true
  field :user_id#, :type => String
#  field           :viewed, :type => Array, :default => []

  index( [ :created_at, Mongo::ASCENDING ] )
  #--validations--#
  validates :content,   :presence => true,
                        :length => { :within => 3..513 }
  validates :commenter, :presence => true

end

