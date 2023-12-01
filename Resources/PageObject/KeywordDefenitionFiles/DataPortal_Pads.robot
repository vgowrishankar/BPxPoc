*** Settings ***
Library         SeleniumLibrary
Variables       ../Locators/Locators.py
Library         DataDriver      ../../../TestData/Database.xls
Library    Collections
Library         SeleniumLibrary
*** Keywords ***
Select Pad Filter
    select from list by label  ${PadName}

Input Pad Name
    Input text  ${PadName}

Click Refresh Table
    Click Element  ${RefreshTable}

Drop_down_List_Validation
    [Documentation]    This Keyword used to fetch list from dropdown and compare with actual list
    [Arguments]    ${dropdown_element}  @{Expected_list}
    wait until page contains element   ${dropdown_element}  60s
    ${Actual_list}=     get list items    {dropdown_element}
    log to console   @{Expected_list}
    log to console    ${Actual_list}
    lists should be equal    ${Actual_list} @{Expected_list}

Upload_Document
    [Documentation]    This Key word used to acheive upload file function
    [Arguments]    ${upload_btn_element}  @{File_path}
    wait until page contains element   ${upload_btn_element}  60s
    choose file    ${upload_btn_element}    @{File_path}


