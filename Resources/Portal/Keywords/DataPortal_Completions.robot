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
Variables       ../PageObject/DataPortal_Wellbores.py
Variables       ../PageObject/DataPortal_Completions.py

*** Variables ***
@{Completions_Table_Headings}=        ${EMPTY}     Well_Name      Origin_Corp_ID       Wellbore_Corp_ID      Completion_Corp_ID          Business_Unit
@{Completions_side_panel_information_headings}=     ${EMPTY}     Completion_Corp_ID       Well_Name      Well_Num     Area_Name       Asset      Business_Unit    Pad_Name     Facility_Name      Rig_Name
*** Keywords ***
Get_all_values_From_Data_porta_Completions_table

    sleep   10
    wait until element is visible    ${Completions_Tab}

    sleep   3
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[3]//th
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[3]//th)[${i}]
         ${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[3]//th)[${i}]

    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[3]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[3]//tr
    LOG TO CONSOLE    Totaldatacountis=${Total_rr}
     ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
    LOG TO CONSOLE    1stloop started
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[3]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[3]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Completions_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    [Return]    ${list_of_value}


Completions_Filter_Function_using_Arrow
        [Arguments]      ${DD_selection_element}        ${Pad_filter_Value}
        click element    ${Completions_Name_DD_Arrow}
        sleep    3
        click element    ${DD_selection_element}
        Input_Well_bores_Filter    ${Completions_Search_input}    ${Pad_filter_Value}
        wait until element is enabled    ${Completions_Apply_Filter}
        click_button    ${Completions_Apply_Filter}

Input_Well_bores_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

Select_Completions_side_panel
    wait until element is visible    ${Completions_Side_Extend_Tab}
    click element       ${Completions_Side_Extend_Tab}

Get_all_Value_from_Completions_side_panel_info_table
    ${list_of_elements}=        get webelements     ${Completions_Ex_Tab_Header_Table_Values}
    ${Element_count}=    get element count    ${Completions_Ex_Tab_Header_Table_Values}
    log to console    Total_file_countis=${Element_count}
    ${dict}=    create dictionary
    ${count}=    set variable    1
    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get text    ${i}
        set to dictionary    ${dict}        ${Completions_Table_Headings}[${count}]       ${get_text}
        ${count}=   evaluate    ${count}+1
    END

    LOG TO CONSOLE     Side_panel_List_Of_Values= ${dict}
    [Return]    ${dict}


Get_all_Value_from_side_panel_info_Tab_informations_Completions
    ${list_of_elements}=        get webelements     ${Completions_Ex_Tab_Pad_data_info_all_information_inputs}
    ${Element_count}=    get element count    ${Completions_Ex_Tab_Pad_data_info_all_information_inputs}
    log to console    Total_file_countis=${Element_count}
    ${dict}=    create dictionary
    ${count}=    set variable    1
    ${get_origin_Corp_id_Value}=        get text    ${completions_Ex_Tab_info_tab_informations_Origin_Corp_ID}
    ${get_origin_Wellboar_id_Value}=        get text    ${completions_Ex_Tab_info_tab_informations_Wellbore_Corp_ID}
    set to dictionary    ${dict}        Origin_Corp_ID       ${get_origin_Corp_id_Value}
    set to dictionary    ${dict}        Wellbore_Corp_ID       ${get_origin_Wellboar_id_Value}
    FOR     ${i}    IN        @{list_of_elements}
        scroll element into view        ${i}
        log to console    ${i.text}
        ${get_text}=    get value    ${i}
        set to dictionary    ${dict}        ${Completions_side_panel_information_headings}[${count}]       ${get_text}
        ${count}=   evaluate    ${count}+1
    END

    LOG TO CONSOLE     Side_panel_List_Of_information_Values= ${dict}
    [Return]    ${dict}