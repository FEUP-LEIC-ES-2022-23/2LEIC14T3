Feature: Rating
  As a user, I want to be able to rate a certain event by assigning a rating from 0 to 5 stars.

  Scenario: User wants to rate an event
    Given there is an event available for rating
    When the user navigates to the event page
    And the user clicks on the "Rate Event" button
    And the user assigns a rating from 0 to 5 stars to the event
    And the user clicks on the "Submit" button
    Then the rating should be saved successfully
    And the user should see the assigned rating displayed on the event page
