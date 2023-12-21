*** Settings ***
Library         SeleniumLibrary

Variables       ../PageObject/DataPortal_Pads.py
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary
Library         ../PageObject/Locators.py


*** Variables ***



*** Keywords ***
Select Pad Filter
    minwindow
    #select from list by label  ${PadName}

Input_Pad_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}




Input_Pad_Value
    [Documentation]   used to input value in Search value
    [Arguments]    ${Element}   ${Pad_input_Value}
    wait until element is visible    ${Element}
    input text    ${Element}    ${Pad_input_Value}

Click_Button
    [Arguments]    ${Element}
    wait until element is visible    ${Element}
    click element    ${Element}

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
            ${Element_status}=  element should be enabled    ${Element}
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

    ${row}  get element count    ${Pads_Table_Rows}
    ${Coulumn}  get element count    ${Pads_Table_coloum}

    log to console    Total row count is ${row}
    log to console    Total column count is ${Coulumn}


    FOR    ${i}     IN RANGE    1   ${Coulumn}+1
        FOR     ${j}    IN RANGE    1   ${row}
            sleep    2
            ${Table_data}   get text    (//th[contains(text(),'pad ID') and @role='columnheader']//parent::tr//parent::thead//parent::table/tbody/tr)${i}//td${j}

            LOG TO CONSOLE  ${Table_data}
        END
    END

Pads_Filter_Function
     [Arguments]    ${Pad_filter_Value}  ${Pad_input_Value}

        wait until element is visible    ${pads_dd_search_box}    10s
        Wait For Condition    return document.readyState == "complete"
        input_pad_filter    ${pads_dd_search_box}   ${Pad_filter_Value}
        dataportal_pads.input_pad_value    ${pad_search_input}      ${Pad_input_Value}
        wait until element is enabled    ${pads_apply_filter}
        click_button    ${pads_apply_filter}

Pads_Filter_Function_using_Arrow
        [Arguments]       ${Pad_filter_Value}
        click element    ${Pad_Name_DD_Arrow}
        sleep    3
        click element    ${Pad_Select_pad_name_from_dd}
        input_pad_filter    ${pads_dd_search_box}    ${Pad_filter_Value}
        wait until element is enabled    ${pads_apply_filter}
        click_button    ${pads_apply_filter}



