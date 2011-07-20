@fees
Feature: Fees
  In order to have fees on my website
  As an administrator
  I want to manage fees

  Background:
    Given I am a logged in refinery user
    And I have no fees

  @fees-list @list
  Scenario: Fees List
   Given I have fees titled UniqueTitleOne, UniqueTitleTwo
   When I go to the list of fees
   Then I should see "UniqueTitleOne"
   And I should see "UniqueTitleTwo"

  @fees-valid @valid
  Scenario: Create Valid Fee
    When I go to the list of fees
    And I follow "Add New Fee"
    And I fill in "From account" with "This is a test of the first string field"
    And I press "Save"
    Then I should see "'This is a test of the first string field' was successfully added."
    And I should have 1 fee

  @fees-invalid @invalid
  Scenario: Create Invalid Fee (without from)
    When I go to the list of fees
    And I follow "Add New Fee"
    And I press "Save"
    Then I should see "From can't be blank"
    And I should have 0 fees

  @fees-edit @edit
  Scenario: Edit Existing Fee
    Given I have fees titled "A from"
    When I go to the list of fees
    And I follow "Edit this fee" within ".actions"
    Then I fill in "From" with "A different from"
    And I press "Save"
    Then I should see "'A different from' was successfully updated."
    And I should be on the list of fees
    And I should not see "A from"

  @fees-duplicate @duplicate
  Scenario: Create Duplicate Fee
    Given I only have fees titled UniqueTitleOne, UniqueTitleTwo
    When I go to the list of fees
    And I follow "Add New Fee"
    And I fill in "From" with "UniqueTitleTwo"
    And I press "Save"
    Then I should see "There were problems"
    And I should have 2 fees

  @fees-delete @delete
  Scenario: Delete Fee
    Given I only have fees titled UniqueTitleOne
    When I go to the list of fees
    And I follow "Remove this fee forever"
    Then I should see "'UniqueTitleOne' was successfully removed."
    And I should have 0 fees
 