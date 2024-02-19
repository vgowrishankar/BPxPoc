*** Settings ***
Resource    ../../../Configs/ApplicationConfigs.robot
#Resource    ../../../Configs/AppiumConfigs.robot
Resource        ../../../Utilities/Read_data_from_excel_file.robot
Resource       ../PageObject/ArcGIS_Navigator_Locators.robot
Library    String
Library    OperatingSystem
Library    AppiumLibrary


*** Keywords ***
Read_Variable_From_Excel
     [Documentation]    This Function used to get cell value from Excel file
    #variable                      Methods name                 Excel File name     Sheet name  Row     Column
    ${App_Login_URL}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    2        2
    ${App_Username}=              Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    3       2
    ${App_Password}=              Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    4       2
    ${APPIUM_SERVER_URL}=         Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    5       2
    ${ANDROID_PLATFORM_NAME}=     Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    6       2
    ${ANDROID_DEVICE_NAME}=       Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    7       2
    ${ANDROID_APP_PACKAGE}=       Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    8       2
    ${ANDROID_APP_ACTIVITY}=      Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    9       2
    ${ANDROID_AUTOMATION_NAME}=   Read_Data_From_Excel_File    User_Dashboard.xlsx    Mobile    10      2

    #Set All variable as Global to access all Testcases
     set global variable    ${App_Login_URL}
     set global variable    ${App_Username}
     set global variable    ${App_Password}
     set global variable    ${APPIUM_SERVER_URL}
     set global variable    ${ANDROID_PLATFORM_NAME}
     set global variable    ${ANDROID_DEVICE_NAME}
     set global variable    ${ANDROID_APP_PACKAGE}
     set global variable    ${ANDROID_APP_ACTIVITY}
     set global variable    ${ANDROID_AUTOMATION_NAME}

     Log To Console    Variable Successfully read from Excel...

#=============================  END  =============================================================

Open Test Application
    [Documentation]    Open the testing application

    Run Keyword If    '${PLATFORM_NAME}' == '${ANDROID_PLATFORM_NAME}'    Open Android Application
    Run Keyword If    '${PLATFORM_NAME}' == '${IOS_PLATFORM_NAME}'    Open IOS Application

#=============================  END  =============================================================

Open Android Application
    [Documentation]    Open the Android application
    Read_Variable_From_Excel
    Open Application    ${APPIUM_SERVER_URL}     platformName=${ANDROID_PLATFORM_NAME}        deviceName=${ANDROID_DEVICE_NAME}        appPackage=${ANDROID_APP_PACKAGE}    appActivity=${ANDROID_APP_ACTIVITY}   automationName=${ANDROID_AUTOMATION_NAME}
    #Open Application    ${APPIUM_SERVER_URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    platformVersion=${ANDROID_PLATFORM_VERSION}    deviceName=${ANDROID_DEVICE_NAME}    app=${ANDROID_APP}    appPackage=${ANDROID_APP_PACKAGE}    appActivity=${ANDROID_APP_ACTIVITY}
    Set Appium Timeout    ${TIMEOUT}
    Log To Console    Android_Appium_Session_started_And_Application_Launched_Succesfully

#=============================  END  =============================================================

Open IOS Application
    [Documentation]    Open the iOS application

    Open Application    ${APPIUM_SERVER_URL}    automationName=${IOS_AUTOMATION_NAME}    platformName=${IOS_PLATFORM_NAME}    platformVersion=${IOS_PLATFORM_VERSION}    deviceName=${IOS_DEVICE_NAME}    app=${IOS_APP}
    Set Appium Timeout    ${TIMEOUT}

#=============================  END  =============================================================

Get Random Email Address
    [Documentation]    Return random email address

    ${randomText}    Get Random Text
    ${randomEmailAddress}    Set Variable    ${randomText}@mailinator.com
    Return From Keyword     ${randomEmailAddress}

#=============================  END  =============================================================

Get Random Text
    [Documentation]    Return random text value

    ${randomText}    Generate Random String      8      [LETTERS]
    Return From Keyword     ${randomText}

#=============================  END  =============================================================

Get Current Epoch Time
    [Documentation]    Return current epoch time

    ${randomText}    Get Time    epoch
    Return From Keyword     ${randomText}

#=============================  END  =============================================================

Element Should Be Contained In The Page [Arguments] ${locator} ${retryScale}
    [Documentation]    Verify that the element should be contained in the page

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Page Contains Element    ${locator}

#=============================  END  =============================================================

Element Should Not Be Contained In The Page [Arguments] ${locator} ${retryScale}
    [Documentation]    Verify that the element should not be contained in the page

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Page Does Not Contain Element   ${locator}

#=============================  END  =============================================================

Element Should Be Visible [Arguments] ${locator} ${retryScale}
    [Documentation]    Verify that the element should be visible

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Element Is Visible    ${locator}

#=============================  END  =============================================================

Element Should Not Be Visible [Arguments] ${locator} ${retryScale}
    [Documentation]    Verify that the element should not be visible

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Page Does Not Contain Element   ${locator}

#=============================  END  =============================================================

Click Element [Arguments] ${locator} ${retryScale}
    [Documentation]    Click on a given button

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Element Is Visible    ${locator}
    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Click Element  ${locator}

