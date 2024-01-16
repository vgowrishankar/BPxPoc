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
    sleep   5
    wait until element is visible    ${Wellbores_Tab}
    sleep   3
    ${column}   get element count     ${Well_bores_Table_Headings_Locatore}
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         #${text}=      GET TEXT       xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[2]//th)[${i}]
         ${text}=      GET TEXT       ${Well_bores_Table_Headings_Locatore}\[${i}]
    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     ${Well_bores_Table_Datas_Locatore}
    LOG TO CONSOLE    Total_data_count_is=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     ${Well_bores_Table_Rows_Locatore}
    LOG TO CONSOLE    Total_Row_count_is=${Total_rr}
     ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
        ${rowindex}=    convert to string    ${i}
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Well_bores_Table_Each_data_Locatore}       RowIndex       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       DataIndex       ${dataindex}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT     ${Text_element}
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Well_bores_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    [Return]    ${list_of_value}

#=============================  END  =============================================================

Well_bores_Filter_Function_using_Arrow
        ${DD_selection_element}=    replace string      ${Well_bores_Select_pad_name_from_dd}       value             ${Well_bores_DropDown_Selection}
        wait until element is visible    ${Well_bores_Name_DD_Arrow}    15s
        click element    ${Well_bores_Name_DD_Arrow}
        sleep    3
        click element    ${DD_selection_element}
        Input_Well_bores_Filter    ${Well_bores_Search_input_locator}    ${Well_bores_Search_Input}
        wait until element is enabled    ${Well_bores_Apply_Filter}
        click_button    ${Well_bores_Apply_Filter}

#=============================  END  =============================================================

Input_Well_bores_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

#=============================  END  =============================================================

Select_Wellbore_side_panel
    wait until element is visible    ${Well_bores_Side_Extend_Tab}
    click element       ${Well_bores_Side_Extend_Tab}

#=============================  END  =============================================================

Select_WellBores_Tab
     Wait Until Element Is Visible    ${Wellbores_Tab}
     click element       ${Wellbores_Tab}
     sleep    3

#=============================  END  =============================================================

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

#=============================  END  =============================================================

Assign_WellBores_Table_Values_as_Variables
    [Arguments]    ${List_Of_Dictionary_Fetch_From_Table}
    &{Fetch_table_value_from_wellbore_data_list}=        get from list           ${List_Of_Dictionary_Fetch_From_Table}            0
    ${well_boar_Table_Value_wellname}=                   get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Well_Name
    ${well_boar_Table_Value_Origin_Corp_ID}=             get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Origin_Corp_ID
    ${well_boar_Table_Value_Wellbore_Corp_ID}=           get from dictionary     ${Fetch_table_value_from_wellbore_data_list}      Wellbore_Corp_ID

    set suite variable    ${well_boar_Table_Value_wellname}
    set suite variable    ${well_boar_Table_Value_Origin_Corp_ID}
    set suite variable    ${well_boar_Table_Value_Wellbore_Corp_ID}

    