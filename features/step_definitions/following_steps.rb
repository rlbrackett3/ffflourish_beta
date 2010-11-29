When /^I visit "([^"]*)" public profile$/ do |email|
  user = User.first(:conditions => { :email => email })
  profile = user.profile
  visit user_profile_path(user, profile)
end

