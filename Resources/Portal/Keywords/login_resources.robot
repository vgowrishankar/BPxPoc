*** Settings ***
Library     SeleniumLibrary
Variables       ../PageObject/Login_Page.py
#Library         DataDriver  ../../../TestData/DataPortal.xls    sheet_name=MFAUser
Resource        ../../../Utilities/Read_data_from_excel_file.robot
Library     OperatingSystem
#Test Template    login_to_Portal
*** Variables ***

${Login_URL}    https://portal.stage.intranet.bpx.com/data-portal/well_origins
${UserName}     SVC-AUTOFRAMEWORK-TEST-S@bpx.com
${Password}     xGP&X8L6M2#9(f^$
${BROWSER}      chrome

*** Keywords ***

login_to_Data_Portal
   # [Arguments]    ${Login_URL}   ${UserName}    ${Password}
    open browser    ${Login_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible    ${Login_page_username}    10s
    input text    ${Login_page_username}    ${UserName}
    click element    ${Login_Page_username_next_btn}
    wait until element is visible    ${Login_page_password}    10s
    input text    ${Login_page_password}  ${Password}
    click element    ${Login_page_login_btn}
    Wait For Condition    return document.readyState == "complete"


Open Browser Facebook
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window

Close Browser Facebook
    Close All Browsers

Open Login Page
    Go To    ${Login_URL}

Input UserName
    [Arguments]    ${UserName}
    Input Text    id=email    ${UserName}

Input Password
    [Arguments]    ${Password}
    Input Text    id=pass     ${Password}

Click login button
    Click Button    name=login

Click signout button
    Click Link    Logout

Error message should be visible
    Page Should Contain    The email address or mobile number you entered isn't connected to an account.

Home Page should be visible
    Page Should Contain    Home

