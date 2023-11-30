*** Settings ***
Library      SeleniumLibrary
Resource     ../Resources/login_resources.robot
Library      DataDriver      ../TestData/UserTable.xls
Library     DemoLibrary.py

Suite Setup     Open Browser
Suite Teardown    Close Browser
Test Template    Invalid Login

*** Variables ***
${Environment}


*** Test Cases ***
LoginTestwithExcel using ${UserName} and ${Password}


*** Keywords ***
Invalid Login
    [Arguments]    ${UserName}     ${Password}
    Input UserName    ${UserName}
    Input Password    ${Password}
    Click login button
    Error message should be visible
