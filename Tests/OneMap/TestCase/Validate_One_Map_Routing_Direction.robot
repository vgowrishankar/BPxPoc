*** Settings ***
Resource        ../../../Resources/OneMap/Keywords/One_Map_Routing_Constants.robot


*** Variables ***



*** Test Cases ***
Validate_One_Map_Routing_Direction.robot
    One Map GPS Login
    Navigate_Directions_between_places      ${Source_Input}     ${Destination_Input}
    ${list_Of_Values}=      Fetch_Navigation_Values



*** Keywords ***


