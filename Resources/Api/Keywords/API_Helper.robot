*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary


*** Variables ***
#GET Requet Variables
${Base_url}
${Path_URL}

#POST Request Variables
${Post_Request_Base_url}
${Post_Request_Path_URL}
&{POST_Request_Body}    Firstname=asif  Lastname=mohammed
&{Post_Request_Header}   Content-Type=application/json


*** Keywords ***
api_test
    get request


API_Get_Request
    [Documentation]    This Keyword used to Do the GET request action and it will return the Response body
    [Arguments]    ${Base_url}  ${path_url}
    log to console    GET request session initiated
    create session    New_API_Session   ${Base_url}
    log to console    Get Request Session Created   using ${Base_url}${path_url}
    ${Request}=     get request    New_API_Session  ${Path_URL}
    log to console    ${Request.status_code}
    ${response_code}=   convert to string    ${Request.status_code}
    should be equal    ${response_code}     200
    log to console    get request    completed returned Response body
    log to console    ${Request}
    log to console     ${response_code}
    #Retrun Response body when we get response code as 200
    IF    ${response_code}  ==    200
         [Return]    ${Request}
    ELSE    Error in Respose code
        log to console    Expected Response code is 200 - Received Response code is ${response_code}


API_Post_Request
    [Documentation]    This Keyword used to Do the POST request action and it will return the Response body
    [Arguments]    ${post_request_base_url}     &{POST_Request_Body}    &{Post_Request_Header}
    log to console    POST request session initiated
    create session    New_post_request  ${post_request_base_url}
    log to console    POST request session Created using ${post_request_base_url}     &{POST_Request_Body}    &{Post_Request_Header}
    ${Post_Request_Response}=    post request    New_post_request    ${post_request_path_url}    data=&{POST_Request_Body}   headers=&{Post_Request_Header}
    log to console    ${Post_Request_Response}

    IF    ${Post_Request_Response}  ==    201
         [Return]    ${Post_Request_Response}
    ELSE    Error in Respose code
        log to console    Expected Response code is 201 - Received Response code is ${Post_Request_Response}

API_Content_Validation
    [Documentation]    This Keyword used to Validate Response body content validation
    [Arguments]     ${Response_received}    ${Expected_Content}
    ${Body}=    convert to string    ${Response_received.content}
    should contain    ${Body}   ${Expected_Content}

API_Header_Validation
    [Documentation]    This Keyword used to Validate Header validation
    [Arguments]    ${Response_received} ${Header_Keys}  ${Header_Expected_Values}
    ${Condent_Type_Value}=  get from dictionary    ${Response_received.headers} ${Header_Keys}
    should be equal    ${Condent_Type_Value}    ${Header_Expected_Values}

Read_Value_From_Json
    ${Json_File}=   load json from file     C:${/}Users${/}10712370${/}PycharmProjects${/}pythonProject${/}BPxPoc${/}TestData${/}API_Payload.json
    ${json_Name}=   get value from json    ${Json_File}  $.Name
    ${json_Work}=   get value from json    ${Json_File}  $.Work
    ${json_Prog_lang}=   get value from json    ${Json_File}  $.Program_Language
    ${json_Contact}=   get value from json    ${Json_File}  $.Contact

    log to console    ${json_Name[0]}
    log to console    ${json_Work}[0]}
    log to console    ${json_Prog_lang}[0]}
    log to console    ${json_Contact}[0]}




