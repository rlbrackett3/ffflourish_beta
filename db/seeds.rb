# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
require 'faker'
require File.expand_path("config/randomtime.rb")
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name == 'system.indexes'}.each(&:drop)
#puts 'SETTING UP FBOT MESSENGER'
#fbot = User.create  :first_name => 'fbot',
#                    :last_name => 'messenger',
#                    :email => 'fbot@ffflourish.com',
#                    :email_confirmation => "fbot@ffflourish.com",
#                    :password => 'foobar', :password_confirmation => 'foobar'

#p1 = Post.create    :title => "Hello!",
#                    :content => "Welcome to ffflourish.",
#                    :created_at => Time.now,
#                    :updated_at => Time.now
#fbot.posts << p1
#fbot.save
#puts "New account created for: " << fbot.first_name
puts 'SETTING UP FIRST USER'
user = User.create  :first_name => 'Robert',
                    :last_name => 'Brackett',
                    :email => 'user@test.com',
                    :email_confirmation => "user@test.com",
                    :password => 'foobar', :password_confirmation => 'foobar'

p1 = Post.create    :title => Faker::Lorem.sentence,
                    :content => Faker::Lorem.paragraph,
                    :created_at => Time.random,
                    :updated_at => Time.random
user.posts << p1
user.save
puts "New account created for first user: " << user.full_name

puts 'CREATING A BUNCH OF PEOPLE'
20.times do
  u = User.create :first_name => Faker::Name.first_name,
                  :last_name  => Faker::Name.last_name,
                  :email      => Faker::Internet.email,
                  :password => 'foobar', :password_confirmation => 'foobar'
  5.times do
    p = Post.create :title      => Faker::Lorem.sentence,
                    :content    => Faker::Lorem.paragraph,
                    :created_at => Time.random,
                    :updated_at => Time.random
    u.posts << p
  end
  u.save
  user.follow!(u)
  u.follow!(user)
end
puts "lots of new test users created!!!!"

