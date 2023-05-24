Feature: Change Nickname
  Scenario: User wants to change his nickname
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
    And I tap the "changeNickname" button
    And I see "nicknameChanger"
    And I fill the "nicknameChanger" field with "teste-sucedido"
    And I tap the "submitNickname" button
    And I wait 5 seconds
    And I tap the back button
    And I wait 3 seconds
    Then I expect the text "@teste-sucedido" to be present
    And I tap the "settings" button
    And I tap the "changeNickname" button
    And I see "nicknameChanger"
    And I fill the "nicknameChanger" field with "user-a"
    And I tap the "submitNickname" button


