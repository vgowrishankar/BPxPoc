*** Settings ***
Documentation   Login in to OneMap Portal and Do Operations
Library         SeleniumLibrary
Library        ../../../Resources/OneMap/PageObject/OneMap_NimbusLive_MidStream.py
Resource        ../../../Resources/OneMap/Keywords/ArcGIS_Login.robot

Suite Setup     Open Browser OneMap Portal
Suite Teardown    Close Browser OneMap Portal
Test Template    Do Login

*** Variables ***

*** Test Cases ***
Sign In OneMap Portal Page using ${UserName} and ${Password}

*** Keywords ***
Do Login
    [Arguments]    ${UserName}     ${Password}
    Input UserName    ${UserName}
    Input Password    ${Password}
    Click Sign in button
