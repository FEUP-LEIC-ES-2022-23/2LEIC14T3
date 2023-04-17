Feature: Event Page
  As an event organizer, I want to be able to create an event page on your app where attendees can rate their experience, so that I can get feedback and improve future events

  Scenario: Event organizer wants to create an event page
    Given the event organizer has an account on the app
    And the event organizer is logged in
    When the event organizer navigates to the "Create Event" page
    And the event organizer fills out the necessary fields such as event title, description, date, and location
    And the event organizer saves the changes
    Then a new event page should be created for the event
    And the event organizer should be redirected to the event page
    And the event page should include a "Rate Event" button for attendees to give feedback on their experience
    And the event organizer should be able to view the ratings and reviews submitted by attendees on the event page

