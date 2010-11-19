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
