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