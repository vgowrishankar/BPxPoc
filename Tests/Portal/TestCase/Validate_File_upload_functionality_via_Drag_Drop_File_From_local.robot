*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py

Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
#Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot


*** Variables ***
@{keys}=        ${EMPTY}     padname      padid       businessunit        fine

*** Test Cases ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function_using_Arrow     gre
    Get_all_values_From_Data_porta_Pads_table











*** Keywords ***

