*** Settings ***
Library     DatabaseLibrary
Library     OperatingSystem
Library     DataDriver       ../../../TestData/Database.xlsx

#Suite Setup    Connect To Database  pysnowflake     ${DB_Name}  ${DB_User_Name} ${DB_Password} ${DB_Host}  ${DB_Port}
#Suite Teardown    Disconnect From Database

Test Template    Fetch Data From Excel

*** Variables ***

${DB_Name}
${DB_User_Name}
${DB_Password}
${DB_Host}
${DB_Port}

*** Test Cases ***

Database_value_Fetch
    fetch data from excel    ${DB_Name}  ${DB_User_Name}    ${DB_Password}  ${DB_Host}  ${DB_Port}
    #log to console    ${DB_Name}
    #log to console    ${DB_User_Name}
    #log to console    ${DB_Password}
    #log to console    ${DB_Host}
    #log to console    ${DB_Port}

*** Keywords ***

Fetch Data From Excel
    [Arguments]     ${DB_Name}  ${DB_User_Name}    ${DB_Password}  ${DB_Host}  ${DB_Port}
    log to console    ${DB_Name}
    log to console    ${DB_User_Name}
    log to console    ${DB_Password}
    log to console    ${DB_Host}
    log to console    ${DB_Port}