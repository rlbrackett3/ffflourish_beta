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
user = User.create! :first_name => 'Firstname',
                    :last_name => 'Lastname',
                    :email => 'user@test.com',
                    :password => 'foobar', :password_confirmation => 'foobar'
puts 'New user created: ' << user.first_name
