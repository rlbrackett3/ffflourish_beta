class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  referenced_in   :user

  attr_protected  :_id
  accepts_nested_attributes_for :locations, :websites, :stats

  field :user_name
  field :status,          :type => Integer
  field :about_me
  field :birthday,        :type => Date

  embeds_many     :locations
  embeds_many     :websites
  embeds_many     :stats

end


class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_protected  :_id

  field :city,        :default => ""
  field :state,       :default => ""
  field :country,     :default => ""
  field :postal_code, :default => ""

  embedded_in :profile,  :inverse_of => :locations

#  def locale
#    if not postal_code.blank? and (city.blank? or state.blank?)
#      lookup = GeoDatum.find_by_zip_code(postal_code)
#      if lookup
#        self.city  = lookup.city.capitalize_each if city.blank?
#        self.state = lookup.state if state.blank?
#      end
#    end
#    [city, state, postal_code].join(" ")
#  end

end

class Website
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_protected  :_id

  field :name
  field :url
  field :info

  embedded_in :profile,  :inverse_of => :websites

end

