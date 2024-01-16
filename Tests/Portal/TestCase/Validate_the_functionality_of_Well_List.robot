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
#${WellOrigins_DropDown_Selection}       Well Name
#${WellOrigins_Search_Input}       LOWE 54H


*** Test Cases ***

Validate_the_functionality_of_well_list
    [Tags]    TC151123014
    Data Portal MFA Login
    Well_origin_Filter_Function_using_Arrow
    Validate_Table_Value_with_Side_Panel_Information_Values


*** Keywords ***








