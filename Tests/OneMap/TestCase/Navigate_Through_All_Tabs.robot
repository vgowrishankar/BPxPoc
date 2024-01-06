*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../../../Resources/OneMap/PageObject/ArcGIS_Login.py
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_LogIn.robot
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_Constants.robot
Library         String
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library          JSONLibrary


*** Variables ***

*** Test Cases ***
Navigate_Through_All_Tabs
    One Map GIS Login
    Navigate_To_Scada_Tab
    Fetch_Scada_H2S_Graph_Value
    Fetch_Scada_lEL_Graph_Value
    Navigate_To_Power_Tab
    Select_Sensore_Value
    Fetch_Power_Battery_VoltageVDC_Graph_Value
    Fetch_Graph_Value_Fetch_Power_Battery_CurrentA_Graph_Value
    Fetch_Power_Solar_VoltageVDC_Graph_Value
    Fetch_Power_Solar_CurrentA_Graph_Value
    Navigate_To_Wind_Tab_Graph_Value
    Fetch_Wind_WindSpeed_Graph_Value
    Fetch_Wind_Direction_Graph_Value




*** Keywords ***
Fetch_Graph_Value
    [Arguments]    ${Graph_locator}
    sleep   10
    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}=      create list
    ${list_of_elements}=        get webelements     ${Graph_locator}
    ${Element_count}=    get element count    ${Graph_locator}
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    ${Graph_locator}\[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     get_Attribute_value_and_store      ${single_ele}       aria-label      ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}
        #${get_Graph_Value}=     get element attribute    ${single_ele}      aria-label
        #log to console    ${get_Graph_Value}
        #append to list    ${list_of_Values}       ${get_Graph_Value}
    END
    log to console    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}
    log list    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}
    log to console    Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C_completed
    [Return]        ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}

Navigate_To_Scada_Tab
     wait until element is visible    ${Graph_Scada_btn}     10s
     click element    ${Graph_Scada_btn}

Fetch_Scada_H2S_Graph_Value
    @{Scada_H2S_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Scada_H2S}

Fetch_Scada_lEL_Graph_Value
    @{Scada_lEL_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Scada_LEL}


Navigate_To_Power_Tab
     wait until element is visible    ${Graph_Power_btn}     10s
     click element    ${Graph_Power_btn}

Select_Sensore_Value
    wait until element is visible    ${Sensor_status_values}
    click element    ${Sensor_status_values}

Fetch_Power_Battery_VoltageVDC_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Battery_VoltageVDC}
    @{Power_Battery_VoltageVDC_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Battery_VoltageVDC}

Fetch_Graph_Value_Fetch_Power_Battery_CurrentA_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Battery_CurrentA}
    @{Power_Battery_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Battery_CurrentA}

Fetch_Power_Solar_VoltageVDC_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Solar_VoltageVDC}
    @{Power_Solar_VoltageVDC_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Solar_VoltageVDC}

Fetch_Power_Solar_CurrentA_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Solar_CurrentA}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Solar_CurrentA}

Navigate_To_Wind_Tab_Graph_Value
     wait until element is visible    ${Graph_Wind_btn}     10s
     click element    ${Graph_Wind_btn}

Fetch_Wind_WindSpeed_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Wind_WindSpeed}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Wind_WindSpeed}

Fetch_Wind_Direction_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Wind_WindDirection}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Wind_WindDirection}



