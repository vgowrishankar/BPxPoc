*** Settings ***
Library     RequestsLibrary
Library     Collections
Resource    ../../../Resources/Api/Keywords/API_Get_WebIds.robot

*** Variables ***
${BASE_URL}        https://corpprdpiapi01a.ad.bpx.com/piwebapi

*** Test Cases ***
Check if PI value is Valid
    [Documentation]     Check if PI value is Valid
    ${auth}=    create list    ${USERNAME}  ${PASSWORD}
    Create Session    MySession    ${BASE_URL}/dataservers/${Endpoint}      auth=${auth}
    ${Get_Response}=    Get On Session    MySession    ${BASE_URL}/dataservers/${Endpoint}
    should be equal as integers    ${Get_Response.status_code}      200
    ${parsed_json}=  Evaluate    json.loads($Get_Response.content)
    ${json_WebId}=   get value from json    ${parsed_json}  $..WebId
    @{LisOfWebId} =  Convert To List         ${json_WebId}
    FOR     ${WebIds}     IN      @{LisOfWebId}
        Log To Console   ${WebIds}
        Create Session    NewSession    ${BASE_URL}/streams/${json_WebId}/value     auth=${auth}
        ${value_response}=    Get On Session    NewSession    ${BASE_URL}/streams/${json_WebId}/value
            #log to console    ${value_response.status_code}
            #log to console    ${value_response.content}
            ${json_Timestamp}=   get value from json    ${value_response}  $.Timestamp
            ${json_Value_Name}=   get value from json    ${value_response}  $.Value.Name
            Log To Console   ${json_Timestamp}
            Log To Console   ${json_Value_Name}
    END
    #Create Session    NewSession    ${BASE_URL}/streams/${WebIds}/value     auth=${auth}
    #${value_response}=    Get On Session    NewSession    ${BASE_URL}/streams/${WebIds}/value
    #log to console    ${value_response.status_code}
    #log to console    ${value_response.content}
    #${new_parsed_json}=  to json    json.loads(value_response.content)  json
    #${json_Timestamp}=   get value from json    ${new_parsed_json}  $.Timestamp
   # ${json_Value_Name}=   get value from json    ${new_parsed_json}  $.Value.Name
   # Log To Console   ${json_Timestamp}
    #Log To Console   ${json_Value_Name}

*** Keywords ***
Generate URLs
    [Return]    ${BASE_URL}/streams/