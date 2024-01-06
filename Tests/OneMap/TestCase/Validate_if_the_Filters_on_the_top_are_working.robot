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
${Gateway_input}=        ngw-perm-ms-001




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





Validate_Online_Sensore_Count
    [Documentation]    This Keyword used Fetch NS online Count and compare with Sensore value online count
    [Arguments]         ${list_Of_Dictionary}
    sleep    5
    ${NSCount}=    get text    ${NS_Online_Count}
    log     Numbus_Sensor_Count_Is=${NSCount}
    ${List_length}=     get length    ${list_Of_Dictionary}
    ${Online_list}=     create list
    FOR    ${i}     IN RANGE     0      ${List_length}
            ${list_Value}=  get from list    ${list_Of_Dictionary}      ${i}
            ${Gateway_value}=       get from dictionary    ${list_Value}        online_status
            append to list    ${Online_list}        ${Gateway_value}
    END
    ${Actual_NS_online_Count}=      count values in list        ${Online_list}      Online
    should be equal as strings    ${NSCount}       ${Actual_NS_online_Count}






