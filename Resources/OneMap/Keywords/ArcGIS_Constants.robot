*** Settings ***
Library         SeleniumLibrary
Library          DataDriver         ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../PageObject/ArcGIS_Login.py
Resource        ArcGIS_LogIn.robot
Library         String
Library         DataDriver       ../../../TestData/Database.xls
Library         Collections
Library          JSONLibrary



*** Variables ***
@{Sensor_Status_Headings}=        ${EMPTY}    Gateway       Facility        online_status       last_online_status      Last_Alarm_status
#${Business_Unit_Input}=     Permian
#${Facility_Input}=      GRAND SLAM CDP
#${Gateway_input}=       ngw-perm-ms-001
@{list_of_Values}





*** Keywords ***
Select_from_Drop_Down_value
    [Arguments]    ${Selection_Value}
    ${New_element}=     replace string    ${DD_Value_Selection}     value        ${Selection_Value}
    wait until element is visible     ${New_element}    10s
    click element     ${New_element}

#=============================  END  =============================================================
Get_all_Values_From_Sensor_status
    ${Total_set}   get element count     ${Sensor_staus_Total_Value_set}
    LOG TO CONSOLE    Total_data_count_is=${Total_set}
    ${Total_data_Per_set}   GET ELEMENT COUNT     ${Sensor_status_Total_data_Per_set}
    LOG TO CONSOLE    Total_data_set_is=${Total_data_Per_set}
    ${list_To_Store}=   create list
    FOR    ${i}    IN RANGE     1       ${Total_set}+1
        ${rowindex}=    convert to string    ${i}
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${Total_data_Per_set}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Sensor_Status_Fetch_All_Values}       Setindex       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       dataindex       ${dataindex}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT          ${Text_element}
        set to dictionary    ${dict}        ${Sensor_Status_Headings}[${j}]       ${data_text}
        END
    append to list    ${list_To_Store}     ${dict}
    END
    log to console          ${list_To_Store}
    log    ${list_To_Store}
    [Return]    ${list_To_Store}

#=============================  END  =============================================================

Business_Unit_Selection
    ARCGIS_Variables_Read_from_Excel
    sleep    10
    wait until element is visible    ${Business_Unit_DD_Click_btn}    20s
    ${check_btn_element}=  Run Keyword and Return Status   wait until page contains element    ${Business_Unit_DD_Click_btn}    10s
    Run Keyword If      '${check_btn_element}' == 'True'     click element    ${Business_Unit_DD_Click_btn}
    WHILE    ${check_btn_element} != ${TRUE}
        Reload Page
        ${check_btn_element}=  Run Keyword And Return Status  Page Should Contain Element    ${Business_Unit_DD_Click_btn}
    END

    ${New_element}=     replace string    ${DD_Value_Selection}     value        ${Business_Unit_Input}
    ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${New_element}    10s
    Run Keyword If      '${check_element}' == 'True'     Select_from_Drop_Down_value     ${Business_Unit_Input}
    WHILE    ${check_element} != ${TRUE}
        Reload Page
        Wait For Condition  return document.readyState == "complete"
        sleep   3
        click element    ${Business_Unit_DD_Click_btn}
        sleep   3
        Select_from_Drop_Down_value     ${Business_Unit_Input}
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${Business_Unit_Input}    10s
    END


#=============================  END  =============================================================

Facility_Selection
    ARCGIS_Variables_Read_from_Excel
    wait until element is visible    ${Facility_DD_Click_btn}  10s
    click element    ${Facility_DD_Click_btn}
    Select_from_Drop_Down_value     ${Facility_Input}

#=============================  END  =============================================================

Gateway_Selection
    ARCGIS_Variables_Read_from_Excel
    wait until element is visible    ${Gateway_DD_Click_btn}  10s
    click element    ${Gateway_DD_Click_btn}
    Select_from_Drop_Down_value     ${Gateway_input}

#=============================  END  =============================================================

Get_Nimbus_Sensors_Counts_and_Values
    sleep    5
    ${NSCount}=    get text    ${NS_Online_Count}
    log     ${NSCount}
    ${GWCount}=     get text    ${GW_Online_Count}
    log     ${GWCount}
    ${Alarmed}=    get text    ${Alarmed_Count}
    log     ${Alarmed}
    log to console    Sensor_Count_Fetched
    ${list}=        Get_all_Values_From_Sensor_status
    [Return]    ${list}

