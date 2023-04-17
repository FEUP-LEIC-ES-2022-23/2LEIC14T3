Feature: Notifications
  As a user, I want to be able to set preferences for the format of the notifications I receive, so that I can choose whether to receive emails, push notifications, or other types of alerts.

  Scenario: User sets notification preferences
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their account settings
    And the user selects "Notification Preferences"
    And the user selects their preferred notification format
    And the user saves their preferences
    Then the app should update the user's notification settings with the preferred format
    And the user should receive notifications in the preferred format going forward
    And the user should be able to change their notification preferences at any time and have the changes take effect immediately

  Scenario: User changes notification preferences
    Given the user has an account on the app
    And the user is logged in
    And the user has already set notification preferences
    When the user navigates to their account settings
    And the user selects "Notification Preferences"
    And the user selects a different preferred notification format
    And the user saves their preferences
    Then the app should update the user's notification settings with the new preferred format
    And the user should receive notifications in the new preferred format going forward
    And the user should be able to change their notification preferences again at any time and have the changes take effect immediately