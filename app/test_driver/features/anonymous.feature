Feature: Anonymous

  As a user,
  I want to be able to make an anonymous review,
  so that I feel safer when making negative reviews.

  Scenario: User wants to make an anonymous review
    Given there is an event available for review
    When the user rates the event
    And he presses 'Anonymous Review'
    Then the rating should be saved successfully
    And the user should be able to see the rating without any profile associated