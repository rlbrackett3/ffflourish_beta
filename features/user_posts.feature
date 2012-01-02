Feature: User's Blog
  In order to have a personal blog
  As a registered user
  I want to have posts

  Scenario: I have no posts
    Given I am signed in
    And I have no posts
    When I am on my posts page
    Then I should see my name within "div#user_name"
    And I should see "You have no posts yet!" within "div#get_posting"
    And I should see "Answer the question above to get started" within "div#get_posting"
    And I should see "What are you doing right now that's healthy for you?" within "div#question"
    And the "title" field within "div#post_title" should not contain anything
    And the "content" field within "div#post_content" should not contain anything
    And the "image" field within "div#post_image" should not contain anything

  Scenario: listing all my posts
    Given I am signed in
    And I have posts titled First, Second, Third
    When I am on my posts page
    Then I should see "What are you doing right now that's healthy for you?" within "div#question"
    And I should see "First"
    And I should see "Second"
    And I should see "Third"

  Scenario: Adding a post
    Given I am signed in
    And the following post records
    | title  | content        | image_filename | user_id |
    | First  | My first post  | rails.png      | 4cf51d81814e14122900000d |
    | Second | My second post | rails.png      | 4cf51d81814e14122900000d |
    Then I should have 2 posts
    When I am on my posts page
    And I fill in the following:
    | title          | Third         |
    | content        | My third post |
    And I press "Post"
    Then I should have 3 posts

