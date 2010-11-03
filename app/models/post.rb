class Post
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
#  referenced_in   :feed
  embedded_in     :user, :inverse_of => :posts

  #--boolean values for controlling visability of posts--#
  field           :public,      :type => Boolean
  field           :semi_public, :type => Boolean
  field           :private,     :type => Boolean

  #--date fields--#
  field           :title
  field           :content

  #--embedded documents--#
#  embeds_many     :comments
#  embeds_many     :likes
#  embeds_many     :

end

