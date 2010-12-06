class Profile
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user, :inverse_of => :profile

  attr_protected  :_id
  accepts_nested_attributes_for :locations, :websites, :stats

  field :user_name
  field :handle
  field :status,          :type => Integer
  field :about_me
  field :birthday,        :type => Date

  mount_uploader :avatar, AvatarUploader

  index :user_name

  embeds_many     :locations
  embeds_many     :websites
  embeds_many     :stats

  after_create  :seed_stats

protected

  def seed_stats
  #--Likes--#
    self.stats << Stat.new(:title => "Interests", :content => ["cheese", "eggs", "pears"], :like => true)
    self.stats << Stat.new(:title => "Links", :content => [], :like => true)
    self.stats << Stat.new(:title => "Blogs", :content => [], :like => true)
  #--Activities--#
    self.stats << Stat.new(:title => "Activities", :content => [], :act => true)
  #--Nourishment--#
    self.stats << Stat.new(:title => "Superfood", :content => [], :eat => true)
  #--Personal--#
    self.stats << Stat.new(:title => "Research", :content => [], :personal => true)
    self.save
  end

end


class Location
  include Mongoid::Document
  include Mongoid::Timestamps
  attr_protected  :_id

  field :city
  field :state
  field :country
  field :postal_code

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

