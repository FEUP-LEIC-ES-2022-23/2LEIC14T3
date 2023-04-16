Feature: Formations
  As a user, I want to filter IT formations based on categories, so that I can compare the events' rating of the same category.

  Scenario: User wants to filter IT formations based on categories
    Given there are multiple IT formations available
    And each formation has one or more categories associated with it
    When the user navigates to the "Filter by Category" page
    And selects one or more categories to filter by
    And clicks on the "Apply" button
    Then the user should see a list of IT formations that belong to the selected categories
    And each formation should display its overall rating and the categories it belongs to

  Scenario: User wants to filter IT formations by one category
    Given there are multiple IT formations available
    And each formation has one or more categories associated with it
    When the user navigates to the "Filter by Category" page
    And selects one category to filter by
    And clicks on the "Apply" button
    Then the user should see a list of IT formations that belong to the selected category
    And each formation should display its overall rating and the category it belongs to

  Scenario: User wants to filter IT formations by multiple categories
    Given there are multiple IT formations available
    And each formation has one or more categories associated with it
    When the user navigates to the "Filter by Category" page
    And selects multiple categories to filter by
    And clicks on the "Apply" button
    Then the user should see a list of IT formations that belong to all the selected categories
    And each formation should display its overall rating and all the categories it belongs to

  Scenario: User wants to filter IT formations with no results
    Given there are multiple IT formations available
    And each formation has one or more categories associated with it
    When the user navigates to the "Filter by Category" page
    And selects a category that has no IT formations associated with it
    And clicks on the "Apply" button
    Then the user should see a message indicating that there are no IT formations in the selected category