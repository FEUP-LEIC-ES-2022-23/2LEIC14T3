Feature: Company Ratings

  As a user,
  I want to be able to rate on different aspects of a company (such as remuneration and work-life balance),
  so that I can give different rates for different categories.

  Scenario: User wants to rate different aspects of a company
    Given the user has an account on the app
    And the user is logged in
    When the user navigates to the page for rating a company
    And the user selects a company to rate
    And the user is presented with different categories to rate, such as "Remuneration" and "Work-Life Balance"
    And the user assigns a rating score to each category
    And the user fills out a review for the company
    And the user submits the rating and review
    Then the rating and review should be saved and associated with the company
    And the rating score for each category should be displayed on the company's page
    And the user should be able to edit or delete their rating and review