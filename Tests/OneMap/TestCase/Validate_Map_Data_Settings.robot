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
Validate_Map_Data_Settings
    One Map GIS Login
    Business_Unit_Selection
    Facility_Selection
    Gateway_Selection
    Select_Bookmark_option
    Validate_Data_Removed_After_Bookmark_selection
    Select_Default_Bookmark_option_And_Validate
    ${List_Of_Sensor_Value}=    Get_Nimbus_Sensors_Counts_and_Values
    #Validate_Sensors_Have_the_Selected_Gateway      ${List_Of_Sensor_Value}     ${Gateway_input}
    Validate_Sensors_Have_the_Selected_Facility     ${List_Of_Sensor_Value}     ${Facility_Input}

*** Keywords ***






