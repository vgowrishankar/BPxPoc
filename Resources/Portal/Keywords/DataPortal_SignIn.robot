*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataPortal.xls     sheet_name=MFAUser

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://portal.stage.intranet.bpx.com/

*** Keywords ***

Open Browser Data Portal
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window
    sleep   10s

Open MFA Login Page
    [Arguments]    ${Login_URL}
    Go To    ${Login_URL}
    wait until page contains    Input UserName
    sleep   2s

Input UserName
    [Arguments]    ${UserName}
    Input Text    id=i0116    ${UserName}
    Click Button    id=idSIButton9
    sleep   2s

Input Password
    [Arguments]    ${Password}
    Input Text    id=i0118     ${Password}

Click Sign in button
    Click Button    id=idSIButton9
    sleep   2s

Home Page should be visible
    Page Should Contain    BPX Data Portal
    sleep   2s

Close Browser Data Portal
    Close All Browsers