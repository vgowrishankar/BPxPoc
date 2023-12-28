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
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_WellOrigins.py
*** Variables ***
${DD_Selection_Value}       Well Name
${Well_input}       LOWE 54H


*** Test Cases ***

Validate_the_functionality_of_well_list
    [Tags]    TC151123014
    Data Portal MFA Login
    sleep    10
    ${DD_Value}=     replace string    ${Well_origin_Select_pad_name_from_dd}       value      ${DD_Selection_Value}
    Well_origin_Filter_Function_using_Arrow     ${DD_Value}     ${Well_input}
    Custome_Methods.minwindow
    #**********************Get All table values and store in list *************************
    ${all_list_Values}=     Get_all_values_From_Data_porta_Well_origin_table
    &{Fetch_table_value_from_list}=        get from list     ${all_list_Values}     0
    ${Table_Value_padname}=     get from dictionary     ${Fetch_table_value_from_list}      Pad_Name
    ${Fetch_Origin_Corp_ID}=     get from dictionary     ${Fetch_table_value_from_list}      Origin_Corp_ID
    ${new_Fetch_Origin_Corp_ID}=     replace string     ${Fetch_Origin_Corp_ID}       —     ${EMPTY}
    #============================================================================
    sleep    5
    click element        ${Well_Origins_Table_only_Wellname_Value}
    sleep    5
    Select_side_panel
    ${Get_side_panel_title_element}=        replace string    ${Well_Origins_Ex_tab_Title}      value       ${Well_input}
    ${side_panel_Title_Text}=       get text        ${Get_side_panel_title_element}

    #******************* Get all value from Side panel table *********************
    ${side_panel_Table_value}=      Get_all_Value_from_side_panel_info_table

    #******************* Get all value from Side panel information value *********************
    ${side_panel_information_value}=    Get_all_Value_from_side_panel_info_Tab_informations
    ${side_panel_Pad_Name}=     get from dictionary     ${side_panel_information_value}      Pad_Name
    ${side_panel_Pad_ID}=       get from dictionary     ${side_panel_information_value}      Pad_ID
    ${side_panel_Concept_ID}=       get from dictionary     ${side_panel_information_value}      Concept_ID
    ${side_panel_Origin_Corp_ID}=       get from dictionary     ${side_panel_information_value}      Origin_Corp_ID

                            #***** Validation ******
    #Validate Side Panel Heading
    should be equal         ${side_panel_Title_Text}        ${Well_input}       ignore_case=True
    #Validate side panel table value with side panel table values
    dictionaries should be equal     ${Fetch_table_value_from_list}      ${side_panel_Table_value}
    #Validate side panel information value
    should be equal         ${Table_Value_padname}        ${side_panel_Pad_Name}       ignore_case=True
    should be equal         ${new_Fetch_Origin_Corp_ID}        ${side_panel_Origin_Corp_ID}       ignore_case=True










*** Keywords ***








