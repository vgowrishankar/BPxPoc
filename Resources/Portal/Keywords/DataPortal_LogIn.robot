*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataPortal.xls     sheet_name=MFAUser
Variables       ../PageObject/DataPortal_LogIn.py

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://portal.stage.intranet.bpx.com/
${UserName}     SVC-AUTOFRAMEWORK-TEST-S@bpx.com
${Password}     xGP&X8L6M2#9(f^$

*** Keywords ***
Data Portal MFA Login
    open browser    ${Login_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible    ${Login_page_username}
    #[Arguments]     ${UserName}
    input text    ${Login_page_username}    ${UserName}
    click element    ${Login_Page_username_next_btn}
    wait until element is visible    ${Login_page_password}
    #[Arguments]    ${Password}
    input text    ${Login_page_password}  ${Password}
    click element    ${Login_page_login_btn}
    Wait For Condition    return document.readyState == "complete"

Get Data Portal URL
    ${url} =  Execute Javascript  return window.location.href;
    log to console   Data Portal URL: ${url}

Close Browser Data Portal
    Close All Browsers