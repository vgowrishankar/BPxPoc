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
Resource        ../../../Resources/Portal/Keywords/DataPortal_Constants.robot



*** Variables ***





*** Test Cases ***
Validate_Comments_Section
    [Tags]    TC151123036
    Data Portal MFA Login
    Select_Welbore_Tab
    Filter_with_Value
    Click_Value_In_Table
    Navigate_To_Side_Panel_Comment_Tab_And_Provide_values
    Side_Panel_Comments_Validation









    
