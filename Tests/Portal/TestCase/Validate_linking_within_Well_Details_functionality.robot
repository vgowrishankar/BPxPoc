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
Variables       ../../../Resources/Portal/PageObject/DataPortal_Wellbores.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_Completions.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Wellbores.robot
Resource        ../../../Resources/Portal/Keywords/DataPortal_Completions.robot
*** Variables ***
${Well_origin_DD_Selection_Value}       Well Name
${Well_input}       DZIUK A 12H
${Well_bores_DD_Selection_Value}       Well Name
${Well_bores_input}       DZIUK A 12H
${Completion_DD_Selection_Value}       Well Name
${Completion_input}       DZIUK A 12H



*** Test Cases ***

Validate_the_functionality_of_well_list
    [Tags]    TC151123014       TC151123028
    Data Portal MFA Login
    Navigate_to_WellOrigin_Tab_and_Filter_with_Value
    Fetching_all_values_from_Well_Origin_Table
    #Wellbore Section
    Navigate_to_Wellbores_Tab_and_Filter_with_Value
    Fetching_all_values_from_Well_bores_Table
    #Completion Section
    Navigate_to_Completions_Tab_and_Filter_with_Value
    Fetching_all_values_from_Completions_Table
    Select_Completions_side_panel
    Fetching_all_values_from_Completions_side_Panel_Info_Tab_Informations_Values
    #****     Validations    ********
     #compare well name with well origin,wellbore,completions Tabs
     should be equal         ${Table_Value_wellname}        ${well_boar_Table_Value_wellname}       ignore_case=True
     should be equal         ${Table_Value_wellname}        ${Completion_Ex_Tab_info_information_wellname}       ignore_case=True

    #Compare Pad name with well origin & completions tabs
     should be equal         ${Table_Value_padname}        ${Completion_Ex_Tab_info_information_Padname}       ignore_case=True

     #Compare Origin_Corp_ID with well origin,well bore & completions tabs
     should be equal         ${Fetch_Origin_Corp_ID}        ${well_boar_Table_Value_Origin_Corp_ID}       ignore_case=True
     should contain         ${Completion_Ex_Tab_info_information_origin_corp_id}        ${Fetch_Origin_Corp_ID}       ignore_case=True

     #Compare Wellbore corp ID with Wellbore and Completions Tab Values
     should be equal         ${well_boar_Table_Value_Wellbore_Corp_ID}        ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}       ignore_case=True


*** Keywords ***
Navigate_to_WellOrigin_Tab_and_Filter_with_Value
     sleep    10
    #===============
    ${DD_Value}=     replace string    ${Well_origin_Select_pad_name_from_dd}       value      ${Well_origin_DD_Selection_Value}
    Well_origin_Filter_Function_using_Arrow     ${DD_Value}     ${Well_input}
    custome_methods.minwindow

Fetching_all_values_from_Well_Origin_Table
    #**********************Get All table values and store in list *************************
    ${all_list_Values}=     Get_all_values_From_Data_porta_Well_origin_table
    &{Fetch_table_value_from_list}=        get from list     ${all_list_Values}     0
    ${Table_Value_wellname}=     get from dictionary     ${Fetch_table_value_from_list}      Well_Name
    ${Table_Value_padname}=     get from dictionary     ${Fetch_table_value_from_list}      Pad_Name
    ${Fetch_Origin_Corp_ID}=     get from dictionary     ${Fetch_table_value_from_list}      Origin_Corp_ID
    ${new_Fetch_Origin_Corp_ID}=     replace string     ${Fetch_Origin_Corp_ID}       —     ${EMPTY}
    set suite variable    ${Table_Value_wellname}
    set suite variable    ${Table_Value_padname}
    set suite variable    ${Fetch_Origin_Corp_ID}
    set suite variable    ${new_Fetch_Origin_Corp_ID}
    #===============
    sleep    5

Navigate_to_Wellbores_Tab_and_Filter_with_Value
    click element       ${Wellbores_Tab}
    sleep    3
    ${DD_selection_element}=    replace string      ${Well_bores_Select_pad_name_from_dd}       value             ${Well_bores_DD_Selection_Value}
    Well_bores_Filter_Function_using_Arrow       ${DD_selection_element}     ${Well_bores_input}

Fetching_all_values_from_Well_bores_Table
    ${wellbores_table_value}=       Get_all_values_From_Data_porta_Well_bores_table
    &{Fetch_table_value_from_wellbore_data_list}=        get from list     ${wellbores_table_value}     0
    ${well_boar_Table_Value_wellname}=     get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Well_Name
    ${well_boar_Table_Value_Origin_Corp_ID}=     get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Origin_Corp_ID
    ${well_boar_Table_Value_Wellbore_Corp_ID}=     get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Wellbore_Corp_ID

    set suite variable    ${well_boar_Table_Value_wellname}
    set suite variable    ${well_boar_Table_Value_Origin_Corp_ID}
    set suite variable    ${well_boar_Table_Value_Wellbore_Corp_ID}

Navigate_to_Completions_Tab_and_Filter_with_Value
    click element       ${Completions_Tab}
    sleep  5
    ${DD_completion_selection_element}=    replace string      ${Completions_Select_pad_name_from_dd}       value             ${Completion_DD_Selection_Value}
    Completions_Filter_Function_using_Arrow       ${DD_completion_selection_element}     ${Completion_input}

Fetching_all_values_from_Completions_Table
    ${completion_table_value}=       Get_all_values_From_Data_porta_Completions_table
    click element        ${Completions_Table_only_Wellname_Value}
    sleep    5

Fetching_all_values_from_Completions_side_Panel_Info_Tab_Informations_Values
    ${Get_side_panel_title_element}=        replace string    ${Completions_Ex_tab_Title}      value       ${Well_input}
    ${side_panel_Title_Text}=       get text        ${Get_side_panel_title_element}
    ${side_panel_Completions_Table_value}=      Get_all_Value_from_Completions_side_panel_info_table
    ${completions_side_panel_information_value}=    Get_all_Value_from_side_panel_info_Tab_informations_Completions
    ${Completion_Ex_Tab_info_information_wellname}=     get from dictionary     ${completions_side_panel_information_value}      Well_Name
    ${Completion_Ex_Tab_info_information_Padname}=     get from dictionary     ${completions_side_panel_information_value}      Pad_Name
    ${Completion_Ex_Tab_info_information_origin_corp_id}=     get from dictionary     ${completions_side_panel_information_value}      Origin_Corp_ID
    ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}=     get from dictionary     ${completions_side_panel_information_value}      Wellbore_Corp_ID
    set suite variable     ${Completion_Ex_Tab_info_information_wellname}
    set suite variable     ${Completion_Ex_Tab_info_information_Padname}
    set suite variable     ${Completion_Ex_Tab_info_information_origin_corp_id}
    set suite variable     ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}



