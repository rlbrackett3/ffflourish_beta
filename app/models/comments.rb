class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  referenced_in   :user
  referenced_in   :post

  #--data fileds--#
  field          :content

end

