*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://onemap.bpx.com/portal/apps/dashboards/8eead05d24e04e2ca5b1212e2bbab3b6

*** Keywords ***

Open Browser OneMap Portal
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window
    sleep   10s
    Click Element   id=loginTitle

Input UserName
    [Arguments]    ${UserName}
    Input Text    id=user_username    ${UserName}
    sleep   2s

Input Password
    [Arguments]    ${Password}
    Input Text    id=user_password     ${Password}

Click Sign in button
    Click Button    id=signIn
    sleep   2s

Home Page should be visible
    Page Should Contain    ArcGIS Dashboards
    sleep   2s

Close Browser OneMap Portal
    Close All Browsers