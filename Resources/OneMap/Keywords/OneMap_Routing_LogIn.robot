*** Settings ***
Documentation   Login to GPS One Map BPX Routing
Library         SeleniumLibrary
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_LogIn.robot
Variables       ../../../Resources/OneMap/PageObject/ArcGIS_LogIn.py

Test Template    Test Template

*** Test Cases ***
One Map BPX Routing Login
    One Map GPS Login
    Get One Map URL
    Close Browser One Map

*** Keywords ***
Test Template
    One Map GPS Login
    Get One Map URL
    Close Browser One Map