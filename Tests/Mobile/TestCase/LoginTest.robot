*** Settings ***
Resource         ../../../Resources/Mobile/Keywords/Common.robot



*** Test Cases ***
Verify That A User Can Login To The Application Using Valid Credentials
    [Tags]    Smoke
    Open Android Application
    Select_ArcGIS_Enterprise_Option
    Login_Arc_GIS_With_Valid_credentials
    Enable_Location_option
    Select_Premian_From_list_And_download
    Select_Route_From_List




