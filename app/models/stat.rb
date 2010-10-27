class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  accepts_nested_attributes_for :categories, :likes, :activities, :eats, :interests

  field         :title

  embeds_one    :category

  embedded_in   :profile,  :inverse_of => :stats

#  self.fields.collect { |field| field[0] }

end

class Like
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id

  field         :title
  fields        :content, :type => Array

  embedded_in   :stat, :inverse_of => :likes

end

