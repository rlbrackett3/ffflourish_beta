Given /^I am following "([^"]*)"$/ do |email|
  user1 = User.first
  user2 = User.first(:conditions => { :email => email})
  user1.follow!(user2)
end

When /^I visit "([^"]*)" public profile$/ do |email|
  user = User.first(:conditions => { :email => email })
  profile = user.profile
  visit user_profile_path(user, profile)
end

When /^I visit "([^"]*)" public posts page$/ do |email|
  user = User.first(:conditions => { :email => email })
  visit user_posts_path(user)
end

