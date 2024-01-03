*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Library    Collections

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi/
${USERNAME}        gowrishankar.venkatesan@bpx.com
${PASSWORD}        Lakshita#123

*** Keywords ***
Test with Basic Authentication and Ignoring SSL
    [Documentation]    Test API with Basic Authentication and Ignoring SSL
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=false
    ${response}=    Get On Session    MySession    ${BASE_URL}
    #log to console   ${response.status_code}
    #log to console   ${response.content}
    #log to console   ${response.headers}


Validation of Status Code
    [Documentation]    Validation of Status Code
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=false
    ${response}=    Get On Session    MySession    ${BASE_URL}
    ${status_code}=     convert to string    ${response.status_code}
    should be equal    ${response.status_code}      200

Validation of Json output
    [Documentation]    Validation of Status Code
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}   auth=${auth}   verify=false
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}
    ${Json_Response}=   Set variable    ${Get_Response.json()}
    #${Json_Response}=   To Json    ${Get_Response}
    #log to console      ${Json_Response}
    @{DataServers}=     get value from json    ${json_response}     Links.DataServers
    log to console      ${DataServers}
    #${D_Server}=        get from list       @{DataServers}      0

