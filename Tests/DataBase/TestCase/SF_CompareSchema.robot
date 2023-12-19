*** Settings ***
Library     SnowflakeLibrary

*** Variables ***
${SnowFlake_User}   snowflake_username
${SnowFlake_Password}   snowflake_password
${SnowFlake_Account}   snowflake_account
${SnowFlake_Warehouse}   snowflake_warehouse
${SnowFlake_DataBase}   snowflake_database
${SnowFlake_Schema_1}   schema_1
${SnowFlake_Schema_2}   schema_2

*** Test Cases ***
Compare Schema
    Connect To Snowflake    account=${snowflake_account}    user=${snowflake_user}   password=${snowflake_password}   warehouse=${snowflake_warehouse}  database=${snowflake_database}
    ${table_1}=     Query   SELECT  TABLE_NAME  FROM    INFORMATION_SCHEMA.TABLES   WHERE   TABLE_SCHEMA = '${SnowFlake_Schema_1}'
    ${table_2}=     Query   SELECT  TABLE_NAME  FROM    INFORMATION_SCHEMA.TABLES   WHERE   TABLE_SCHEMA = '${SnowFlake_Schema_2}'
    Compare Table Lists     ${table_1}  ${table_2}

*** Keywords ***
Compare Table Lists
    [Arguments]     ${list_1}   ${list_2}
    Log    "Tables in schema 1: ${list_1}"
    Log    "Tables in schema 2: ${list_2}"
    Lists Should Be Equal   ${list_1}   ${list_2}