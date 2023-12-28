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
@{keys}=        ${EMPTY}     padname      padid       businessunit        fine
${file_input}=    "C:${/}Users${/}10712370${/}PycharmProjects${/}pythonProject${/}BPxPoc${/}selenium-screenshot-1.png"
${Uploading_files}=     "C:\\Users\\10712370\\PycharmProjects\\pythonProject\\BPxPoc\\TestData\\Upload_files\\Test_csv_file.csv""C:\\Users\\10712370\\PycharmProjects\\pythonProject\\BPxPoc\\TestData\\Upload_files\\Test_PPT_file.pptx"
@{Uploading_file_names}=    Test_csv_file.csv       Test_PPT_file.pptx

*** Test Cases ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    login_to_Portal_and_Navigate_to_Side_panel_Attachement_Tab
    Filter_with_values
    Navigate_to_attachment_Tab
    custome_methods.upload files     ${Uploading_files}
    Uploaded_file_validation





*** Keywords ***
login_to_Portal_and_Navigate_to_Side_panel_Attachement_Tab
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}



Filter_with_values
    Pads_Filter_Function_using_Arrow     gre
    Custome_Methods.minwindow
    sleep    5
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5

Navigate_to_attachment_Tab
    Select_side_panel
    wait until element is visible     ${Pads_Ex_Tab_Pad_data_Attachemnts}
    click element        ${Pads_Ex_Tab_Pad_data_Attachemnts}
    sleep    5
    click element      ${Pads_Ex_Tab_Pad_data_Attachements_first_area_Browse_file_btn}

Uploaded_file_validation
    ${list_of_files_uploaded}=      Get_all_uploaded_file_list
    FOR    ${file_name}     IN    @{Uploading_file_names}
        list should contain value    ${list_of_files_uploaded}      ${file_name}
    END


