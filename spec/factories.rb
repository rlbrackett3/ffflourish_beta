# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.first_name             "Robert"
  user.last_name              "Brackett"
  user.full_name              "Robert Brackett"
  user.email                  "rlb@example.com"
  user.email_confirmation     "rlb@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :stat do |stat|
  stat.association :user
  stat.first_name          "Robert"
  stat.last_name           "Brackett"
  stat.about_me            "I am a cofounder of ffflourish.com.  Welcome to the community"
  stat.birthday            "July 19, 1984"
  stat.location            "Brooklyn, NY USA"
  stat.websites            "www.putafonit.com"
end
