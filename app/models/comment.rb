class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_accessible :content, :commenter
  #--Associations--#
  referenced_in   :user, :stored_as => :array,
                         :inverse_of => :comments,
                         :index => true
  embedded_in     :post, :inverse_of => :comments
  #--data fields--#
  field           :content
  field           :commenter, :index => true
#  field           :viewed, :type => Array, :default => []

  index( [ :created_at, Mongo::ASCENDING ] )
  #--validations--#
  validates :content,   :presence => true,
                        :length => { :within => 3..255 }
  validates :commenter, :presence => true

end

