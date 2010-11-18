Factory.define :user do |user|
  user.first_name             "Bair"
  user.last_name              "DeBair"
  user.sequence(:email)       { |n| "user#{n}@example.com"}
  user.email_confirmation     { |u| u.email }
  user.password               "foobar"
  user.password_confirmation  { |u| u.password }
end

#Factory.define :profile do |profile|
#  profile.association :user
#  profile.user_name           "Bair DeBair"
#  profile.about_me            "Describe yourself"
#  profile.birthday            ""
#end

#Factory.sequence :email do |n|
#  "person-#{n}@example.com"
#end

Factory.define :post do |post|
  post.association :user, :factory => :user,
                          :email => "test@user.com",
                          :email_confirmation => "test@user.com"
  post.title                  "Title"
  post.content                "Content"

  #post.comment { |p| Factory(:comment)}
end

Factory.define :comment do |c|
  c.association :user, :factory => :post
  c.content                   "This is a comment"
end

