require 'faker'

namespace :db do
  desc "Fill database with sample users with posts"
  task :populate => :environment do
#    require 'populator'

    [User].each(&:delete_all)

    User.populate 20 do |user|
      user.first_name = Faker::Name.first_name
      user.last_name  = Faker::Name.last_name
      user.email      = Faker::Internet.email
      user.posts.populate 5 do |post|
        post.title    = Faker::Lorem.words
        post.contents = Faker::Lorem.paragraph
      end
    end
  end
end

