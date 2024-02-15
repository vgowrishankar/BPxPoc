*** Settings ***
Resource         ../../../Resources/Mobile/PageObject/NavigationBar.robot
Resource         ../../../Resources/Mobile/PageObject/LoginScreen.robot
Resource         ../../../Resources/Mobile/Keywords/LoginConstants.robot
Resource         ../../../Resources/Mobile/Keywords/AlertConstants.robot
#Resource         ../../../Resources/OneMap/Keywords/ArcGIS_Login.robot


#Test Setup       Open Test Application
#Test Teardown    Close Application

*** Variables ***

${LoginURL}    https://onemap.bpx.com/portal
${Username}    qeadmin
${Password}    Welcome2BPX!

*** Test Cases ***
Verify That A User Can Login To The Application Using Valid Credentials
    [Tags]    Smoke

    #Navigate To Login Screen
    #Login To The Application [Arguments] ${EMAIL_ADDRESS} ${PASSWORD}
    #Alert Title Should Be [Arguments] ${LOGIN_SUCCESS_ALERT_TITLE}
    #Alert Message Should Be [Arguments] ${LOGIN_SUCCESS_ALERT_MESSAGE}

    Open Application    http://localhost:4723    platformName=Android    platformVersion=14    appPackage=com.esri.navigator    automationName=UiAutomator2    appActivity=com.esri.apps.androidcore.activities.AppEntryActivity
    Sleep    2s
    Click Element    //android.widget.TextView[@text="ArcGIS Enterprise"]
    Sleep    2s
    Input Text    //android.widget.EditText[@resource-id="com.esri.navigator:id/eaf_alert_dialog_editText"]     ${LoginURL}
    Sleep    2s
    Click Element    //android.widget.Button[@resource-id="android:id/button1"]
    #Sleep    10s
    Wait Until Element Is Visible    //android.view.View[@resource-id="loginTitle"]    30s
    Click Element    //android.view.View[@resource-id="loginTitle"]
    Sleep    2s
    Input Text    //android.widget.EditText[@resource-id="user_username"]    ${Username}
    Sleep    2s
    Input Password    //android.widget.EditText[@resource-id="user_password"]    ${Password}
    Sleep    2s
    Click Element    //android.widget.Button[@resource-id="signIn"]
    Sleep    5s
    Click Element    //android.widget.Button[@resource-id="com.esri.navigator:id/location_rationale_call_to_action"]
    Sleep    3s
    Click Element    //android.widget.Button[@resource-id="com.android.permissioncontroller:id/permission_allow_one_time_button"]
    Sleep    20s
    Click Element    //android.widget.TextView[@resource-id="com.esri.navigator:id/title" and @text="Permian Navigation"]
    Sleep    300s
    Click Element    //android.widget.TextView[@resource-id="com.esri.navigator:id/title" and @text="Permian Navigation"]
