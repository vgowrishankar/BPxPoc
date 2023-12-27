*** Settings ***
Library         SeleniumLibrary
Library         String
Variables       ../PageObject/DataPortal_Pads.py
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary
Library         ../PageObject/Locators.py


*** Variables ***
@{Pads_Table_Headings}=        ${EMPTY}     Pad_Name      Pad_ID       Business_Unit
@{ll}



*** Keywords ***
Select Pad Filter

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
            scroll element into view    ${Element}
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
        input_pad_filter    ${Pad_Search_input}    ${Pad_filter_Value}
        wait until element is enabled    ${pads_apply_filter}
        click_button    ${pads_apply_filter}

test_Get_all_values_From_Data_porta_Pads_table
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}
    click element     ${Pads_Tab}

    sleep   3
    ${data}=    get text         xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table' or @role=table]//thead//tr)[1]//th[1]
    LOG TO CONSOLE    ${data}
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
         ${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
         LOG TO CONSOLE       ${text}
    END
    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr
    LOG TO CONSOLE    Totaldatacountis=${Total_rr}

    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
    LOG TO CONSOLE    1stloop started
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        END
    #LOG TO CONSOLE    loop_completed
    END

Get_all_values_From_Data_porta_Pads_table
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}

    sleep   3
    ${data}=    get text         xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table' or @role=table]//thead//tr)[1]//th[1]
    LOG TO CONSOLE    ${data}
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
         ${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
         LOG TO CONSOLE       ${text}
    END
    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr
    LOG TO CONSOLE    Totaldatacountis=${Total_rr}

    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
    LOG TO CONSOLE    1stloop started
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Pads_Table_Headings}[${j}]       ${data_text}
        END
    LOG TO CONSOLE    ${dict}
    append to list    ${ll}     ${dict}
    END
    log to console          ${ll}
    log    ${ll}


Select_side_panel
    wait until element is visible    ${Pads_Side_Extend_Tab}
    click element       ${Pads_Side_Extend_Tab}


Upload_URL_function
    [Arguments]    ${URL_name}      ${URL}
    wait until element is visible    ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_name_input}
    input text        ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_name_input}         ${URL_name}
    wait until element is visible    ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_input}
    input text        ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_input}         ${URL}
    #click element       ${Pads_Ex_Tab_Pad_data_Attachements_first_upload_URL_btn}


Get_all_uploaded_file_list
    ${list_of_elements}=        get webelements     ${Pads_Ex_Tab_Pad_data_Attachements_first_uploaded_doc_name}
    ${Element_count}=    get element count    ${Pads_Ex_Tab_Pad_data_Attachements_first_uploaded_doc_name}
    log to console    Total_file_countis=${Element_count}
    ${list}=    create list

    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get text    ${i}
        APPEND TO LIST    ${list}        ${get_text}
    END

    LOG TO CONSOLE     List_Of_Files= ${list}
    [Return]    ${list}

Select_AND_Toggle_button
    sleep    5
    wait until element is visible    ${Pads_And_Toggle_Pressed_status}      10s
    ${status}=    Run Keyword And Return Status    Click Element    ${Pads_And_Toggle}
    Run Keyword If    'True'=='${status}'       Tab_clicked_successfully


Get_all_Value_from_Pad_name_Header_table
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}

    sleep   3
    ${list_of_elements}=        get webelements     ${Pads_Table_only_Padname_Value}
    ${Element_count}=    get element count    ${Pads_Table_only_Padname_Value}
    log to console    Total_file_countis=${Element_count}
    ${list}=    create list

    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get text    ${i}
        APPEND TO LIST    ${list}        ${get_text}
    END

    LOG TO CONSOLE     List_Of_Files= ${list}
    [Return]    ${list}



Table_Value_validation_with_filter_option
    [Arguments]     ${Enter_table_list}     ${Enter_list_of_input}      ${Filter_mode}
    LOG TO CONSOLE      ${Filter_mode}
    ${new_Filter_mode}=     convert to lower case    ${Filter_mode}
    log to console     ${new_Filter_mode}
    RUN KEYWORD IF    '${new_Filter_mode}' == 'and'     And_Toggle_option_validation    ${Enter_table_list}    ${Enter_list_of_input}       ELSE    Or_Toggle_option_validation    ${Enter_table_list}    ${Enter_list_of_input}




Or_Toggle_option_validation
    [Arguments]    ${list_to_be_validate}       ${list_of_input_values}

    FOR     ${i}    IN    @{list_of_input_values}
        FOR    ${j}    IN      @{list_to_be_validate}
                should contain any    ${j}      @{list_of_input_values}     ignore_case=True
                LOG TO CONSOLE    Input_Value=@{list_of_input_values}
                log to console    Contains_in=${j}
        END

    END

And_Toggle_option_validation
    [Arguments]    ${list_to_be_validate}       ${list_of_input_values}

    FOR     ${i}    IN    @{list_of_input_values}
        FOR    ${j}    IN      @{list_to_be_validate}
                should contain   ${j}      @{list_of_input_values}     ignore_case=True
                LOG TO CONSOLE    Input_Value=@{list_of_input_values}
                log to console    Contains_in=${j}

        END

    END
