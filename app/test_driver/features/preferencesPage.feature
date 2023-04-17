Feature: Preferences Page
  As a user, I want to be able to set preferences for the language and location of the IT companies, formations, and events that I see, so that I can tailor my experience to my needs.

  Scenario: User wants to set preferences for language and location
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their account settings
    And the user selects "Preferences"
    And the user selects a language preference from the available options
    And the user selects a location preference from the available options
    And the user saves their preferences
    Then the app should display IT companies, formations, and events that match the user's language and location preferences
    And the app should not display IT companies, formations, and events that do not match the user's preferences
    And the user should receive a success message indicating that their preferences have been saved
    And the user should be able to see their updated preferences in their account settings
    And the user should be able to change their preferences at any time and have the changes take effect immediately