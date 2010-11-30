Feature: Comments on Posts
  In order to share my support for other user's posts
  As a registered user
  I want to be able to add comments to user's posts

  Background:
    Given the following user records
    | email          | password | first_name | last_name |
    | user1@test.com | secret   | Robert     | Brackett  |
    | user2@test.com | secret   | Laura      | Coombs    |
    And I have a post for "user1@test.com"
    And I have a post for "user2@test.com"

  Scenario: being first to comment on a user's post
    Given I am signed in as "user1@test.com" with password "secret"
    When I visit a post by "user2@test.com"
    And there are 0 comments
    Then I should see "comments(0)" within "div#comment_count"
    When I fill in "content" with "Wow, that's an awesome post!"
    And I press "Comment"
    Then I should be on user2@test.com's post's show page
    And I should see "Comment created successfully!" within "p.notice"
    And I should see "comment(1)" within "div#comment_count"
    And I should see "Robert Brackett" within "div#commenter a"
    And I should see "Wow, that's an awesome post!" within "div#comment_content"
    And I should see " @ " within "div.created"

  Scenario: managing comments on my posts #very fragile test
    Given I am signed in as "user1@test.com" with password "secret"
    When I am on my post's page
    And there are 3 comments
    Then show me the page
    Then I should see "destroy comment" within "div#destroy_comment a"
    When I follow "destroy comment" within "div#destroy_comment a#destroy"
    Then I should be on my post's page
    And there are 2 comments
