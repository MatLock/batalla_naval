
Feature: Ships create

Background:
    Given a board with dimensions "5" x "5"


Scenario: Create a small ship in a valid location
    Given I create a small ship in position "(3:3)"
    Then position "(3:3)" is not empty



Scenario: Create a large ship in a valid location
    Given I create a large ship in position "(2:2),(3:3),(4:4)"
    Then position "(2:2)" is not empty    
    And position "(3:3)" is not empty 
    And position "(4:4)" is not empty   
    Then position "(1:1)" is empty


Scenario: al colocar un barco en una posicion invalida debo lanzar una excepcion
	Given coloco un barco en la posicion "(6:6)"
	Then un error de "No es posible colocar un barco fuera del mapa!!" debe ser lanzada


Scenario: al colocar un barco en una posicion ya ocupada debo lanzar una excepcion
	Given coloco dos barcos en la posicion "(1:1)"
	Then un error de "Ya existe un barco en la coordenada proporcionada!" debe ser esperado

