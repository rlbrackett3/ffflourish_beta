Given /^I am following "([^"]*)"$/ do |email|
  user1 = User.first
  user2 = User.first(:conditions => { :email => email})
  user1.follow!(user2)
end

When /^I am followed by "([^"]*)"$/ do |email|
  user1 = User.first
  user2 = User.first(:conditions => { :email => email})
  user2.follow!(user1)
end

When /^I am unfollowed by "([^"]*)"$/ do |email|
  user1 = User.first
  user2 = User.first(:conditions => { :email => email})
  user2.unfollow!(user1)
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

