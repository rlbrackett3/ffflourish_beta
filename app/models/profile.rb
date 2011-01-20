class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user, :inverse_of => :profile

  attr_accessible  :name, :handle, :status, :about_me, :birthday, :avatar, :locations, :websites
  accepts_nested_attributes_for :locations, :websites

  field :name
  field :handle
  field :status,          :type => Integer
  field :about_me
  field :birthday,        :type => Date

  mount_uploader :avatar, AvatarUploader

  index :name

  embeds_many     :locations
  embeds_many     :websites

  validates :name,        :presence => true,
                          :length => 2..25
  validates :handle,      :length => { :maximum => 240,
                                       :message => " is too long." },
                          :allow_blank => true

end


class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_accessible :city, :state, :country, :postal_code

  field :city
  field :state
  field :country
  field :postal_code

  embedded_in :profile,  :inverse_of => :locations

#  def locale
#    if ! postal_code.blank? and (city.blank? or state.blank?)
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
  attr_accessible :name, :url, :info

  field :name
  field :url
  field :info

  embedded_in :profile,  :inverse_of => :websites

end

