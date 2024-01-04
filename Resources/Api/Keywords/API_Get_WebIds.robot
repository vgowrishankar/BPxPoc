*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections
Library           String
Library           OperatingSystem

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi
${USERNAME}        SVC-AUTOFRAMEWORK-TE
${PASSWORD}        xGP&X8L6M2#9(f^$
${Endpoint}        F1DS-YXaeg5A-0upYI5AbwSKXwQ09SUFBSRFBJREE/points

*** Keywords ***

Check for the status code
    [Documentation]     Check for the status code
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=true
    ${Get_Response}=    Get On Session    MySession    /dataservers/${Endpoint}
    ${response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    should be equal as integers    ${response.status_code}      200

Get the value of First Web ID from the Items
    [Documentation]     Get the value of First Web ID from the Items
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=true
    ${Get_Response}=    Get On Session    MySession    /dataservers/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)

    ${json_WebId}=   get value from json    ${parsed_json}  $.Items[0].WebId
    log to console  WebId : ${json_WebId}


Get the value of All Web ID from the Items
    [Documentation]     Get the value of All Web ID from the Items
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=true
    ${Get_Response}=    Get On Session    MySession    /dataservers/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)
    ${json_WebId}=   get value from json    ${parsed_json}  $..WebId
    @{LisOfWebId} =  Convert To List         ${json_WebId}
    FOR     ${WebIds}     IN      @{LisOfWebId}
        Log To Console   ${WebIds}
    END

Extract the value of All Web ID from the Items
    [Documentation]     Get the value of All Web ID from the Items
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=true
    ${Get_Response}=    Get On Session    MySession    /dataservers/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)
    ${json_WebId}=   get value from json    ${parsed_json}  $..WebId
    ${json_Name}=   get value from json    ${parsed_json}  $..Name
    @{LisOfWebId} =  Convert To List         ${json_WebId}
    @{LisOfName} =  Convert To List         ${json_Name}
    FOR     ${WebIds}     IN      @{LisOfWebId}

        ${value_response}=    Get On Session    MySession    /streams/${WebIds}/value
        ${parsed_json}=  Evaluate    json.loads($value_response.content)
        ${json_Timestamp}=   get value from json    ${parsed_json}  $..Timestamp
        ${json_Value_Name}=   get value from json    ${parsed_json}  $..Value.Name
        ${json_Value_Value}=   get value from json    ${parsed_json}  $..Value.Value
            Log To Console   ${WebIds}
            Log To Console   ${json_Value_Name}
            Log To Console   ${value_response.status_code}
            Log To Console   ${json_Timestamp}
            Log To Console   ${json_Value_Value}
    END