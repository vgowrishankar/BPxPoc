*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi/streams
${USERNAME}        SVC-AUTOFRAMEWORK-TE
${PASSWORD}        xGP&X8L6M2#9(f^$
${Endpoint}        F1DP-YXaeg5A-0upYI5AbwSKXw7YomAAQ09SUFBSRFBJREFcJUBCVSBJRCUuVUlTMDE6QU5MOlhNMDIxOV9GQUMwMV9NV1NQMDFfUVRMSVFIUg/value

*** Keywords ***
Test to Obtain Timestamp Value, Name and IsSystem of Single WebId
    [Documentation]     Get Timestamp Value, Name and IsSystem of each WebId Points in F1DS-YXaeg5A-0upYI5AbwSKXwQ09SUFBSRFBJREE
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/${Endpoint}   auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/${Endpoint}
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)

    ${json_Timestamp}=   get value from json    ${parsed_json}  $.Timestamp
    ${json_Value}=   get value from json    ${parsed_json}  $.Value.Value
    ${json_Name}=   get value from json    ${parsed_json}  $.Value.Name
    ${json_IsSystem}=   get value from json    ${parsed_json}  $.Value.IsSystem

    log to console  Timestamp : ${json_Timestamp}
    log to console  Value : ${json_Value}
    log to console  Name : ${json_Name}
    log to console  IsSystem : ${json_IsSystem}
