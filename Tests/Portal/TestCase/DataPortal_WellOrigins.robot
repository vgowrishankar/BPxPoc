*** Settings ***
Documentation   Sign in to Data Portal and Do Operations
Library         SeleniumLibrary
Library        ../../../Resources/Portal/PageObject/DataPortal_WellOrigins.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_SignIn.robot

Suite Setup     Open Browser Data Portal
Suite Teardown    Close Browser Data Portal
Test Template    Do Login

*** Variables ***

*** Test Cases ***
Sign In Data Portal Page using ${UserName} and ${Password}

*** Keywords ***
Do Login
    [Arguments]    ${UserName}     ${Password}
    Input UserName    ${UserName}
    Input Password    ${Password}
    Click Sign in button
