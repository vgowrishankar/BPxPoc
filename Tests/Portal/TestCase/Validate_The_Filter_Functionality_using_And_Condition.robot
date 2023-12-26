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
@{table_value}=    as    if     kh    an
@{list_of_input}=   BU      STATE
${Filter_Mode}         ANY





*** Test Cases ***
sample
    Table_Value_validation_with_filter_option       @{table_value}     ${Filter_Mode}     @{list_of_input}




*** Keywords ***
Validate_The_Filter_Functionality_using_And_Condition
    [Tags]    TC151123011
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function_using_Arrow     gre
    Select_AND_Toggle_button
    Pads_Filter_Function_using_Arrow     gre
    Custome_Methods.minwindow
    sleep    5
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5



