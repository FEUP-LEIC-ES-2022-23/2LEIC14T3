Feature: Voting

  Scenario: User wants to upvote a review
    Given the user is logged in and viewing a review
    And the review has a current vote count of 3
    When the user selects the "Upvote" button
    Then the vote count for the review should increase to 4
    And the user should not be able to upvote the same review again
    And the user should be able to see the updated vote count displayed on the review

  Scenario: User wants to downvote a review
    Given the user is logged in and viewing a review
    And the review has a current vote count of 2
    When the user selects the "Downvote" button
    Then the vote count for the review should decrease to 1
    And the user should not be able to downvote the same review again
    And the user should be able to see the updated vote count displayed on the review

  Scenario: User wants to see the current vote count for a review
    Given the user is logged in and viewing a review
    And the review has a current vote count of 5
    When the user views the review
    Then the user should be able to see the current vote count displayed on the review
