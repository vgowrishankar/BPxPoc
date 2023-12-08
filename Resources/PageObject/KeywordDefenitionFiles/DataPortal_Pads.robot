*** Settings ***
Library         SeleniumLibrary
Variables       ../Locators/Locators.py
Library         DataDriver      ../../../TestData/Database.xls
Library    Collections
Library         SeleniumLibrary

*** Variables ***




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

Scroll_Down_To_Find_Element
    [Arguments]    ${Element}
    log to console    searching element
    FOR    ${i}     IN RANGE    1     5
        TRY
            sleep   3
            scroll_down_to_find_element    ${Element}
            log to console    try to find element using scroLl down
        EXCEPT  trying to scrool down using javascript
            sleep    3
            execute javascript    window.scrollTo(0,200)
            END
        EXCEPT    Error message
            log     Catches any exception.

    END
Select_from_dropdown
    [Arguments]    ${Element}   ${dd_selection_Value}
    log    inside method
    FOR    ${I}     IN RANGE    1   5
        TRY
            click element    ${Element}
            sleep    3
            log    click sent
            ${Element_status}=  element should be disabled    ${Element}
            IF  ${Element_status}   ==  True
                select from list by label    ${dd_selection_Value}
                log    ${dd_selection_Value} option selected
            ELSE
                wait until element is visible    ${Element}


        EXCEPT  Error Message
            log     dropdown element Not found
    END

Send_Keys
    [Arguments]    ${Sendkey_Element}   ${Input_Value}
    TRY
        wait until element is visible    ${Sendkey_Element}
        clear element text          ${Sendkey_Element}
        input text    ${Sendkey_Element}   ${Input_Value}
    EXCEPT    run keyword and expect error
        log    run keyword and expect error

Get_All_values_From_Table
    [Arguments]    ${Table_Name}
    ${row}  get element count    xpath://table[name='${Table_Name}']/tboday/tr
    ${Coulumn}  get element count    xpath://table[name='${Table_Name}']/tboday/tr[1]/th

    log to console    Total row count is ${row}
    log to console    Total column count is ${Coulumn}

    FOR    ${i}     IN RANGE    1   ${Coulumn}
        FOR     ${j}    IN RANGE    1   ${row}
            ${Table_data}   get text    xpath://table[name='${Table_Name}']/tboday/tr[${i}]/td[${j}]
            LOG TO CONSOLE  ${Table_data}
        END
    END

*** Test Cases ***
