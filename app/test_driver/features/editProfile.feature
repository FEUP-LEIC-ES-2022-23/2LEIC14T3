Feature: Edit Profile

  As a user,
  I want to have access to my profile in order to change my nickname.

  Scenario: User wants to change their nickname
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their account settings
    And the user selects "Profile"
    And the user selects "Edit Profile"
    And the user changes their nickname
    And the user saves their changes
    Then the user's profile should display their new nickname

  Scenario: User wants to change their email
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their account settings
    And the user selects "Profile"
    And the user selects "Edit Profile"
    And the user changes their email
    And the user saves their changes
    Then the user's profile should display their new email

  Scenario: User wants to change their password
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to their account settings
    And the user selects "Profile"
    And the user selects "Edit Profile"
    And the user changes their password
    And the user saves their changes
    Then the user's password should change