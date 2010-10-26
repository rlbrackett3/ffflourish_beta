class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  accepts_nested_attributes_for :categories, :likes, :activities, :eats, :interests
  
  field         :title
  
  embeds_many   :categories
  embeds_many   :likes
  embeds_many   :activities
  embeds_many   :eats
  embeds_many   :personals

  embedded_in   :profile,  :inverse_of => :stats

#  self.fields.collect { |field| field[0] }

end

class Like
  include Mongoid::Document
  include Mongoid::Timestamps
  
  attr_protected  :_id
  
  field         :interests,   :default => ""
  field         :links,       :default => ""
  field         :blogs,       :default => ""
  field         :people,      :default => ""
  field         :books,       :default => ""
  field         :movies,      :default => ""
  field         :music,       :default => ""
  field         :quotes,      :default => ""
  
  embedded_in   :stat, :inverse_of => :likes
  
end
