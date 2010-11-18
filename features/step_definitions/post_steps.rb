Then /^I should see my image within "([^"]*)"$/ do |selector|
  post = Post.first
  img = post.image.post_image.url
  page.has_content?(img)
end

