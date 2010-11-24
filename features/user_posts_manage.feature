Feature: Manage User's Posts
  In order to manage my posts
  As a registered user
  I want edit and delete my posts

  Background:
    Given the following user records
    | email             | password |
    | user@test.com     | secret   |
    | follower@test.com | secret   |
    And I have a post for "user@test.com"

  Scenario: show edit and delete link as owner
    Given I am signed in as "user@test.com" with password "secret"
    When I visit posts for "user@test.com"
    Then I should see "edit post" within "div.post_links a"
    And I should see "destroy post" within "a#destroy"

  # add tests for following
  Scenario: hide edit link as follower
    Given I am signed in as "follower@test.com" with password "secret"
    When I visit posts for "user@test.com"
    Then I should not see "edit post"
    And I should not see "destroy post"

  Scenario: edit page for a post
    Given I am signed in as "user@test.com" with password "secret"
    When I visit posts for "user@test.com"
    Then I should see "edit post" within "div.post_links a"
    When I follow "edit"
    Then I should be on my edit post page
    And I should see "Please use the form below to edit your post."
    And the "title" field within "div#post_title" should contain "title"
    And the "content" field within "div#post_content" should contain "content"
    #add test for images

  Scenario: editing a post
    Given I am signed in as "user@test.com" with password "secret"
    When I visit edit post by "user@test.com"
    When I fill in "title" with "New Title" within "div#post_title"
    And I fill in "content" with "New content" within "div#post_content"
    #add test for images
    And I press "Post"
    Then I should be on my post's page
    And I should see "Post successfully updated!" within "p.notice"
    And I should see "New Title" within "div#post_title"
    And I should see "New content" within "div#post_content"

