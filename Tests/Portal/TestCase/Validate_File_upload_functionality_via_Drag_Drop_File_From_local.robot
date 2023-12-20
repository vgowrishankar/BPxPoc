*** Settings ***
Library         SeleniumLibrary
Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
Resource        ../../../Resources/Portal/Keywords/login_resources.robot
*** Variables ***
*** Test Cases ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    login_to_Data_Portal
    sleep    5
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function    Pad Name  Landgre
    sleep    5
    get_all_values_from_table







*** Keywords ***