#=============================  END  =============================================================

Fetch_Graph_Value
    [Arguments]    ${Graph_locator}
    sleep   10
    ${List_of_Values_Fetch_From_Graph}=      create list
    ${list_of_elements}=        get webelements     ${Graph_locator}
    ${Element_count}=    get element count    ${Graph_locator}
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    ${Graph_locator}\[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     get_Attribute_value_and_store      ${single_ele}       aria-label      ${List_of_Values_Fetch_From_Graph}
        #${get_Graph_Value}=     get element attribute    ${single_ele}      aria-label
        #log to console    ${get_Graph_Value}
        #append to list    ${list_of_Values}       ${get_Graph_Value}
    END
    log to console    ${List_of_Values_Fetch_From_Graph}
    log list    ${List_of_Values_Fetch_From_Graph}
    log to console    Fetch_Graph_Value_completed
    [Return]        ${List_of_Values_Fetch_From_Graph}

#=============================  END  =============================================================

Fetch_Graph_Value_From_Air_Quality_Methene_VDC
    sleep   10
    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_VDC}=      create list
    ${list_of_elements}=        get webelements     ${Graph_value_Fetch_AirQuality_Methene_VDC}
    ${Element_count}=    get element count    ${Graph_value_Fetch_AirQuality_Methene_VDC}
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    ${Graph_value_Fetch_AirQuality_MethenePPM}\[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     get_Attribute_value_and_store      ${single_ele}       aria-label      ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_VDC}
    END
    log to console    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_VDC}
    log list    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_VDC}
    log to console    Fetch_Graph_Value_From_Air_Quality_Methene_VDC_Completed
    [Return]        ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_VDC}

#=============================  END  =============================================================

Fetch_Graph_Value_From_Air_Quality_Methene_PPM
    sleep   10
    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_PPM}=      create list
    ${list_of_elements}=        get webelements     ${Graph_value_Fetch_AirQuality_MethenePPM}
    ${Element_count}=    get element count    ${Graph_value_Fetch_AirQuality_MethenePPM}
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    ${Graph_value_Fetch_AirQuality_MethenePPM}\[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     get_Attribute_value_and_store      ${single_ele}       aria-label      ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_PPM}
        #${get_Graph_Value}=     get element attribute    ${single_ele}      aria-label
        #log to console    ${get_Graph_Value}
        #append to list    ${list_of_Values}       ${get_Graph_Value}
    END
    log to console    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_PPM}
    log list    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_PPM}
    log to console    Fetch_Graph_Value_From_Air_Quality_Methene_PPM_completed
    [Return]        ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Methene_PPM}

#=============================  END  =============================================================

Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C
    sleep   10
    ${List_of_Values_Fetch_Graph_Value_From_Air_Quality_Ambient_Temp_C}=      create list
    ${list_of_elements}=        get webelements     ${Graph_Value_Fetch_AirQuality_Ambient_Temp_C}
    ${Element_count}=    get element count    ${Graph_Value_Fetch_AirQuality_Ambient_Temp_C}
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    ${Graph_Value_Fetch_AirQuality_Ambient_Temp_C}\[${list}]
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

#=============================  END  =============================================================

get_Attribute_value_and_store
    [Arguments]    ${Element}       ${Attribute_Name}       ${list_to_be_Store}
    ${get_Graph_Value}=     get element attribute    ${Element}      ${Attribute_Name}
    log to console    ${get_Graph_Value}
    append to list    ${list_to_be_Store}       ${get_Graph_Value}

#=============================  END  =============================================================

Validate_Sensors_Have_the_Selected_Gateway
    [Documentation]    This Keyword used to Validate Actual sensor value should contain Selected Gateway value
    [Arguments]         ${list_Of_Dictionary}        ${Value_Should_Contains}
    ${List_length}=     get length    ${list_Of_Dictionary}
    FOR    ${i}     IN RANGE     0      ${List_length}
            ${list_Value}=  get from list    ${list_Of_Dictionary}      ${i}
            ${Gateway_value}=       get from dictionary    ${list_Value}        Gateway
            ${Text_length}=     get length    ${Gateway_value}
            log to console    ${Gateway_value}
            Run Keyword If      '${Text_length}' != '0'      should contain    ${Gateway_value}      ${Gateway_input}

    END

