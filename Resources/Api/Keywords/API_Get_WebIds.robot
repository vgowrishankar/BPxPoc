*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi
${USERNAME}        SVC-AUTOFRAMEWORK-TE
${PASSWORD}        xGP&X8L6M2#9(f^$
${Endpoint}        F1DS-YXaeg5A-0upYI5AbwSKXwQ09SUFBSRFBJREE/points

*** Keywords ***
Check for the status code
    [Documentation]     Check for the status code
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/dataservers/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    ${response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    should be equal as integers    ${response.status_code}      200

Get the value of First Web ID from the Items
    [Documentation]     Get the value of First Web ID from the Items
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/dataservers/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)

    ${json_WebId}=   get value from json    ${parsed_json}  $.Items[0].WebId
    log to console  WebId : ${json_WebId}


Get the value of All Web ID from the Items
    [Documentation]     Get the value of All Web ID from the Items
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/dataservers/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)
    ${json_WebId}=   get value from json    ${parsed_json}  $..WebId
    @{LisOfWebId} =  Convert To List         ${json_WebId}
    FOR     ${WebIds}     IN      @{LisOfWebId}
        Log To Console   ${WebIds}
    END