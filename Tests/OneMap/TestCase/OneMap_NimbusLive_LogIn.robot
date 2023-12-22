*** Settings ***
Documentation   Login to GPS One Map Nimbus Live Mid Stream
Library         SeleniumLibrary
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_Login.robot
Variables       ../../../Resources/OneMap/PageObject/ArcGIS_LogIn.py

Test Template    Test Template

*** Test Cases ***
One Map NimbusLive Login
    One Map GIS Login
    Get One Map URL
    Close Browser One Map

*** Keywords ***
Test Template
    One Map GIS Login
    Get One Map URL
    Close Browser One Map