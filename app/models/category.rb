class Category
  include Mongoid::Document
  include Mongoid::Timestamps

  attr_protected  :_id
  accepts_nested_attributes_for :values

  field       :title

  embeds_many :values

  embedded_in :stat,  :inverse_of => :categories
end

