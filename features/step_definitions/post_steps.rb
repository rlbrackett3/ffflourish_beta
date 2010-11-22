Given /^I am signed in as "([^"]*)" with password "([^"]*)"$/ do |email, password|
  visit new_user_session_path
  fill_in "Email", :with => email
  fill_in "Password", :with => password
  click_button "Sign in"
end

Given /^I have no posts$/ do
  Post.delete_all
end

Given /^I have posts titled (.+)$/ do |titles|
  titles.split(', ').each do |title|
    @me.posts.create!(:title => title,
                      :created_at => "19.11.2010 12:55:20")
  end
end

Given /^I have a post for "([^"]*)"$/ do |email|
  user = User.first(:conditions => { :email => email })
  user.posts.create!(:title => "title",
                     :created_at => "19.11.2010 12:55:20")
end
#---------------fragile and not working well---------------#
Given /^my post has (\d+) comments$/ do |number|
  user = User.first
  post = user.posts.first
  post.comments.create!(:content => "blah blah blah")
end

Given /^the following (.+) records$/ do |factory, table|
  table.hashes.each do |hash|
    Factory(factory, hash)
  end
end

When /^I visit posts for "([^\"]*)"$/ do |email|
  user = User.first(:conditions => { :email => email })
  visit user_posts_path(user._id.to_s)
end

When /^I visit a post by "([^"]*)"$/ do |email|
  user = User.first(:conditions => { :email => email })
  post = user.posts.first
  visit user_post_path(user, post)
end

When /^there are no comments$/ do
  post = Post.first(:conditions => { :title => "title" })
  post.comments.count.should == 0
end

When /^there are comments$/ do
  post = Post.first(:conditions => { :title => "title" })
  post.comments.count.should > 0
end


Then /^I should have (\d+) posts$/ do |posts|
  post = Post.count.to_s.should == posts
end

Then /^I should see my name within "([^"]*)"$/ do |selector|
  name = @me.full_name
  page.has_content?(name)
end

Then /^the "([^"]*)" field within "([^"]*)" should not contain anything$/ do |field, selector|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    field_value.should ||= nil
  end
end

Then /^I should see my image within "([^"]*)"$/ do |selector|
  post = Post.first
  img = post.image.post_image.url
  page.has_content?(img)
end

