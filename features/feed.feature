Feature: User feed
  In order to view the posts of people I am following
  As a registered user
  I want to have a feed of followed users posts

  Background:
    Given the following user records
    | email          | password | first_name | last_name |
    | user1@test.com | secret   | Robert     | Brackett  |
    | user2@test.com | secret   | Laura      | Coombs    |

  Scenario:I should be directed to my feed when I sign in
    Given I have no posts
    When I am signed in as "user1@test.com" with password "secret"
    Then I should be on the home page
    And I should see "Robert Brackett" within "div#user_name"
    And I should see "+ following" within "div#page_title"
    And I should see "What are you doing right now that's healthy for you?"

  Scenario:I should see my posts
    Given I have a post for "user1@test.com"
    When I am signed in as "user1@test.com" with password "secret"
    Then I should be on the home page
#    And I should see "img#avatar_small" within "div#user_photo_small"
    And I should see "Robert Brackett" within "a#post_author"
    And I should see "title"
    And I should see "content"

  Scenario:I should see followed user's posts
    Given I have a post for "user2@test.com"
    And "user1@test.com" is following "user2@test.com"
    When I am signed in as "user1@test.com" with password "secret"
    Then I should be on the home page
    And I should see "Laura Coombs" within "a#post_author"
    And I should see "title"
    And I should see "content"

