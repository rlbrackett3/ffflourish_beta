class Feed
  include Mongoid::Document

  references_many :posts

end

