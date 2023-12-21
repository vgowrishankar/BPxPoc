*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../PageObject/ArcGIS_LogIn.py


*** Variables ***
${BROWSER}      Chrome
${GIS_URL}      https://onemap.bpx.com/portal/apps/dashboards/8eead05d24e04e2ca5b1212e2bbab3b6
${GPS_URL}      https://onemap.bpx.com/portal/apps/webappviewer/index.html?id=9226c6c1d0c844cfa5ae0a0cc8908ddc
${UserName}     qeadmin
${Password}     Welcome2BPX!


*** Keywords ***
One Map GIS Login
    open browser    ${GIS_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible   xpath=//*[@id="loginTitle"]
    click element    xpath=//*[@id="loginTitle"]
    wait until element is visible    ${Login_page_username}
    wait until element is visible    ${Login_page_password}
    #[Arguments]     ${UserName}
    input text    ${Login_page_username}    ${UserName}
    #[Arguments]    ${Password}
    input text    ${Login_page_password}    ${Password}
    click element    ${Login_page_signIn_btn}
    Wait For Condition  return document.readyState == "complete"

One Map GPS Login
    open browser    ${GPS_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible    xpath=//*[@id="loginTitle"]
    click element    xpath=//*[@id="loginTitle"]
    wait until element is visible    ${Login_page_username}
    wait until element is visible    ${Login_page_password}
    #[Arguments]     ${UserName}
    input text    ${Login_page_username}    ${UserName}
    #[Arguments]    ${Password}
    input text    ${Login_page_password}    ${Password}
    click element    ${Login_page_signIn_btn}
    Wait For Condition    return document.readyState == "complete"

Get One Map URL
    ${url} =  Execute Javascript  return window.location.href;
    log to console   One Map URL: ${url}

Close Browser One Map
    Close All Browsers