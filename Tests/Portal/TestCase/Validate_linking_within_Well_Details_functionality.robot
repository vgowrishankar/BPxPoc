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
sample
    Validate_the_functionality_of_well_list

*** Keywords ***
Validate_the_functionality_of_well_list
    [Tags]    TC151123014
    Data Portal MFA Login
    sleep    10
    #===============
    ${DD_Value}=     replace string    ${Well_origin_Select_pad_name_from_dd}       value      ${Well_origin_DD_Selection_Value}
    Well_origin_Filter_Function_using_Arrow     ${DD_Value}     ${Well_input}
    Custome_Methods.minwindow
    #**********************Get All table values and store in list *************************
    ${all_list_Values}=     Get_all_values_From_Data_porta_Well_origin_table
    &{Fetch_table_value_from_list}=        get from list     ${all_list_Values}     0
    ${Table_Value_padname}=     get from dictionary     ${Fetch_table_value_from_list}      Pad_Name
    ${Fetch_Origin_Corp_ID}=     get from dictionary     ${Fetch_table_value_from_list}      Origin_Corp_ID
    ${new_Fetch_Origin_Corp_ID}=     replace string     ${Fetch_Origin_Corp_ID}       —     ${EMPTY}
    #===============
    sleep    5

    #Wellbore Section
    click element       ${Wellbores_Tab}
    sleep    3
    ${DD_selection_element}=    replace string      ${Well_bores_Select_pad_name_from_dd}       value             ${Well_bores_DD_Selection_Value}
    Well_bores_Filter_Function_using_Arrow       ${DD_selection_element}     ${Well_bores_input}
    ${wellbores_table_value}=       Get_all_values_From_Data_porta_Well_bores_table

    #Completion Section
    click element       ${Completions_Tab}
    ${DD_completion_selection_element}=    replace string      ${Completions_Select_pad_name_from_dd}       value             ${Completion_DD_Selection_Value}
    Completions_Filter_Function_using_Arrow       ${DD_completion_selection_element}     ${Completion_input}
    ${completion_table_value}=       Get_all_values_From_Data_porta_Completions_table





