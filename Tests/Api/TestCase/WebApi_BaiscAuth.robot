*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_BasicAuth.robot

*** Variables ***
${ENDPOINT}        /F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ

*** Test Cases ***
Test Web API Basic Authentication and Ignoring SSL
    Test with Basic Authentication and Ignoring SSL

Test Web API Validate Json Output DataServer
    Validation of Json output