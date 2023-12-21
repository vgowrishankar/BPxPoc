*** Settings ***
Documentation   Login to Data Portal
Library         SeleniumLibrary
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot
Variables       ../../../Resources/Portal/PageObject/DataPortal_LogIn.py

Test Template    Test Template

*** Test Cases ***
Sign In Data Portal Page
    Data Portal MFA Login
    Get Data Portal URL
    Close Browser Data Portal

*** Keywords ***
Test Template
    Data Portal MFA Login
    Get Data Portal URL
    Close Browser Data Portal