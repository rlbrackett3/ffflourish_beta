# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)
#require 'faker'
require 'ffaker'
require 'factory_girl'
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
user = User.create  :urlname => 'rlblood',
                    :name => 'Robert Brackett',
                    :email => 'user@test.com',
                    :email_confirmation => "user@test.com",
                    :password => 'foobar', :password_confirmation => 'foobar'
5.times do
  p1 = user.posts.create  :content => Faker::Lorem.sentence,
                          :created_at => Time.random(2),
                          :updated_at => Time.random(1)
  user.profile.increment_posts_count
  p1.save!
end
user.save!
puts "New account created for first user: " << user.name

puts 'CREATING A BUNCH OF PEOPLE'
20.times do
  u = User.create :urlname  => (Faker::Name.first_name + Faker::Name.last_name),
                  :name     => Faker::Name.name,
                  :email    => Faker::Internet.email,
                  :password => 'foobar', :password_confirmation => 'foobar'
  5.times do
    p = u.posts.create! :content    => Faker::Lorem.sentence,
                        :created_at => Time.random(2),
                        :updated_at => Time.random(1)
    u.profile.increment_posts_count
    p.save!
  end
  u.save!
  puts u.to_param
  user.follow!(u)
  user.profile.increment_following_count
  user.posts.each do |p|
    p.vote 1, u
  end
  u.profile.increment_follower_count
  u.follow!(user)
  u.profile.increment_following_count
  user.profile.increment_follower_count
end
puts "lots of new test users created!!!!"

