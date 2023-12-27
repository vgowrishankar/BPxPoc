*** Settings ***
Library         SeleniumLibrary
Variables       ../PageObject/Locators.py
Library         DataDriver      ../../../TestData/Database.xls
Library         SeleniumLibrary
Library         String
Variables       ../PageObject/DataPortal_Pads.py
Library         DataDriver      ../../../TestData/Database.xls
Library         Collections
Library         SeleniumLibrary
Library          JSONLibrary
Library         ../PageObject/Locators.py
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py
Variables       ../PageObject/DataPortal_WellOrigins.py
*** Variables ***
@{Well_origin_Table_Headings}=        ${EMPTY}     Well_Name      Pad_Name       Business_Unit      stage     Origin_Corp_ID       API      POL_Date
@{Well_origin_side_panel_information_headings}=     ${EMPTY}     Pad_ID       Concept_ID      Origin_Corp_ID     Wellbores       Completions      Operator    Business_Unit     Bu_Dso      COUNTY      STATE       ASSET       ASSIGNED_FIELD      PAD_NAME        RIG_NAME        STAGE       PLANNED_OPERATOR_TYPE       OPERATOR_TYPE       COST_CENTER


*** Keywords ***
Well_origin_Filter_Function_using_Arrow
        [Arguments]      ${DD_selection_element}        ${Pad_filter_Value}
        click element    ${Pad_Name_DD_Arrow}
        sleep    3
        click element    ${DD_selection_element}
        Input_Well_origin_Filter    ${Well_origin_Search_input}    ${Pad_filter_Value}
        wait until element is enabled    ${Well_Origins_Apply_Filter}
        click_button    ${Well_Origins_Apply_Filter}


Input_Well_origin_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}



Select Well Filter
    select from list by label  ${WellName}

Input Well Name
    Input text  ${WellName}

Click Refresh Table
    Click Element  ${RefreshTable}

Get_all_values_From_Data_porta_Well_origin_table
    Custome_Methods.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}

    sleep   3
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
         ${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]

    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr
    LOG TO CONSOLE    Totaldatacountis=${Total_rr}
     ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
    LOG TO CONSOLE    1stloop started
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Well_origin_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    [Return]    ${list_of_value}


Get_all_Value_from_side_panel_info_table
    ${list_of_elements}=        get webelements     ${Well_Origins_Ex_Tab_Header_Table_Values}
    ${Element_count}=    get element count    ${Well_Origins_Ex_Tab_Header_Table_Values}
    log to console    Total_file_countis=${Element_count}
    ${dict}=    create dictionary
    ${count}=    set variable    1
    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get text    ${i}
        set to dictionary    ${dict}        ${Well_origin_Table_Headings}[${count}]       ${get_text}
        ${count}=   evaluate    ${count}+1
    END

    LOG TO CONSOLE     Side_panel_List_Of_Values= ${dict}
    [Return]    ${dict}


Get_all_Value_from_side_panel_info_Tab_informations
    ${list_of_elements}=        get webelements     ${Well_Origins_Ex_Tab_Pad_data_info_all_information_inputs}
    ${Element_count}=    get element count    ${Well_Origins_Ex_Tab_Pad_data_info_all_information_inputs}
    log to console    Total_file_countis=${Element_count}
    ${dict}=    create dictionary
    ${count}=    set variable    2
    ${get_pad_id_Value}=        get text    xpath=//div[@id='Well_Origin_Data-Info-pad_id']/a
    set to dictionary    ${dict}        Pad_ID       ${get_pad_id_Value}
    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get value    ${i}
        set to dictionary    ${dict}        ${Well_origin_side_panel_information_headings}[${count}]       ${get_text}
        ${count}=   evaluate    ${count}+1
    END

    LOG TO CONSOLE     Side_panel_List_Of_information_Values= ${dict}
    [Return]    ${dict}