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
${Facility_Input}=      BINGO CDP
${Gateway_input}=       ngw-perm-ms-008
@{list_of_Values}

*** Test Cases ***
Validate_ArcGIS_Values
    One Map GIS Login
    Business_Unit_Selection
    Facility_Selection
    Gateway_Selection
    Fetch_Graph_Value_From_Air_Quality


*** Keywords ***

Select_from_Drop_Down_value
    [Arguments]    ${Selection_Value}
    ${New_element}=     replace string    ${DD_Value_Selection}     value        ${Selection_Value}
    wait until element is visible     ${New_element}    10s
    click element     ${New_element}


Get_all_Values_From_Sensor_status

    ${Total_set}   get element count     xpath=//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html']

    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_data_Per_set}   GET ELEMENT COUNT     (//div[@class='widget-body flex-fluid full-width flex-vertical overflow-y-auto overflow-x-hidden']//div[@class='external-html'])[1]/p
    LOG TO CONSOLE    Totaldatacountis=${Total_data_Per_set}
    ${list_To_Store}=   create list
    FOR    ${i}    IN RANGE     1       ${Total_set}+1
    LOG TO CONSOLE    1stloop started
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${Total_data_Per_set}+1
        #LOG TO CONSOLE    2ndloop started
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

Get_Nimbus_Sensors_Counts_Values
    sleep    5
    ${NSCount}=    get text    ${NS_Online_Count}
    log to console    ${NSCount}
    ${GWCount}=     get text    ${GW_Online_Count}
    log to console    ${GWCount}
    ${Alarmed}=    get text    ${Alarmed_Count}
    log to console    ${Alarmed}
    ${list}=        Get_all_Values_From_Sensor_status


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

Fetch_Graph_Value_From_Air_Quality
    sleep   10
    ${list_of_elements}=        get webelements     (//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle']
    ${Element_count}=    get element count    (//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle']
    log to console    Total_graph_Pin_count_is=${Element_count}
    FOR  ${list}    IN RANGE    1      ${Element_count}+1
        #sleep    3
        ${single_ele}=  get webelement    xpath=((//*[local-name()='svg']//*[name()='g' and contains(@class,'amcharts-graph-line amcharts-graph-graphAuto0_170')])[2]//*[name()='circle'])[${list}]
        ${check_element}=  Run Keyword and Return Status   wait until page contains element    ${single_ele}    10s
        Run Keyword If      '${check_element}' == 'True'     get_Attribute_value_and_store      ${single_ele}       aria-label
        #${get_Graph_Value}=     get element attribute    ${single_ele}      aria-label
        #log to console    ${get_Graph_Value}
        #append to list    ${list_of_Values}       ${get_Graph_Value}
    END
    log to console    ${list_of_Values}
    log list    ${list_of_Values}
    log to console    Graphical_completed

get_Attribute_value_and_store
    [Arguments]    ${Element}       ${Attribute_Name}
    ${get_Graph_Value}=     get element attribute    ${Element}      ${Attribute_Name}
    log to console    ${get_Graph_Value}
    append to list    ${list_of_Values}       ${get_Graph_Value}
