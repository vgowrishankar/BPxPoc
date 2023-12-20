*** Settings ***
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary

*** Variables ***

${Json_File_path}       C:${/}Users${/}10712370${/}PycharmProjects${/}pythonProject${/}BPxPoc${/}TestData${/}API_Payload.json

*** Keywords ***
Read_Value_From_Json
    [Documentation]    Read data from json file
    [Arguments]    ${Json_File_path}
    #Load Json file
    ${Json_File}=   load json from file     ${Json_File_path}

    #Print Complete json file
    log dictionary    ${Json_File}
    log to console    ${Json_File}

    #Get json value with particular Key value
    ${json_Name}=   get value from json    ${Json_File}  $.Name
    ${json_Work}=   get value from json    ${Json_File}  $.Work
    ${json_Prog_lang}=   get value from json    ${Json_File}  $.Program_Language
    ${json_Contact}=   get value from json    ${Json_File}  $.Contact
    ${json_Contact_Mailid}=   get value from json    ${Json_File}  $.Contact.Mail_id

    log to console    ${json_Name[0]}
    log to console    ${json_Work}[0]}
    log to console    ${json_Prog_lang}[0]}
    log to console    ${json_Contact}[0]}
    log to console    ${json_Contact_Mailid[0]}

*** Test Cases ***
load json
    read_value_from_json    ${Json_File_path}