#=============================  END  =============================================================

Element Text Should Be [Arguments] ${locator} ${text} ${retryScale}
    [Documentation]    Validate the text of an element

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Element Is Visible    ${locator}
    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Element Text Should Be    ${locator}    ${text}

#=============================  END  =============================================================

Input Text [Arguments] ${textBoxLocator} ${text} ${retryScale}
    [Documentation]    Input text into a text box

    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Wait Until Element Is Visible    ${textBoxLocator}
    Wait Until Keyword Succeeds    ${retryScale}     ${RETRY_DELAY}    Input Text    ${textBoxLocator}    ${text}

#=============================  END  =============================================================

Alert Title Should Be [Arguments] ${alertTitle}
    [Documentation]    Validate the text of the alert title

    ${androidAlertTitleLocator}    Set Variable    id=android:id/alertTitle
    Run Keyword If    '${PLATFORM_NAME}' == '${ANDROID_PLATFORM_NAME}'    Element Text Should Be [Arguments] ${androidAlertTitleLocator} ${alertTitle} ${SMALL_RETRY_COUNT}
    ${iosAlertTitleLocator}    Set Variable    accessibility_id=${alertTitle}
    Run Keyword If    '${PLATFORM_NAME}' == '${IOS_PLATFORM_NAME}'    Element Should Be Visible [Arguments] ${iosAlertTitleLocator} ${SMALL_RETRY_COUNT}

#=============================  END  =============================================================

Alert Message Should Be [Arguments] ${alertMessage}
    [Documentation]    Validate the text of the alert message

    ${androidAlertMessageLocator}    Set Variable    id=android:id/message
    Run Keyword If    '${PLATFORM_NAME}' == '${ANDROID_PLATFORM_NAME}'    Element Text Should Be [Arguments] ${androidAlertMessageLocator} ${alertMessage} ${SMALL_RETRY_COUNT}
    ${iosAlertMessageLocator}    Set Variable    accessibility_id=${alertMessage}
    Run Keyword If    '${PLATFORM_NAME}' == '${IOS_PLATFORM_NAME}'    Element Should Be Visible [Arguments] ${iosAlertMessageLocator} ${SMALL_RETRY_COUNT}

 #=============================  END  =============================================================





Select_ArcGIS_Enterprise_Option
    [Documentation]    This Keyword used to Select ArcGIS_Enterprise_Option
    Sleep    2s
    Click Element    ${ArcGIS Enterprise_Option_Btn_locator}
    Log To Console    ArcGIS_Enterprise_Option_Selected_Successfully

Login_Arc_GIS_With_Valid_credentials
    [Documentation]    This keyword used to Login Arc GIS with Valid Credentials
    Sleep    2s
    Input Text    ${ArcGIS Enterprise_App_URL_Input_locator}     ${App_Login_URL}
    Sleep    2s
    Click Element    ${ArcGIS Enterprise_App_URL_Continue_btn_locator}
    Wait Until Element Is Visible    ${ArcGIS_Id_Password_expand_btn_Locator}    30s
    Click Element    ${ArcGIS_Id_Password_expand_btn_Locator}
    Sleep    2s
    Input Text    ${ArcGIS_User_Name_Input_Locator}    ${App_Username}
    Sleep    2s
    Input Password    ${ArcGIS_Password_Input_Locator}    ${App_Password}
    Sleep    2s
    Click Element    ${ArcGIS_Password_Sign_In_Locator}
    Log To Console    Arc_GIS_Login_Successfully

Enable_Location_option
    [Documentation]    This keyword used to access Location enable options
    Sleep    5s
    Click Element    ${Location_Access_enable_Locator}
    Sleep    3s
    Click Element    ${Location_Access_enable_Continue_Locator}
    Log To Console    Location enable access Provided successfully

Select_Premian_From_list_And_download
    Wait Until Element Is Visible    ${Premian_Navigator_Map_Locator}    20s
    ${Appium_Timeout}=    Get Appium Timeout
    Log To Console    ${Appium_Timeout}
    Click Element    ${Premian_Navigator_Map_Locator}

    #Wait Until Element Is Visible    //android.widget.TextView[@resource-id="com.esri.navigator:id/title" and @text="Permian Navigation"]    300s
    Wait Until Element Is Visible    ${Premian_Navigator_Map_More_Option_Locator}     180s
    sleep  5
    Click Element    ${Premian_Navigator_Map_Locator}

Select_Route_From_List
    [Documentation]   This keyword used to select navigation place from list
    Wait Until Element Is Visible    ${Premian_Navigator_Map_Plan_route_Locator}     180s
    sleep  5
    Click Element    ${Premian_Navigator_Map_2400_Texus_location_Locator}
    Wait Until Element Is Visible    ${Premian_Navigator_Map_go_btn_Locator}     180s
    Click Element    ${Premian_Navigator_Map_go_btn_Locator}
    Wait Until Element Is Visible    ${Premian_Navigator_Map_error_screen_after_go_btn_Locator}     180s
    ${Map_Error_Message}=    Get Text    ${Premian_Navigator_Map_error_screen_after_go_btn_Locator}
    Log To Console    ${Map_Error_Message}
    
