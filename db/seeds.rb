# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'
user = User.create! :first_name => 'Robert',
                    :last_name => 'Brackett',
                    :email => 'user@test.com', 
                    :email_confirmation => "user@test.com",
                    :password => 'foobar', :password_confirmation => 'foobar',
                    :stats => [{
                        :status => 4,
                        :about_me => "This a little description of me.",
                        #--birthday--#
                        "birthday(1i)" => "1982",
                        "birthday(2i)" => "03",
                        "birthday(3i)" => "12",
                        #--location--#
                        :locations => [{ :city => "Brooklyn",
                                        :state => "NY",
                                        :country => "USA",
                                        :postal_code => "11238"
                        }],
                        #--websites--#
                        :websites => [{ :name => "put a f on it",
                                        :url => "http://www.putafonit.com",
                                        :info => "cool blog about cool people"
                        }] }]
puts "New stats created for default user: " << user.full_name
