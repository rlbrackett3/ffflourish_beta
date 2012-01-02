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
    Then I should see "follow" within "div#following a"
    And I should see "0" within "div#following_count"
    When I follow "follow" within "div#following"
    #Then I should be on "user2@test.com" following profile #privacy parameters
    Then I should see "unfollow" within "div#following a"
    And I should see "1" within "div#following_count"

  Scenario:following from a users public posts
    Given I am signed in as "user1@test.com" with password "secret"
    When I visit "user2@test.com" public posts page
    Then I should see "follow" within "div#following a"
    And I should see "0" within "div#following_count"
    When I follow "follow" within "div#following"
    #Then I should be on "user2@test.com" following profile #privacy parameters
    Then I should see "unfollow" within "div#following a"
    And I should see "1" within "div#following_count"


  Scenario:unfollowing a user
    Given I am signed in as "user1@test.com" with password "secret"
    And I am following "user2@test.com"
    When I visit "user2@test.com" public posts page
    Then I should see "unfollow" within "div#following a"
    And I should see "1" within "div#following_count"
    When I follow "unfollow" within "div#following"
    Then I should be on the home page
    And I should see "0" within "div#following_count"

  Scenario:followed by a user
    Given I am signed in as "user1@test.com" with password "secret"
    When I am on the home page
    Then I should see "0" within "div#followers_count"
    When I am followed by "user2@test.com"
    And I go to the home page
    Then I should see "1" within "div#followers_count"

  Scenario:followed by a user
    Given I am signed in as "user1@test.com" with password "secret"
    And I am followed by "user2@test.com"
    When I am on the home page
    Then I should see "1" within "div#followers_count"
    When I am unfollowed by "user2@test.com"
    And I go to the home page
    Then I should see "0" within "div#followers_count"

