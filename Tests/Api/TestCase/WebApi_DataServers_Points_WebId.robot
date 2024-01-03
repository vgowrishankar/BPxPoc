*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_DataServers_Points_WebId.robot

*** Variables ***

*** Test Cases ***
Test Single API response
    Test to Obtain Timestamp Value, Name and IsSystem of Single WebId
