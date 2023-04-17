Feature: Job Search
As a software developer, I want to be able to search for IT jobs in my area and see reviews from other developers who have worked at those companies before, so that I can make an informed decision about where to apply.

Scenario: Software developer searches for IT jobs and reviews
Given the software developer has an account on the app
And the software developer is logged in
When the software developer navigates to the "Jobs" page
And the software developer enters their location in the search bar
And the software developer clicks on the "Search" button
Then the software developer should see a list of IT jobs in their area
And each job listing should display a rating score and the number of reviews submitted by other developers who have worked at the company
And the software developer should be able to click on a job listing to view more details about the job and the reviews submitted by other developers

Scenario: Software developer views job details and reviews
Given the software developer has searched for IT jobs in their area
And the software developer has clicked on a job listing to view more details
When the software developer clicks on the "View Reviews" button
Then the software developer should see a list of reviews submitted by other developers who have worked at the company
And each review should display the reviewer's name, rating, and review text
And the software developer should be able to submit their own review if they have worked at the company before
And the software developer should be able to navigate back to the job listing page to continue their search.