Feature: Merge Articles
  As a blog administrator
  In order to prevent duplicate articles
  I want to be able to merge articles

  Background:
    Given the blog is set up
    And I am logged into the admin panel

  Scenario: Merge articles
    Given I am on the new article page
    When I fill in "article_title" with "Foobar"
    And I fill in "article__body_and_extended_editor" with "Lorem Ipsum"
    And I press "Publish"
    Then I should be on the admin content page
    Then I should see "Foobar"
    
    Then I go to the home page
    When I go to the new article page
    When I fill in "article_title" with "Foobar 2 Electric Foobar"
    And I fill in "article__body_and_extended_editor" with "Lorem Ipsumier"
    And I press "Publish"
    Then I should be on the admin content page
    Then I should see "Foobar 2 Electric Foobar"
    
    When I follow "Foobar"
    Then I should see "merge_with"
    
    When I fill in "merge_with" with "2"
    And I press "Merge With This Article"
    Then I should be on the admin content page
    
    When I go to the home page
    Then I should see "Foobar"
    And I should not see "Foobar 2 Electric Foobar"
    And I should see "Lorem Ipsum"
    And I should see "Lorem Ipsumier"
