Feature: View Reviews
  As a user, I want to be able to see users’ reviews on a company, so that I better understand the rating of some company

  Scenario: User wants to see reviews on a company
    Given there is a company with ratings and reviews available
    When the user navigates to the company page
    Then the user should see the overall rating of the company
    And the user should see a list of reviews for the company, sorted by recency or upvotes
    And each review should display the user's name, rating, and review text

  Scenario: User wants to see overall rating of a company
    Given there is a company with ratings and reviews available
    When the user navigates to the company page
    Then the user should see the overall rating of the company displayed prominently

  Scenario: User wants to sort reviews by recency
    Given there is a company with ratings and reviews available
    When the user navigates to the company page
    And the user selects the "Sort by Recency" option
    Then the user should see the reviews sorted by recency, with the most recent reviews appearing first

  Scenario: User wants to sort reviews by upvotes
    Given there is a company with ratings and reviews available
    When the user navigates to the company page
    And the user selects the "Sort by Upvotes" option
    Then the user should see the reviews sorted by upvotes, with the reviews with the highest number of upvotes appearing first