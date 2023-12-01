*** Settings ***
Library      SeleniumLibrary
Resource     ../../Resources/login_resources.robot
Library      DataDriver     ../../TestData/UserTable.xls

Suite Setup     Open Browser Facebook
Suite Teardown    Close Browser Facebook
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