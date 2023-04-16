Feature: User Login

  As a user,
  I want to log in to my account,
  so that I can access my personal information and use the features of the platform.

  Scenario: User wants to log in to their account
    Given the user is on the login page
    When the user enters their correct email and password
    Then the user should be redirected to their dashboard
    And the user should be able to access their personal information
    And the user should be able to use all the features of the platform that require a login