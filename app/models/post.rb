class Post
  include Mongoid::Document
  include Mongoid::Timestamps
#  include Mongoid::Voteable

  attr_protected  :_id
#  referenced_in   :feed
  embedded_in     :user, :inverse_of => :posts
  #--embedded documents--#
  #--relational references--#
  references_many :comments
#  references_many :votes

  #--boolean values for controlling visability of posts--#
  field           :public,      :type => Boolean
  field           :semi_public, :type => Boolean
  field           :private,     :type => Boolean

  #--data fields--#
  field           :title
  field           :content

  #--Voting, Liking--#
  field :votes, :type => Integer, :default => 0
  field :voters, :type => Array, :default => []

  #--Vote methods--#
  def vote(num, voter)
    unless voted? voter
      self.votes += num.to_i
      self.voters << voter._id
      self.save
#      collection.update(  { "_id" => _id, "voters" => { "$ne" => voter._id } },
#                          { "$inc" => { "votes" => num.to_i },
#                            "$push" => { "voters" => voter._id }
#                            } )
    end
  end

  def voted?(voter)
    voters.include? voter._id
  end

  def vote_count
    voters.count
  end

  def vote_average
    if voters.blank?
      nil
    else
      votes.to_f / voters.count
    end
  end

end

