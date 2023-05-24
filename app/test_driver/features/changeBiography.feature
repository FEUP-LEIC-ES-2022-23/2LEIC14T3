Feature: Change Biography
  Scenario: User wants to change his profile bio
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
    And I see "settings"
    And I tap the "settings" button
    And I see "changeBio"
    And I tap the "changeBio" button
    And I see "bioChanger"
    And I fill the "bioChanger" field with "Gherkin Test well succeed!"
    And I tap the "submitBio" button
    And I wait 5 seconds
    And I tap the back button
    And I wait 3 seconds
    Then I expect the text "Gherkin Test well succeed!" to be present
    And I tap the "settings" button
    And I tap the "changeBio" button
    And I see "bioChanger"
    And I fill the "bioChanger" field with "Hello World!"
    And I tap the "submitBio" button