#=============================  END  =============================================================

Validate_Sensors_Have_the_Selected_Facility
    [Documentation]    This Keyword used to Validate Actual sensor value should contain Selected Gateway value
    [Arguments]         ${list_Of_Dictionary}        ${Value_Should_Contains}
    ${List_length}=     get length    ${list_Of_Dictionary}
    FOR    ${i}     IN RANGE     0      ${List_length}
            ${list_Value}=  get from list    ${list_Of_Dictionary}      ${i}
            ${Facility_value}=       get from dictionary    ${list_Value}        Facility
            ${Text_length}=     get length    ${Facility_value}
            Run Keyword If      '${Text_length}' != '0'      should contain    ${Facility_value}      ${Value_Should_Contains}

    END

#=============================  END  =============================================================
Navigate_To_Scada_Tab
     wait until element is visible    ${Graph_Scada_btn}     10s
     click element    ${Graph_Scada_btn}

#=============================  END  =============================================================

Fetch_Scada_H2S_Graph_Value
    @{Scada_H2S_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Scada_H2S}

#=============================  END  =============================================================

Fetch_Scada_lEL_Graph_Value
    @{Scada_lEL_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Scada_LEL}

#=============================  END  =============================================================

Navigate_To_Power_Tab
     wait until element is visible    ${Graph_Power_btn}     10s
     click element    ${Graph_Power_btn}

#=============================  END  =============================================================

Select_Sensore_Value
    wait until element is visible    ${Sensor_status_values}
    click element    ${Sensor_status_values}

#=============================  END  =============================================================

Fetch_Power_Battery_VoltageVDC_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Battery_VoltageVDC}
    @{Power_Battery_VoltageVDC_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Battery_VoltageVDC}

#=============================  END  =============================================================

Fetch_Graph_Value_Fetch_Power_Battery_CurrentA_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Battery_CurrentA}
    @{Power_Battery_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Battery_CurrentA}

#=============================  END  =============================================================

Fetch_Power_Solar_VoltageVDC_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Solar_VoltageVDC}
    @{Power_Solar_VoltageVDC_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Solar_VoltageVDC}

#=============================  END  =============================================================

Fetch_Power_Solar_CurrentA_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Power_Solar_CurrentA}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Power_Solar_CurrentA}

#=============================  END  =============================================================

Navigate_To_Wind_Tab_Graph_Value
     wait until element is visible    ${Graph_Wind_btn}     10s
     click element    ${Graph_Wind_btn}

#=============================  END  =============================================================

Fetch_Wind_WindSpeed_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Wind_WindSpeed}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Wind_WindSpeed}

#=============================  END  =============================================================

Fetch_Wind_Direction_Graph_Value
    wait until element is visible    ${Graph_Value_Fetch_Wind_WindDirection}
    @{Power_Solar_CurrentA_Value}=     Fetch_Graph_Value       ${Graph_Value_Fetch_Wind_WindDirection}

#=============================  END  =============================================================
Validate_Online_Sensore_Count
    [Documentation]    This Keyword used Fetch NS online Count and compare with Sensore value online count
    [Arguments]         ${list_Of_Dictionary}
    sleep    5
    ${NSCount}=    get text    ${NS_Online_Count}
    log     Numbus_Sensor_Count_Is=${NSCount}
    ${List_length}=     get length    ${list_Of_Dictionary}
    ${Online_list}=     create list
    FOR    ${i}     IN RANGE     0      ${List_length}
            ${list_Value}=  get from list    ${list_Of_Dictionary}      ${i}
            ${Gateway_value}=       get from dictionary    ${list_Value}        online_status
            append to list    ${Online_list}        ${Gateway_value}
    END
    ${Actual_NS_online_Count}=      count values in list        ${Online_list}      Online
    should be equal as strings    ${NSCount}       ${Actual_NS_online_Count}

#=============================  END  =============================================================

