*** Settings ***
Library     DatabaseLibrary
Library     OperatingSystem
Library    DataDriver       ../../TestData/Database.xlsx     sheet_name=Sheet1


*** Variables ***

${DB_Server_Name}
${DBuser_Name}
${DB_password}
${DB_name}

*** Test Cases ***

Database_value_Fetch
    log to console    ${db_server_name}
    log to console    ${dbuser_name}
    log to console    ${db_password}
    log to console    ${db_name}

*** Keywords ***




