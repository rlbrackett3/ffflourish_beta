class Stat
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  accepts_nested_attributes_for :category

  field         :title
  field         :content,   :type => Array
  field         :like,      :type => Boolean,   :default => false
  field         :act,       :type => Boolean,   :default => false
  field         :eat,       :type => Boolean,   :default => false
  field         :personal,  :type => Boolean,   :default => false

  embeds_one    :category

  embedded_in   :profile,  :inverse_of => :stats

#--list the last three items (most recent) in the array in reverse order--#
  def content_list
    list = self.content.reverse
    list.first(3).join(", ")
  end

#  self.fields.collect { |field| field[0] }

end
