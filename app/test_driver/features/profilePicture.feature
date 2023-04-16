Feature: Profile Picture
  As a user, I want to be able to change my profile picture on the app, so that I can keep my profile up-to-date and personalized.

  Scenario: User wants to change their profile picture
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their profile page
    And the user selects "Edit Profile"
    And the user selects "Change Profile Picture"
    And the user selects a new profile picture to upload
    And the user saves their changes
    Then the user's profile picture should be updated with the new picture
    And the user should see a confirmation message that their changes were saved successfully