Select_Bookmark_option
    wait until element is visible    ${Map_Bookmark_btn}
    click element    ${Map_Bookmark_btn}
    ${Bookmark_Option_locator}=      replace string    ${Map_Bookmark_List_Selection}   value       ${Bookmark_Select_option}
    wait until element is visible    ${Bookmark_Option_locator}
    click element    ${Bookmark_Option_locator}
    sleep    2
    click element    ${Bookmark_Option_locator}

#=============================  END  =============================================================

Validate_Data_Removed_After_Bookmark_selection
    [Documentation]    If we select any value in GIS Bookmark Sensore Value And Graph Data Should be removed as per Requirement
    wait until element is visible    ${sensor_status_no_data}   15s
    sleep    4
    ${Sensor_Status_Value}=     get text    ${sensor_status_no_data}
    should be equal         ${Sensor_Status_Value}      No data
    log to console    Sensor status validation completed

    wait until element is visible    ${Air_Quality_MethaneVDC_No_data_Text}   15s
    ${Air_Quality_Methane_VDC}=     get text    ${Air_Quality_MethaneVDC_No_data_Text}
    ${Air_Quality_Methane_PPM}=     get text    ${Air_Quality_MethanePPM_No_data_Text}
    ${Air_Quality_Ambient_Temp}=     get text    ${Air_Quality_Ambient_TempC_No_data_Text}
    #==================Air quality Validations start=======================================================
    should be equal         ${Air_Quality_Methane_VDC}      No data
    should be equal         ${Air_Quality_Methane_PPM}      No data
    should be equal         ${Air_Quality_Ambient_Temp}      No data
    log to console    Air quality validation completed
    #==================Air quality Validations End =======================================================
    sleep   2
    wait until element is visible    ${Graph_Wind_btn}  15s
    click element    ${Graph_Wind_btn}
    wait until element is visible    ${wind_windspeed_no_data_text}   15s
    ${wind_Speed}=     get text    ${wind_windspeed_no_data_text}
    ${Wind_Direction}=     get text    ${wind_winddirection_no_data_text}
    #==================Power Validations start=======================================================
    should be equal         ${wind_Speed}      No data
    should be equal         ${Wind_Direction}      No data
    log to console    Wind validation completed
    #==================Power Validations End =======================================================
    sleep    2
    wait until element is visible    ${Graph_Scada_btn}     15s
    click element    ${Graph_Scada_btn}
    wait until element is visible    ${scada_h2s_no_data_text}     15s
    ${Scada_H2S}=     get text    ${scada_h2s_no_data_text}
    ${Scada_LEL}=     get text    ${scada_lel_no_data_text}
    #==================Scada Validations start=======================================================
    should be equal         ${Scada_H2S}      No data
    should be equal         ${Scada_LEL}      No data
    log to console    Scada validation completed
    #==================Scada Validations End =======================================================

#=============================  END  =============================================================

Select_Default_Bookmark_option_And_Validate
    wait until element is visible    ${Map_Bookmark_default_map_Extent_btn}
    click element    ${Map_Bookmark_default_map_Extent_btn}
    sleep    5

#=============================  END  =============================================================

ARCGIS_Variables_Read_from_Excel
    [Documentation]    This Function used to get cell value from Excel file
    #variable                    Methods name                 Excel File name     Sheet name  Row     Column
    ${BROWSER}=                   Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    2       2
    ${GIS_URL}=                   Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    3       2
    ${GPS_URL}=                   Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    4       2
    ${UserName}=                  Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    5       2
    ${Password}=                  Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    6       2
    ${Business_Unit_Input}=       Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    7       2
    ${Facility_Input}=            Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    8       2
    ${Gateway_input}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    9       2
    ${Device_Input}=              Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    10      2
    ${Bookmark_Select_option}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    Arc_GIS    11      2

    #Set All variable as Global to access all Testcases
     set global variable    ${BROWSER}
     set global variable    ${GIS_URL}
     set global variable    ${GPS_URL}
     set global variable    ${UserName}
     set global variable    ${Password}
     set global variable    ${Business_Unit_Input}
     set global variable    ${Facility_Input}
     set global variable    ${Gateway_input}
     set global variable    ${Device_Input}
     set global variable    ${Bookmark_Select_option}
