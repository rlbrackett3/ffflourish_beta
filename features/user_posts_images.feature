Feature: Users can post with images
  In order to post images to my feed
  As a registered ffflourish user
  I want to attach an image to my post


Scenario: User creates a new post
    Given I am signed in
    And I am on my new post page
    When I fill in "Title" with "My First Pic"
    And I attach the file "public/images/rails.png" to "Image"
    And I fill in "Content" with "A description of my image."
    And I press "Create Post"
    Then I should be on my post's page
    And I should see "My First Pic" within "div#post_title"
    And I should see my image within "div#post_image"
    And I should see "A description of my image." within "div#post_content"

