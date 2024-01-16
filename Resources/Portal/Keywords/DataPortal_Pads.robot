*** Settings ***
Library         SeleniumLibrary
Library         String
Variables       ../PageObject/DataPortal_Pads.py
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary
Library         ../PageObject/Locators.py
Library         Custome_Methods.py

*** Variables ***
@{Pads_Table_Headings}=        ${EMPTY}     Pad_Name      Pad_ID       Business_Unit
#@{ll}



*** Keywords ***

Input_Pad_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

#=============================  END  =============================================================

Input_Pad_Value
    [Documentation]   used to input value in Search value
    [Arguments]    ${Element}   ${Pad_input_Value}
    wait until element is visible    ${Element}
    input text    ${Element}    ${Pad_input_Value}

#=============================  END  =============================================================

Click_Button
    [Arguments]    ${Element}
    wait until element is visible    ${Element}
    click element    ${Element}

#=============================  END  =============================================================

Click Refresh Table
    Click Element  ${RefreshTable}

#=============================  END  =============================================================

Drop_down_List_Validation
    [Documentation]    This Keyword used to fetch list from dropdown and compare with actual list
    [Arguments]    ${dropdown_element}  @{Expected_list}
    wait until page contains element   ${dropdown_element}  60s
    ${Actual_list}=     get list items    {dropdown_element}
    log to console   @{Expected_list}
    log to console    ${Actual_list}
    lists should be equal    ${Actual_list} @{Expected_list}

#=============================  END  =============================================================

Upload_Document
    [Documentation]    This Key word used to acheive upload file function
    [Arguments]    ${upload_btn_element}  @{File_path}
    wait until page contains element   ${upload_btn_element}  60s
    choose file    ${upload_btn_element}    @{File_path}

#=============================  END  =============================================================

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

#=============================  END  =============================================================

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

#=============================  END  =============================================================

Send_Keys
    [Arguments]    ${Sendkey_Element}   ${Input_Value}
    TRY
        wait until element is visible    ${Sendkey_Element}
        clear element text          ${Sendkey_Element}
        input text    ${Sendkey_Element}   ${Input_Value}
    EXCEPT    run keyword and expect error
        log    run keyword and expect error

#=============================  END  =============================================================

Pads_Filter_Function
     [Arguments]    ${Pad_filter_Value}  ${Pad_input_Value}

        wait until element is visible    ${pads_dd_search_box}    10s
        Wait For Condition    return document.readyState == "complete"
        input_pad_filter    ${pads_dd_search_box}   ${Pad_filter_Value}
        dataportal_pads.input_pad_value    ${pad_search_input}      ${Pad_input_Value}
        wait until element is enabled    ${pads_apply_filter}
        click_button    ${pads_apply_filter}

#=============================  END  =============================================================

Pads_Filter_Function_using_Arrow
        [Arguments]       ${Pad_filter_Value}
        click element    ${Pad_Name_DD_Arrow}
        sleep    3
        click element    ${Pad_Select_pad_name_from_dd}
        input_pad_filter    ${Pad_Search_input}    ${Pad_filter_Value}
        wait until element is enabled    ${pads_apply_filter}
        click_button    ${pads_apply_filter}


#=============================  END  =============================================================

Get_all_values_From_Data_portal_Pads_table
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}
    sleep   3
    @{ll}=        Create List
    ${column}   get element count     ${Pads_Table_Rows}
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    ${Pads_Table_Rows}\[${i}]
         ${text}=      GET TEXT       ${Pads_Table_Rows}\[${i}]
         LOG TO CONSOLE       ${text}
    END
    ${Total_data}   GET ELEMENT COUNT     ${Pads_Table_all_values_elements}
    LOG TO CONSOLE    Total_data_count_is=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     ${Pads_Table_coloum}
    LOG TO CONSOLE    Total_data_count_is=${Total_rr}
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
        ${rowindex}=    convert to string    ${i}
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Pads_Table_Fetch_each_values_elements}       Rowindex       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       Dataintex       ${dataindex}
        ${locatores}=   get webelement    ${Text_element}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT     ${Text_element}
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Pads_Table_Headings}[${j}]       ${data_text}
        END
    LOG TO CONSOLE    ${dict}
    append to list    ${ll}     ${dict}
    END
    log to console          ${ll}
    log    ${ll}

#=============================  END  =============================================================

Select_side_panel
    wait until element is visible    ${Pads_Side_Extend_Tab}
    click element       ${Pads_Side_Extend_Tab}

#=============================  END  =============================================================

Upload_URL_function
    [Arguments]    ${URL_name}      ${URL}
    wait until element is visible    ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_name_input}
    input text        ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_name_input}         ${URL_name}
    wait until element is visible    ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_input}
    input text        ${Pads_Ex_Tab_Pad_data_Attachements_first_URL_input}         ${URL}
    click element       ${Pads_Ex_Tab_Pad_data_Attachements_first_upload_URL_btn}

#=============================  END  =============================================================

