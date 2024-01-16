*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../PageObject/ArcGIS_Login.py
Resource        ../../../Utilities/Read_data_from_excel_file.robot
Resource        One_Map_Routing_Constants.robot
Resource        ArcGIS_Constants.robot




*** Keywords ***
One Map GIS Login
    ARCGIS_Variables_Read_from_Excel
    seleniumlibrary.open browser    ${GIS_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible   ${ArcGIS_Login_Title}
    click element    ${ArcGIS_Login_Title}
    wait until element is visible    ${Login_page_username}
    wait until element is visible    ${Login_page_password}
    #[Arguments]     ${UserName}
    input text    ${Login_page_username}    ${UserName}
    #[Arguments]    ${Password}
    input text    ${Login_page_password}    ${Password}
    click element    ${Login_page_signIn_btn}
    Wait For Condition  return document.readyState == "complete"

#=============================  END  =============================================================

One Map GPS Login
    ARCGPS_Variables_Read_from_Excel
    open browser    ${GPS_URL}  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible    ${ArcGIS_Login_Title}
    click element    ${ArcGIS_Login_Title}
    wait until element is visible    ${Login_page_username}
    wait until element is visible    ${Login_page_password}
    #[Arguments]     ${UserName}
    input text    ${Login_page_username}     ${UserName}
    #[Arguments]    ${Password}
    input text    ${Login_page_password}    ${Password}
    click element    ${Login_page_signIn_btn}
    Wait For Condition    return document.readyState == "complete"

#=============================  END  =============================================================

Open Browser OneMap Portal
    ARCGPS_Variables_Read_from_Excel
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window
    sleep   5s
    Click Element   ${ArcGIS_Login_Title}

#=============================  END  =============================================================

Get One Map URL
    ${url} =  Execute Javascript  return window.location.href;
    log to console   One Map URL: ${url}

Close Browser One Map

#=============================  END  =============================================================

Input Password
    [Arguments]    ${Password}
    Input Text    id=user_password     ${Password}

#=============================  END  =============================================================

Click Sign in button
    Click Button    id=signIn
    sleep   2s

#=============================  END  =============================================================

Check if the dashboard is loading
    Wait For Condition    return document.readyState == "complete"

#=============================  END  =============================================================

Home Page should be visible
    Page Should Contain    Nimbus Live - Midstream
    sleep   2s

#=============================  END  =============================================================

Close Browser OneMap Portal
    Close All Browsers





