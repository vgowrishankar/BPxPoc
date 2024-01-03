*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library    String

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi/assetservers
${USERNAME}        gowrishankar.venkatesan@bpx.com
${PASSWORD}        Lakshita#123
${Endpoint}        F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ/assetdatabases

*** Keywords ***
Test with Basic Authentication and Ignoring SSL
    [Documentation]    Test API with Basic Authentication and Ignoring SSL
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}   verify=false
    ${response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    log to console   ${response.content}

Json Evaluator Keyword Items
    [Documentation]     Extraction of WebId from Assest Server F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    ${parsed_json}=  Evaluate  json.loads($Get_Response.content)

    ${Value}=   Set Variable    ${parsed_json["Items"]}
    log to console  \n the Items is ${Value}

Json Evaluator to obtain Items Keyword
    [Documentation]     Extraction of Items from Assest Server F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    ${parsed_json}=  Evaluate  json.loads($Get_Response.content)

    ${Value}=   Set Variable    ${parsed_json["Items"]}
    log to console  \n the Keyword Items is ${Value}


Json Evaluator to obtain Specific WebId Tag
    [Documentation]     Extraction of WebId from Assest Server F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    ${parsed_json}=  Evaluate  json.loads($Get_Response.content)

    ${Value}=   Set Variable    ${parsed_json['Items'][0]['WebId']}
    log to console  \n the WebId Tag for [0] is ${Value}


Json Evaluator to obtain WebId,Id,Name,Description Tags
    [Documentation]     Extraction of WebId from Assest Server F1RSXzTKUGzUE0OXq5PG4XR-gAQUYuUEkuSU5UUkFORVQuQlBYLkNPTQ
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)

    ${json_WebId}=   get value from json    ${parsed_json}  $.Items[0].WebId
    ${json_id}=   get value from json    ${parsed_json}  $.Items[0].Id
    ${json_Name}=   get value from json    ${parsed_json}  $.Items[0].Name
    ${json_Description}=   get value from json    ${parsed_json}  $.Items[0].Description

    log to console  \n List All the WebId Tag is ${json_WebId}
    log to console  \n List All the Id Tag is ${json_id}
    log to console  \n List All the Name Tag is ${json_Name}
    log to console  \n List All the Description Tag is ${json_Description}
