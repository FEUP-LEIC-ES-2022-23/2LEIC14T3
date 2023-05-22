Feature: Profile Privacy
  As a user, I want to make my profile private, so that I can have privacy while doing my reviews.

  Scenario: User sets their profile to private
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their profile settings
    And the user clicks on the "Privacy" tab
    And the user toggles on the "Private Profile" switch
    And the user saves the changes
    Then the user's profile should be set to private
    And other users should not be able to view the user's profile or reviews
    And the user should still be able to view their own profile and reviews while logged in
