*** Settings ***
Library         SeleniumLibrary
Library         DataDriver     ../../../TestData/DataOneMap.xls     sheet_name=ArcGIS_User
Variables       ../PageObject/ArcGIS_Login.py
Resource        ArcGIS_LogIn.robot
Library         String
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library          JSONLibrary
Variables       ../PageObject/ArcGPS.py
Resource        ../../../Utilities/Read_data_from_excel_file.robot


*** Variables ***
${Source_Input}=    LAVERNE 58-T2-12X1 3B B302H
${Destination_Input}=       HS STATE 113-22X15 1H


*** Keywords ***
Navigate_Directions_between_places
    [Arguments]    ${Source}        ${Destination}
    wait until element is visible    ${Arc_GPS_Directions_btn}     20s
    sleep    5
    click element   ${Arc_GPS_Directions_btn}
    sleep    3
    wait until element is visible    ${Arc_GPS_Direction_Source_Input}      20s
    input text    ${Arc_GPS_Direction_Source_Input}     ${Source}
    wait until element is visible    ${Arc_GPS_Direction_Destination_Input}     20s
    input text    ${Arc_GPS_Direction_Destination_Input}        ${Destination}
    wait until element is visible    ${Arc_GPS_Direction_GetDirection_btn}    20s
    click element    ${Arc_GPS_Direction_GetDirection_btn}

Fetch_Duration_Value
    wait until element is visible    ${Arc_GPS_Direction_Hour_Minut_Value}     20s
    sleep    3
    ${Duration}=        get text    ${Arc_GPS_Direction_Hour_Minut_Value}

    [Return]    ${Duration}


Fetch_Navigation_Values
   ${Duration}      Fetch_Duration_Value
   ${list_of_Value}=       create list
    append to list    ${list_of_Value}  ${Duration}

    wait until element is visible    ${Arc_GPS_Direction_Table_rows_Count}      20s
    sleep    5
    ${Total_rr}   GET ELEMENT COUNT     ${Arc_GPS_Direction_Table_rows_Count}
    LOG TO CONSOLE    Total_Row_Count_is=${Total_rr}
    ${Total_data}   GET ELEMENT COUNT     ${Arc_GPS_Direction_Table_data_Count}
    LOG TO CONSOLE    Total_Data_Count_is=${Total_data}

    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
        ${rowindex}=    convert to string    ${i}
        FOR    ${j}    IN RANGE     1       ${Total_data}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Arc_GPS_Direction_Table_Data}       Row_index       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       data_index       ${dataindex}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT     ${Text_element}
        log to console    ${data_text}
        append to list    ${list_of_value}     ${data_text}
        END

    END
    log to console          ${list_of_value}
    log list    ${list_of_value}
    [Return]    ${list_of_value}


ARCGPS_Variables_Read_from_Excel
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