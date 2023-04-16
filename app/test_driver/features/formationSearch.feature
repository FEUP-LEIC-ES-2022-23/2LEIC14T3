Feature: Formation Search
  As a student, I want to search for specific IT formations, so that I can see the ratings of the events.

Scenario: User searches for an IT formation
  Given "Ibiscus Day" is an IT formation
  When the user types "Ibiscus Day" in the search bar and taps the search button
  Then "Ibiscus Day" should appear in the search results
  And the user should be able to click on "Ibiscus Day" to view its event page
  And the event page should display the ratings and reviews submitted by attendees