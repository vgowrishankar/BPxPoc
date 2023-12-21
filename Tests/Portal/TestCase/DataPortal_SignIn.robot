*** Settings ***
Documentation   Sign in to Data Portal
Library         SeleniumLibrary
Resource        ../../../Resources/Portal/Keywords/DataPortal_SignIn.robot
Variables       ../../../Resources/Portal/PageObject/DataPortal_SignIn.py

Suite Setup     Data Portal MFA Login
Suite Teardown    Close Browser Data Portal
Test Template    Do Login

*** Variables ***

*** Test Cases ***
Sign In Data Portal Page
    Data Portal MFA Login

*** Keywords ***
Do Login
    Wait For Condition    return document.readyState == "complete"