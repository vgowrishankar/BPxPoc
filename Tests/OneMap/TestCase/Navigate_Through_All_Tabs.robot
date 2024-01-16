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





