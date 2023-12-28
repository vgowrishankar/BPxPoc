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

*** Variables ***
@{Well_bores_Table_Headings}=        ${EMPTY}     Well_Name      Origin_Corp_ID       Wellbore_Corp_ID      Business_Unit

*** Keywords ***
Get_all_values_From_Data_porta_Well_bores_table

    sleep   10
    wait until element is visible    ${Wellbores_Tab}

    sleep   3
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[2]//th
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[2]//th)[${i}]
         ${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[2]//th)[${i}]

    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[2]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[2]//tr
    LOG TO CONSOLE    Totaldatacountis=${Total_rr}
     ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
    LOG TO CONSOLE    1stloop started
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[2]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[2]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Well_bores_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    [Return]    ${list_of_value}


Well_bores_Filter_Function_using_Arrow
        [Arguments]      ${DD_selection_element}        ${Pad_filter_Value}
        wait until element is visible    ${Well_bores_Name_DD_Arrow}    15s
        click element    ${Well_bores_Name_DD_Arrow}
        sleep    3
        click element    ${DD_selection_element}
        Input_Well_bores_Filter    ${Well_bores_Search_input}    ${Pad_filter_Value}
        wait until element is enabled    ${Well_bores_Apply_Filter}
        click_button    ${Well_bores_Apply_Filter}

Input_Well_bores_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

Select_Wellbore_side_panel
    wait until element is visible    ${Well_bores_Side_Extend_Tab}
    click element       ${Well_bores_Side_Extend_Tab}


Get_all_Comments_list
    ${list_of_elements}=        get webelements     ${Well_bores_Ex_Tab_Pad_data_Comments_lists}
    ${Element_count}=    get element count    ${Well_bores_Ex_Tab_Pad_data_Comments_lists}
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