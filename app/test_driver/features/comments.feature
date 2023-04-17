Feature: Comments
  As a user, I want to be able to comment on other reviews, so that I can express more precisely if I agree or not with a review.

  Scenario: User wants to comment on a review
    Given the user is logged in and viewing a review
    When the user selects the "Comment" button
    And the user writes their comment
    And the user submits their comment
    Then the comment should be displayed underneath the review
    And the user should receive a notification if someone replies to their comment

  Scenario: User wants to reply to a comment
    Given the user is logged in and viewing a review with comments
    When the user selects the "Reply" button on a comment
    And the user writes their reply
    And the user submits their reply
    Then the reply should be displayed underneath the comment
    And the user who wrote the original comment should receive a notification of the reply

  Scenario: User wants to edit their comment
    Given the user is logged in and viewing a review with their own comment
    When the user selects the "Edit" button on their comment
    And the user updates their comment
    And the user submits their changes
    Then the comment should display the updated content

  Scenario: User wants to delete their comment
    Given the user is logged in and viewing a review with their own comment
    When the user selects the "Delete" button on their comment
    And the user confirms they want to delete the comment
    Then the comment should be removed from the review
    And the user should no longer receive notifications related to that comment