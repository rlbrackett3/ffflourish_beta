Given /^I am signed in as "([^"]*)" with password "([^"]*)"$/ do |email, password|
  visit new_user_session_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

Given /^I am signed in as the following (\w+):$/ do |role, table|
  Given %(the following #{role}:), table
  @me = @it
  Given 'I am signed in'
end

Given /^I (?:am signed|sign) in as an? (\w+)$/ do |role|
  @me = Factory(role.to_sym)
  Given 'I am signed in'
end


Given 'I am signed in' do
  @me ||= Factory(:user)
  When %(I go to the new user session page)
  When %(I fill in "Email" with "#{@me.email}")
  When %(I fill in "Password" with "#{@me.password}")
  When %(I press "Sign in")
end


When /^I sign in as "([^"]*)"$/ do |email|
  @me = User.find_by_email(email)
  @me.password ||= 'password'
  Given 'I am signed in'
end

