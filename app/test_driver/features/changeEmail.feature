Feature: Change Email
  Scenario: User wants to change his email
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
    And I see "changeNickname"
    And I tap the "changeEmail" button
    And I see "emailChanger"
    And I fill the "emailChanger" field with "teste-sucedido@gmail.com"
    And I tap the "submitEmail" button
    And I wait 5 seconds
    And I tap the back button
    And I wait 3 seconds
    Then I expect the text "teste-sucedido@gmail.com" to be present
    And I tap the "settings" button
    And I tap the "changeEmail" button
    And I see "emailChanger"
    And I fill the "emailChanger" field with "a@g.com"
    And I tap the "submitEmail" button

