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

  index( [ :created_at, Mongo::DESCENDING ] )
  #--validations--#
  validates :content,   :presence => true,
                        :length => { :within => 3..201 }
  validates :commenter, :presence => true
  
  scope :recent_user_comments, lambda { |user| where(:user_id.in => user.id).and(:created_at.gt => 1.week.ago) }

end

