*** Settings ***
Library         SeleniumLibrary
Library         String
Library         ../../../Resources/Portal/PageObject/Locators.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
Resource        ../../../Resources/Portal/Keywords/DataPortal_Wells.robot
#Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot
Resource        ../../../Resources/Portal/Keywords/DataPortal_Wellbores.robot
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_WellOrigins.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_Wellbores.py
*** Variables ***
${Well_bores_DD_Selection_Value}       Well Name
${Well_bores_input}       DZIUK A 12H
${Well_bores_Comment_Section_Input}     Test Comment
*** Test Cases ***
Validate_Comments_Section
    [Tags]    TC151123036
    login_to_Portal
    Filter_with_Value
    Navigate_To_Side_Panel_Comment_Tab_And_Provide_values
    Comments_Validation

*** Keywords ***

login_to_Portal
    Data Portal MFA Login
    sleep    10
    custome_methods.minwindow
    click element       ${Wellbores_Tab}
    sleep    3

Filter_with_Value
    ${DD_selection_element}=    replace string      ${Well_bores_Select_pad_name_from_dd}       value             ${Well_bores_DD_Selection_Value}
    Well_bores_Filter_Function_using_Arrow       ${DD_selection_element}     ${Well_bores_input}
    custome_methods.minwindow
    wait until element is visible    ${Well_bores_Table_only_Wellname_Value}    10s
    click element        ${Well_bores_Table_only_Wellname_Value}
    sleep    5
Navigate_To_Side_Panel_Comment_Tab_And_Provide_values
    Select_Wellbore_side_panel
    wait until element is visible    ${Well_bores_Ex_Tab_Pad_data_Comments}    10s
    click element    ${Well_bores_Ex_Tab_Pad_data_Comments}
    input text    ${Well_bores_Ex_Tab_Pad_data_Comments_Input}       ${Well_bores_Comment_Section_Input}
    click element    ${Well_bores_Ex_Tab_Pad_data_Comments_Post_btn}

Comments_Validation
    ${List_Of_Comments}=    Get_all_Comments_list
    log to console    ${List_Of_Comments}
    ${Latest_comment}=      get from list    ${List_Of_Comments}        0
    should contain    ${Latest_comment}        ${Well_bores_Comment_Section_Input}