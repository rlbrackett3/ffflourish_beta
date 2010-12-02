Factory.define :user do |user|
  user.first_name             "Bair"
  user.last_name              "DeBair"
  user.email                  "user@example.com"
  user.email_confirmation     { |u| u.email }
  user.password               "foobar"
  user.password_confirmation  { |u| u.password }
end

Factory.sequence :email do |n|
  "user#{n}@example.com"
end

Factory.define :post do |post|
  post.association :user#, :factory => :user
  post.title                  "Title"
  post.content                "Content"
  post.image_filename         "rails.png"
  post.comments { |p| Factory(:comment)}
end

Factory.define :comment do |c|
  c.association :user, :factory => :user
  c.content                   { |n| "This is #{n} comment" }
end

