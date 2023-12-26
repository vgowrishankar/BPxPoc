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
${Upload_URl_name}=    Test_URL_NAME
${Upload_URl}=   Test url
${file_Name}=   template_01.docx



*** Test Cases ***
Validate_file_upload_functionality_via_Url_of_the_file
    [Tags]    TC151123001
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function_using_Arrow     gre
    Custome_Methods.minwindow
    sleep    5
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5
    Select_side_panel
    wait until element is visible     ${Pads_Ex_Tab_Pad_data_Attachemnts}
    click element        ${Pads_Ex_Tab_Pad_data_Attachemnts}
    sleep    5
    Upload_URL_function         ${Upload_URl_name}          ${Upload_URl}
    Sleep   5
    ${list_of_uploadedfile}=        Get_all_uploaded_file_list
    ${latest}=    get from list    ${list_of_uploadedfile}          0
    list should contain value      ${list_of_uploadedfile}       ${file_Name}
    should be equal as strings    ${latest}         ${file_Name}

*** Keywords ***



