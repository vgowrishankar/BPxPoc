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
#${Well_origin_DD_Selection_Value}       Well Name
#${Well_input}       DZIUK A 12H
#${Well_bores_DD_Selection_Value}       Well Name
#${Well_bores_input}       DZIUK A 12H
#${Completion_DD_Selection_Value}       Well Name
#${Completion_input}       DZIUK A 12H



*** Test Cases ***

Validate_the_functionality_of_well_list
    [Tags]    TC151123014       TC151123028
    Data Portal MFA Login
    Well_origin_Filter_Function_using_Arrow
    Assign_WellOrigin_Table_Values_as_Variables
    Select_WellBores_Tab
    Well_bores_Filter_Function_using_Arrow
    #Wellbore Section
    ${wellbores_table_value}=       Get_all_values_From_Data_porta_Well_bores_table
    Assign_WellBores_Table_Values_as_Variables        ${wellbores_table_value}
    #Completion Section
    Select_Completions_Tab
    Completions_Filter_Function_using_Arrow
    ${completion_table_value}=       Get_all_values_From_Data_porta_Completions_table
    Select_Value_In_Table
    Select_Completions_side_panel
    ${side_panel_Title_Text}=        Get_Side_Panel_Title
    ${side_panel_Completions_Table_value}=              Get_all_Value_from_Completions_side_panel_info_table
    ${completions_side_panel_information_value}=        Get_all_Value_from_side_panel_info_Tab_informations_Completions
    Assign_Completions_Side_Panel_info_Informations_Values_as_Variables            ${completions_side_panel_information_value}
    Validation_Completions_Side_Panel_info_Table_Value

*** Keywords ***







