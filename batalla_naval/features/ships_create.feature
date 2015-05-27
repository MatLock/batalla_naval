Feature: Ships create

  Background:
    Given a board with dimensions "5" x "5"

  
  Scenario: Create a small ship in a valid location
    	Given I create a small ship in position "3:3"
    	Then position "3:3" is not empty

      
  Scenario: Create a large ship in a valid location
		Given I create a large ship in position "3:3"
		Then position "3:3" is not empty	
		And position "3:4" is not empty
    	
  
  Scenario: Create a small ship in a valid location
      Given I create a small ship in position "3:3"
      Given I create a small ship in position "3:3"
      Then I get HayBarco

  
  Scenario: Create a large ship in a valid location
      Given I create a large ship in position "3:3"
      Given I create a large ship in position "3:4"
      Then I get HayBarco