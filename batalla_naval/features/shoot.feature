Feature: Shoot
	
	Background:
		Given a board with dimension "5" x "5"
		And a large ship in position "3:3"
		
	Scenario: Shoot and hit
		Given I shoot to position "3:3"
		Then I get hit


	Scenario: Shoot and miss
		Given I shoot to position "2:3"
		Then I get water

		
	Scenario: Shoot and sink
		Given I shoot to position "3:3"
		Then I get hit
		And I shoot to position "3:4"
		Then I get sink
