*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
#Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py


*** Variables ***
${filter_value}       OR
@{table_value}=     anstate    state     anstEate    st
@{list_of_input}=   an      STATE




*** Test Cases ***
Validate_The_Filter_Functionality_using_And_Condition
    [Tags]    TC151123011
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    #Select_AND_Toggle_button
    FOR    ${i}    IN    @{list_of_input}
    Pads_Filter_Function_using_Arrow     ${i}
    sleep    3
    END
    Custome_Methods.minwindow
    sleep    5
    ${list_of_value}=   Get_all_Value_from_Pad_name_Header_table
    log to console    ${list_of_value}
    Table_Value_validation_with_filter_option       ${list_of_value}      ${list_of_input}        ${filter_value}




*** Keywords ***
