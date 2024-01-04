*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_Get_WebIds.robot

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi

*** Test Cases ***
Check if PI value is Valid
    Extract the value of All Web ID from the Items
