Feature: Following the posts of other users
  In order to see what other members of fflourish are posting
  As a registered user
  I want to follow other users

  Background:
    Given the following user records
    | email          | password | first_name | last_name |
    | user1@test.com | secret   | Robert     | Brackett  |
    | user2@test.com | secret   | Laura      | Coombs    |
    And I have a post for "user1@test.com"
    And I have a post for "user2@test.com"

  Scenario:following from a users public profile
    Given I am signed in as "user1@test.com" with password "secret"
    When I visit "user2@test.com" public profile
    Then I should see "follow" within "div#follow_me a"
    And I should see "discover more about Laura" within "div#follow_me"
    When I click "follow"
    Then I should be on "user2@test.com" following profile
    And I should see "You are following Laura." within "div#following"

  Scenario:following from a users public posts


  Scenario:unfollowing a user

