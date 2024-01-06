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
${Gateway_input}=        ngw-perm-ms-001




*** Test Cases ***
Validate_if_MidStream_Dashboard_is_loading
    One Map GIS Login
    Business_Unit_Selection
    Facility_Selection
    Gateway_Selection






*** Keywords ***





