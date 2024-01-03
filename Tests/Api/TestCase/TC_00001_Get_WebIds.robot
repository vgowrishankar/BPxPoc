*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_Get_WebIds.robot

*** Variables ***
${Endpoint}        F1DS-YXaeg5A-0upYI5AbwSKXwQ09SUFBSRFBJREE/points


*** Test Cases ***
Check for the status code
    Check for the status code

Get the value of All Web ID from the Items
    Get the value of All Web ID from the Items
