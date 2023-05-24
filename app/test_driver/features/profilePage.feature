Feature: Profile Page
  Scenario: User wants to access his profile page
    Given I see "emailfield"
    And I see "passfield"
    And I see "LoginButton"
    When I fill the "emailfield" field with "a@g.com"
    And I fill the "passfield" field with "esof2223"
    And I tap the "LoginButton" button
    And I wait 5 seconds
    And I see "MyHomePage"
    And I see "profileButton"
    And I tap the "profileButton" button
    And I wait 5 seconds
    Then I see "ProfilePage"

