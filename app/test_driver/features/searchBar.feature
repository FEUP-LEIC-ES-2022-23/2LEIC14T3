Feature: Search Bar
  Scenario: User wants to search for Deloitte
    Given I see "emailfield"
    And I see "passfield"
    And I see "LoginButton"
    When I fill the "emailfield" field with "a@g.com"
    And I fill the "passfield" field with "esof2223"
    And I tap the "LoginButton" button
    And I wait 5 seconds
    And I see "MyHomePage"
    And I see "searchBar"
    And I tap the "searchBar" button
    And I fill the "searchBar" field with "Deloitte"
    And I tap the "searchButton" button
    And I wait 3 seconds
    Then I expect the text "Deloitte Portugal" to be present