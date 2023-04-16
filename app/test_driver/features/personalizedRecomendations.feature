Feature: Personalized Recommendations
  As a user, I want to be recommended in a feed IT companies, formations, and events that are tailored to my interests and needs, so that I can make the best possible decision regarding all the information provided.

  Scenario: User wants personalized recommendations
    Given the user has an account on the app
    And the user has specified their interests and needs in their profile settings
    When the user navigates to the app's home page
    Then the user should see a feed of IT companies, formations, and events
    And the feed should only include items that match the user's specified interests and needs
    And the items should be sorted by relevance to the user's preferences
    And the user should have the option to further customize their interests and needs in the profile settings.

  Scenario: User wants to customize their interests and needs
    Given the user has an account on the app
    When the user navigates to their profile settings
    And the user clicks on the "Interests" or "Needs" tab
    And the user selects one or more options from the available categories
    And the user saves the changes
    Then the user's interests and needs should be updated
    And the user should see personalized recommendations on the app's home page that match their updated preferences.