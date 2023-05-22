Feature: User Review
  As a user, I want to be able to view other users' review profile, so that I can see what like-minded individuals think about other topics.

  Scenario: User wants to view another user's review profile
    Given there are multiple users with reviews available
    And the user is logged in to their account
    When the user navigates to another user's profile page
    Then the user should see the other user's profile picture and bio
    And the user should see a list of reviews the other user has submitted, sorted by recency
    And each review should display the event name, rating, and review text
    And the user should have the option to filter the reviews by category or rating
    And the user should not be able to edit or delete the other user's reviews.