Get_all_uploaded_file_list
    ${list_of_elements}=        get webelements     ${Pads_Ex_Tab_Pad_data_Attachements_first_uploaded_doc_name}
    ${Element_count}=    get element count    ${Pads_Ex_Tab_Pad_data_Attachements_first_uploaded_doc_name}
    log to console    Total_file_countis=${Element_count}
    ${list}=    create list

    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        #log to console    ${i.text}
        ${get_text}=    get text    ${i}
        APPEND TO LIST    ${list}        ${get_text}
    END

    LOG TO CONSOLE     List_Of_Files= ${list}
    [Return]    ${list}

#=============================  END  =============================================================

Select_AND_Toggle_button
    sleep    5
    wait until element is visible    ${Pads_And_Toggle_Pressed_status}      10s
    ${status}=    Run Keyword And Return Status    Click Element    ${Pads_And_Toggle}
    Run Keyword If    'True'=='${status}'       Tab_clicked_successfully

#=============================  END  =============================================================

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

#=============================  END  =============================================================

Table_Value_validation_with_filter_option
    [Arguments]     ${Enter_table_list}     ${Enter_list_of_input}      ${Filter_mode}
    LOG TO CONSOLE      ${Filter_mode}
    ${new_Filter_mode}=     convert to lower case    ${Filter_mode}
    log to console     ${new_Filter_mode}
    RUN KEYWORD IF    '${new_Filter_mode}' == 'and'     And_Toggle_option_validation    ${Enter_table_list}    ${Enter_list_of_input}       ELSE    Or_Toggle_option_validation    ${Enter_table_list}    ${Enter_list_of_input}

#=============================  END  =============================================================

Or_Toggle_option_validation
    [Arguments]    ${list_to_be_validate}       ${list_of_input_values}

    FOR     ${i}    IN    @{list_of_input_values}
        FOR    ${j}    IN      @{list_to_be_validate}
                should contain any    ${j}      @{list_of_input_values}     ignore_case=True
                LOG TO CONSOLE    Input_Value=@{list_of_input_values}
                log to console    Contains_in=${j}
        END

    END

#=============================  END  =============================================================

And_Toggle_option_validation
    [Arguments]    ${list_to_be_validate}       ${list_of_input_values}

    FOR     ${i}    IN    @{list_of_input_values}
        FOR    ${j}    IN      @{list_to_be_validate}
                should contain   ${j}      @{list_of_input_values}     ignore_case=True
                LOG TO CONSOLE    Input_Value=@{list_of_input_values}
                log to console    Contains_in=${j}

        END

    END

#=============================  END  =============================================================

Uploading_files
    [Arguments]    @{List_Of_file_tobe_uploaded}
    wait until element is visible    ${Pads_Ex_Tab_Pad_data_Attachements_first_area_Browse_file_btn}    10s
    choose file      ${Pads_Ex_Tab_Pad_data_Attachements_first_area_Browse_file_btn}        ${CURDIR}${/}..\\..\\..\\TestData\\Upload_files\\Test_csv_file.csv

#=============================  END  =============================================================

Select_Pads_Tab
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}

#=============================  END  =============================================================

Filter_with_values
    Pads_Filter_Function_using_Arrow     ${Pads_Search_Input}
    #Below code used to minimize window using Python script | Source_path = Resources->Portal->Keywords->Custome_Methods.py
    Custome_Methods.minwindow
    sleep    5

#=============================  END  =============================================================

Click_Table_Value
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5

#=============================  END  =============================================================

Navigate_to_attachment_Tab_And_upload_file
    Select_side_panel
    wait until element is visible     ${Pads_Ex_Tab_Pad_data_Attachemnts}
    click element        ${Pads_Ex_Tab_Pad_data_Attachemnts}
    sleep    5
    click element      ${Pads_Ex_Tab_Pad_data_Attachements_first_area_Browse_file_btn}
    #Below code used to upload single/Mulitple file  using Python script | Source_path = Resources->Portal->Keywords->Custome_Methods.py
    Custome_Methods.Upload_files     ${Pads_Uploading_files}

#=============================  END  =============================================================

Uploaded_file_validation
    sleep  3
    ${list_of_files_uploaded}=      Get_all_uploaded_file_list
    FOR    ${file_name}     IN    @{Pads_Uploading_file_names}
        list should contain value    ${list_of_files_uploaded}      ${file_name}
    END

#=============================  END  =============================================================

Click_Attachment_Tab
    wait until element is visible     ${Pads_Ex_Tab_Pad_data_Attachemnts}
    click element        ${Pads_Ex_Tab_Pad_data_Attachemnts}
    sleep    5

#=============================  END  =============================================================

URL_Upload_files_validation
    Sleep   5
    ${list_of_uploadedfile}=        Get_all_uploaded_file_list
    ${latest}=    get from list    ${list_of_uploadedfile}          0
    list should contain value      ${list_of_uploadedfile}       ${Pads_Attachments_URL_Name}
    should be equal as strings    ${latest}         ${Pads_Attachments_URL_Name}
