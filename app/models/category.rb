class Category
  include Mongoid::Document

  attr_protected  :_id

  field       :cat

  embedded_in :stat,  :inverse_of => :category
end

