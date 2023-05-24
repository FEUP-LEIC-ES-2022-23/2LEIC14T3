Feature: Credits Page
  Scenario: User wants to log in to their account
    Given I see "emailfield"
    And I see "passfield"
    And I see "LoginButton"
    When I fill the "emailfield" field with "a@g.com"
    And I fill the "passfield" field with "esof2223"
    And I tap the "LoginButton" button
    And I wait 5 seconds
    And I see "MyHomePage"
    And I open the drawer
    And I see "creditsButton"
    And I tap the "creditsButton" button
    And I wait 5 seconds
    Then I see "CreditsPage"
