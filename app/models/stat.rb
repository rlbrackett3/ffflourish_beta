class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  accepts_nested_attributes_for :categories
  
  embeds_many   :categories

  embedded_in :profile,  :inverse_of => :stats

#  self.fields.collect { |field| field[0] }

end


