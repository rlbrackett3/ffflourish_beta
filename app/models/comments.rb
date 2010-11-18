class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  #--Associations--#
  referenced_in   :user
  referenced_in   :post

  #--data fields--#
  field          :content
  
  validates :content, :presence => true

end

