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

  #--data fields--#
  field           :title
  field           :content

  #--embedded documents--#
  references_many :comments#, :stored_as => :array, :inverse_of => :posts
#  embeds_many     :likes
#  embeds_many     :

end

