Feature: Creating user's blog posts
  In order to have a personal blog with posts
  As a registered user
  I want to be able to create posts

  Scenario: creating a valid post
    Given I am signed in
    And I have no posts
    When I am on my posts page
    And I fill in "title" with "I am posting"
    And I press "Post"
    Then I should be on my posts page
    And I should see "Post created successfully!" within "p.notice"
    And I should see "I am posting" within "div#post_title a"
    And I should see "less than 5 seconds" within "div.created"

  Scenario: creating a valid post with content
    Given I am signed in
    And I have no posts
    When I am on my posts page
    And I fill in "title" with "I am posting"
    And I fill in "content" with "About having the best day ever!!"
    And I press "Post"
    Then I should be on my posts page
    And I should see "I am posting" within "div#post_title a"
    And I should see "About having the best day ever!!" within "p.body_text"

  Scenario: creating a valid post with an image
    Given I am signed in
    And I am on my new post page
    When I fill in "title" with "My First Pic"
    And I attach the file "public/images/rails.png" to "image"
    And I press "Post"
    Then I should be on my posts page
    And I should see "My First Pic" within "div#post_title a"
    And I should see my image within "div#post_image"

  Scenario: creating a valid post with an image and content
    Given I am signed in
    And I am on my new post page
    When I fill in "title" with "My First Pic"
    And I attach the file "public/images/rails.png" to "image"
    And I fill in "content" with "A description of my image."
    And I press "Post"
    Then I should be on my posts page
    And I should see "My First Pic" within "div#post_title a"
    And I should see my image within "div#post_image"
    And I should see "A description of my image." within "div#post_content p.body_text"

    Scenario: creating an invalid post
      Given I am signed in
      And I am on my posts page
      When I fill in "title" with "I"
      And I press "Post"
      Then I should be on my posts page
      And I should see "Title is too short (minimum is 2 characters)" within "div#error_explanation"
      And the "title" field within "div#post_title" should contain "I"
      When I fill in "title" with ""
      And I press "Post"
      Then I should be on my posts page
      And I should see "Title Your post is empty, what are you doing?" within "div#error_explanation"

