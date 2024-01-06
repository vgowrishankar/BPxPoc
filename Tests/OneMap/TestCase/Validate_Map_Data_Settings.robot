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
${Bookmark_Select_option}=      BHC - BlackHawk Central
${Gateway_input}=        ngw-perm-ms-001
${Facility_Input}=      GRAND SLAM CDP

*** Test Cases ***
Sample
    One Map GIS Login
    Business_Unit_Selection
    Facility_Selection
    Gateway_Selection
    Select_Bookmark_option
    Validate_Data_Removed_After_Bookmark_selection
    Select_Default_Bookmark_option_And_Validate
    ${List_Of_Sensor_Value}=    Get_Nimbus_Sensors_Counts_and_Values
    #Validate_Sensors_Have_the_Selected_Gateway      ${List_Of_Sensor_Value}     ${Gateway_input}
    Validate_Sensors_Have_the_Selected_Facility     ${List_Of_Sensor_Value}     ${Facility_Input}

*** Keywords ***
Select_Bookmark_option
    wait until element is visible    ${Map_Bookmark_btn}
    click element    ${Map_Bookmark_btn}
    ${Bookmark_Option_locator}=      replace string    ${Map_Bookmark_List_Selection}   value       ${Bookmark_Select_option}
    wait until element is visible    ${Bookmark_Option_locator}
    click element    ${Bookmark_Option_locator}
    sleep    2
    click element    ${Bookmark_Option_locator}


Validate_Data_Removed_After_Bookmark_selection
    wait until element is visible    ${sensor_status_no_data}   15s
    sleep    4
    ${Sensor_Status_Value}=     get text    ${sensor_status_no_data}
    should be equal         ${Sensor_Status_Value}      No data
    log to console    Sensor status validation completed

    wait until element is visible    ${Air_Quality_MethaneVDC_No_data_Text}   15s
    ${Air_Quality_Methane_VDC}=     get text    ${Air_Quality_MethaneVDC_No_data_Text}
    ${Air_Quality_Methane_PPM}=     get text    ${Air_Quality_MethanePPM_No_data_Text}
    ${Air_Quality_Ambient_Temp}=     get text    ${Air_Quality_Ambient_TempC_No_data_Text}
    should be equal         ${Air_Quality_Methane_VDC}      No data
    should be equal         ${Air_Quality_Methane_PPM}      No data
    should be equal         ${Air_Quality_Ambient_Temp}      No data
    log to console    Air quality validation completed

    sleep   2

    wait until element is visible    ${Graph_Wind_btn}  15s
    click element    ${Graph_Wind_btn}
    wait until element is visible    ${wind_windspeed_no_data_text}   15s
    ${wind_Speed}=     get text    ${wind_windspeed_no_data_text}
    ${Wind_Direction}=     get text    ${wind_winddirection_no_data_text}
    should be equal         ${wind_Speed}      No data
    should be equal         ${Wind_Direction}      No data
    log to console    Wind validation completed

    sleep    2
    wait until element is visible    ${Graph_Scada_btn}     15s
    click element    ${Graph_Scada_btn}
    wait until element is visible    ${scada_h2s_no_data_text}     15s
    ${Scada_H2S}=     get text    ${scada_h2s_no_data_text}
    ${Scada_LEL}=     get text    ${scada_lel_no_data_text}
    should be equal         ${Scada_H2S}      No data
    should be equal         ${Scada_LEL}      No data
    log to console    Scada validation completed

Select_Default_Bookmark_option_And_Validate
    wait until element is visible    ${Map_Bookmark_default_map_Extent_btn}
    click element    ${Map_Bookmark_default_map_Extent_btn}
    sleep    5





