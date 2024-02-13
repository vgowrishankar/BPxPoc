*** Settings ***
Resource         ../../../Resources/Mobile/PageObject/NavigationBar.robot
Resource         ../../../Resources/Mobile/PageObject/LoginScreen.robot
Resource         ../../../Resources/Mobile/Keywords/LoginConstants.robot
Resource         ../../../Resources/Mobile/Keywords/AlertConstants.robot

Test Setup       Open Test Application
Test Teardown    Close Application


*** Test Cases ***
Verify That A User Can Login To The Application Using Valid Credentials
    [Tags]    Smoke

    Navigate To Login Screen
    Login To The Application [Arguments] ${EMAIL_ADDRESS} ${PASSWORD}
    Alert Title Should Be [Arguments] ${LOGIN_SUCCESS_ALERT_TITLE}
    Alert Message Should Be [Arguments] ${LOGIN_SUCCESS_ALERT_MESSAGE}