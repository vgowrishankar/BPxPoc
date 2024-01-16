*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../../../Resources/OneMap/PageObject/ArcGIS_Login.py
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_LogIn.robot
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_Constants.robot
Library         String
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library          JSONLibrary

*** Variables ***





*** Test Cases ***
Validate_if_MidStream_Dashboard_is_loading
    One Map GIS Login
    Business_Unit_Selection
    Facility_Selection
    Gateway_Selection
    ${List_Of_Sensor_Value}=    Get_Nimbus_Sensors_Counts_and_Values
    Validate_Sensors_Have_the_Selected_Gateway      ${List_Of_Sensor_Value}     ${Gateway_input}
    Validate_Online_Sensore_Count        ${List_Of_Sensor_Value}


*** Keywords ***











