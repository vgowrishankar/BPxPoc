*** Settings ***
Documentation   Login to GPS One Map BPX Routing
Library         SeleniumLibrary
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_LogIn.robot


*** Keywords ***
One Map GIS Login
    ARCGPS_Variables_Read_from_Excel
    seleniumlibrary.open browser    ${GIS_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible   ${ArcGIS_Login_Title}
    click element    ${ArcGIS_Login_Title}
    wait until element is visible    ${Login_page_username}
    wait until element is visible    ${Login_page_password}
    input text    ${Login_page_username}    ${UserName}
    input text    ${Login_page_password}    ${Password}
    click element    ${Login_page_signIn_btn}
    Wait For Condition  return document.readyState == "complete"