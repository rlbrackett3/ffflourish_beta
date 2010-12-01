Feature: User feed
  In order to view the posts of people I am following
  As a registered user
  I want to have a feed of followed users posts

  Background:
    Given the following user records
    | email          | password | first_name | last_name |
    | user1@test.com | secret   | Robert     | Brackett  |
    | user2@test.com | secret   | Laura      | Coombs    |
#    And I have a post for "user1@test.com"
#    And I have a post for "user2@test.com"

  Scenario:I should be directed to my feed when I sign in
    Given I have no posts
    When I am signed in as "user1@test.com" with password "secret"
    Then I should be on the home page
    And I should see "Robert Brackett" within "div#user_name"
    And I should see "+ following" within "div#user_name_page"
    And I should see "Hello Robert! Welcome to ffflourish" within "div#feed_entry_03_title"
    And I should see an avatar within "div#user_photo_small"

