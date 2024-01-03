*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_AssetServers.robot

*** Variables ***
${ENDPOINT}        /F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ/assetdatabases

*** Test Cases ***
Test Web API Get Points
    Test with Basic Authentication and Ignoring SSL

Test Web API Validate Json Output AssetServer Keyword Items
    Json Evaluator to obtain Items Keyword

Test Web API Validate Json Output AssetServer Specific WebId Tag
    Json Evaluator to obtain Specific WebId Tag

Test Web API Validate Json Output AssetServer WebId,Id,Name,Description Tags
    Json Evaluator to obtain WebId,Id,Name,Description Tags