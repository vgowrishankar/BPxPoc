*** Settings ***
Library          AppiumLibrary
Resource         ../../../Resources/Mobile/Keywords/Common.robot
Resource         ../../../Configs/ApplicationConfigs.robot


*** Variables ***
${APPIUM_SERVER_URL}          http://localhost:4723
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_DEVICE_NAME}        emulator-5554
${ANDROID_APP_PACKAGE}        com.google.android.calendar
${ANDROID_APP_ACTIVITY}       com.android.calendar.LaunchActivity
${ANDROID_AUTOMATION_NAME}    uiautomator2


*** Test Cases ***
Open Calender Application and Add Event and Task for BPX test
    [Tags]
    Open Application    ${APPIUM_SERVER_URL}     platformName=${ANDROID_PLATFORM_NAME}        deviceName=${ANDROID_DEVICE_NAME}        appPackage=${ANDROID_APP_PACKAGE}    appActivity=${ANDROID_APP_ACTIVITY}   automationName=${ANDROID_AUTOMATION_NAME}
    #Set Appium Timeout    ${TIMEOUT}
    Log To Console    Android_Appium_Session_started_And_Application_Launched_Successfully
    Add Event for Calender
    Add Task for Calender
    Close Application





