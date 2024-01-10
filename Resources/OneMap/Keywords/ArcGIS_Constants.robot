*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../PageObject/ArcGIS_Login.py
Resource        ArcGIS_LogIn.robot
Library         SeleniumLibrary
Library         String
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary



*** Variables ***
@{Sensor_Status_Headings}=        ${EMPTY}    Gateway       Facility        online_status       last_online_status      Last_Alarm_status
${Business_Unit_Input}=     Permian
${Facility_Input}=      GRAND SLAM CDP
${Gateway_input}=       ngw-perm-ms-001
@{list_of_Values}




*** Keywords ***
Select_from_Drop_Down_value
    [Arguments]    ${Selection_Value}
    ${New_element}=     replace string    ${DD_Value_Selection}     value        ${Selection_Value}
    wait until element is visible     ${New_element}    10s
    click element     ${New_element}


Get_all_Values_From_Sensor_status
    ${Total_set}   get element count     xpath=//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html']
    LOG TO CONSOLE    Total_data_count_is=${Total_set}

    ${Total_data_Per_set}   GET ELEMENT COUNT     (//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html'])[1]/p
    LOG TO CONSOLE    Total_data_set_is=${Total_data_Per_set}
    ${list_To_Store}=   create list
    FOR    ${i}    IN RANGE     1       ${Total_set}+1

        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${Total_data_Per_set}+1

        ${locatores}=   get webelement    xpath=((//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html'])[${i}]/p)[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=((//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html'])[${i}]/p)[${j}]

        set to dictionary    ${dict}        ${Sensor_Status_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_To_Store}     ${dict}
    END
    log to console          ${list_To_Store}
    log    ${list_To_Store}
    [Return]    ${list_To_Store}

Business_Unit_Selection
    sleep    10
    wait until element is visible    ${Business_Unit_DD_Click_btn}  10s
    click element    ${Business_Unit_DD_Click_btn}
    sleep    3
    Select_from_Drop_Down_value     ${Business_Unit_Input}

Facility_Selection
    wait until element is visible    ${Facility_DD_Click_btn}  10s
    click element    ${Facility_DD_Click_btn}
    Select_from_Drop_Down_value     ${Facility_Input}

Gateway_Selection
    wait until element is visible    ${Gateway_DD_Click_btn}  10s
    click element    ${Gateway_DD_Click_btn}
    Select_from_Drop_Down_value     ${Gateway_input}

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



Graphical
    sleep   10
    ${list_of_elements}=        get webelements     (//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle']
    ${Element_count}=    get element count    (//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle']
    log to console    Total_file_countis=${Element_count}
    ${count}=    set variable    1
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        sleep    3
        ${single_ele}=  get webelement    xpath=((//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle'])[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     mouse over     ${single_ele}
        ${get_Graph_Value}=     get element attribute    ${single_ele}      aria-label
        log to console    ${get_Graph_Value}
        ${count}=   evaluate    ${count}+1
        append to list    ${list_of_Values}       ${get_Graph_Value}
    END
    log    ${count}
    log to console    ${list_of_Values}
    log to console    Graphical_completed

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


get_Attribute_value_and_store
    [Arguments]    ${Element}       ${Attribute_Name}       ${list_to_be_Store}
    ${get_Graph_Value}=     get element attribute    ${Element}      ${Attribute_Name}
    log to console    ${get_Graph_Value}
    append to list    ${list_to_be_Store}       ${get_Graph_Value}

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
           # should contain    ${Gateway_value}      ${Gateway_input}
    END

Validate_Sensors_Have_the_Selected_Facility
    [Documentation]    This Keyword used to Validate Actual sensor value should contain Selected Gateway value
    [Arguments]         ${list_Of_Dictionary}        ${Value_Should_Contains}
    ${List_length}=     get length    ${list_Of_Dictionary}
    FOR    ${i}     IN RANGE     0      ${List_length}
            ${list_Value}=  get from list    ${list_Of_Dictionary}      ${i}
            ${Facility_value}=       get from dictionary    ${list_Value}        Facility
            ${Text_length}=     get length    ${Facility_value}
            log to console    ${Facility_value}
            Run Keyword If      '${Text_length}' != '0'      should contain    ${Facility_value}      ${Value_Should_Contains}
           # should contain    ${Gateway_value}      ${Gateway_input}
    END

ARCGIS_Variables_Read_from_Excel
    [Documentation]    This Function used to get cell value from Excel file
    #variable      Methods name                 Excel File name        Sheet name      Row     Column
    ${BROWSER}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    OneMapRouting    2       2
    ${GIS_URL}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    OneMapRouting    3       2
    ${GPS_URL}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    OneMapRouting    4       2
    ${UserName}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    OneMapRouting    5       2
    ${Password}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    OneMapRouting    6       2

    #Set All variable as Global to access all Testcases
     set global variable    ${BROWSER}
     set global variable    ${GIS_URL}
     set global variable    ${GPS_URL}
     set global variable    ${UserName}
     set global variable    ${Password}