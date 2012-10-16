Feature: Merge Articles
  As a blog administrator
  In order to prevent duplicate articles
  I want to be able to merge articles

  Background:
    Given the blog is set up
    
  Scenario: Non-admin not allowed to merge
    Given I am logged into a non-admin with id 2
    Given an article called "Foobar" and body "Lorem Ipsum"
    And an article called "Foobar 2 Electric Foobar" and body "Lorem Ipsumier"
    When I go to the home page
    Then I should see "Foobar"
    When I follow "Foobar"
    Then I should not see "Merge Articles"
    
    
  Scenario: Merge contains text and comments of both articles
    Given I am logged into the admin panel
    Given an article called "Foobar" and body "Lorem Ipsum"
    And an article called "Foobar 2 Electric Foobar" and body "Lorem Ipsumier"
    
    When I go to the home page
    Then I should see "Foobar"
    When I follow "Foobar"
    Then I fill in "comment_author" with "Stephen Li"
    Then I fill in "comment_email" with "s.li@berkeley.edu"
    Then I fill in "comment_url" with "http://www.google.com"
    Then I fill in "comment_body" with "lalala i am the test"
    Then I press "comment"
    Then I fill in "comment_author" with "Stephen Li"
    Then I fill in "comment_email" with "s.li@berkeley.edu"
    Then I fill in "comment_url" with "http://www.google.com"
    Then I fill in "comment_body" with "lalala i am the OTHER test"
    Then I press "comment"
    
    When I go to the home page
    Then I should see "Foobar 2 Electric Foobar"
    When I follow "Foobar 2 Electric Foobar"
    Then I fill in "comment_author" with "Stephen Li"
    Then I fill in "comment_email" with "s.li@berkeley.edu"
    Then I fill in "comment_url" with "http://www.google.com"
    Then I fill in "comment_body" with "hohoho merry christmas"
    Then I press "comment"
    
    When I go to the admin content page
    Then I should see "Foobar"
    And I should see "Foobar 2 Electric Foobar"
    
    When I follow "Foobar"
    Then I should see "Merge Articles"
    
    When I merge "Foobar" and "Foobar 2 Electric Foobar"
    Then I should be on the admin content page
    Then I should see "Articles were merged."
    
    When I go to the home page
    Then I should see "Foobar"
    And I should not see "Foobar 2 Electric Foobar"
    And I should see "Lorem Ipsum"
    And I should see "Lorem Ipsumier"
    
    When I follow "Foobar"
    Then I should see "lalala i am the test"
    And I should see "lalala i am the OTHER test"
    And I should see "hohoho merry christmas"
