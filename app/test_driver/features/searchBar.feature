Feature: Formation Search
  As a student, I want to search for specific IT formations, companies and events so that I can see the ratings of the events.

  Scenario: User searches for an IT formation
    Given "Ibiscus Day" is an IT formation
    When the user types "Ibiscus Day" in the search bar and taps the search button
    Then "Ibiscus Day" should appear in the search results
    And the user should be able to click on "Ibiscus Day" to view its event page
    And the event page should display the ratings and reviews submitted by attendees

  Scenario: User searches for a company
    Given "Worten" is a company
    When the user types "Worten" in the search bar and taps the search button
    Then "Worten" should appear in the search results
    And the user should be able to click on "Worten" to view its event page
    And the event page should display the ratings and reviews submitted by attendees

  Scenario: User searches for an event
    Given "Tech days" is an event
    When the user types "Tech days" in the search bar and taps the search button
    Then "Tech days" should appear in the search results
    And the user should be able to click on "Tech days" to view its event page
    And the event page should display the ratings and reviews submitted by attendees