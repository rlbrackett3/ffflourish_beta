# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'faker'
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
puts 'SETTING UP FIRST USER'
user = User.create! :first_name => 'Robert',
                    :last_name => 'Brackett',
                    :email => 'user@test.com',
                    :email_confirmation => "user@test.com",
                    :password => 'foobar', :password_confirmation => 'foobar',
                    :posts => [ {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                },
                                {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                }
                              ]
puts "New account created for first user: " << user.full_name

puts 'SETTING UP SECOND USER'
user2 = User.create!:first_name => Faker::Name.first_name,
                    :last_name => Faker::Name.last_name,
                    :email => Faker::Internet.email,
                    :password => 'foobar', :password_confirmation => 'foobar',
                    :posts => [ {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                },
                                {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                }
                              ]
puts "New account created for second user: " << user2.full_name

puts 'SETTING UP SECOND USER'
user3 = User.create!:first_name => Faker::Name.first_name,
                    :last_name => Faker::Name.last_name,
                    :email => Faker::Internet.email,
                    :password => 'foobar', :password_confirmation => 'foobar',
                    :posts => [ {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                },
                                {
                                  :title => Faker::Lorem.sentence,
                                  :content => Faker::Lorem.paragraph,
                                  :created_at => Time.now,
                                  :updated_at => Time.now
                                }
                              ]
puts "New account created for second user: " << user3.full_name

#puts 'SETTING UP USERS'
#User.create! 20.times do |user|
#                    user.first_name => Faker::Name.first_name,
#                    user.last_name => Faker::Name.last_name,
#                    user.email => Faker::Internet.email,
#                    user.password => 'foobar',
#                    user.password_confirmation => 'foobar',
#                    user.posts => [ {
#                                      :title => Faker::Lorem.sentence,
#                                      :content => Faker::Lorem.paragraph
#                                    },
#                                    {
#                                      :title => Faker::Lorem.sentence,
#                                      :content => Faker::Lorem.paragraph
#                                    }
#                                  ]
#  puts "New account created for first user: " << user.full_name
#end

