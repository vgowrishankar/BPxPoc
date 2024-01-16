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




*** Test Cases ***
Validate_file_upload_functionality_via_Url_of_the_file
    [Tags]    TC151123001
    Data Portal MFA Login
    Select_Pads_Tab
    Filter_with_values
    Click_Table_Value
    Select_side_panel
    Click_Attachment_Tab
    Upload_URL_function         ${Pads_Attachments_URL_Name}          ${Pads_Attachments_URL}
    URL_Upload_files_validation



*** Keywords ***





