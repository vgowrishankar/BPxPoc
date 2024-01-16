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
    [Documentation]    This Function used to Fetch all table values from Completions Table and store and return list of Dictionary
    sleep   10
    wait until element is visible    ${Completions_Tab}
    sleep   3
    ${column}   get element count     ${Completions_Table_Column_Count}
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=  get webelement    ${Completions_Table_Headings}\[${i}]
         ${text}=      GET TEXT       ${Completions_Table_Headings}\[${i}]
    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     ${Completions_Table_Rows}
    LOG TO CONSOLE    Total_data_count_is=${Total_data}
    ${Total_rr}   GET ELEMENT COUNT     ${Completions_Table_Rows}
    LOG TO CONSOLE    Total_data_count_is=${Total_rr}
    ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
        ${rowindex}=    convert to string    ${i}
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Completions_Table_Each_Data}       Rowindex       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       DataIndex       ${dataindex}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT     ${Text_element}
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Completions_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    [Return]    ${list_of_value}

#=============================  END  =============================================================

Completions_Filter_Function_using_Arrow
        [Documentation]    This function used to Click arrow key | Select From Dropdown and put value in Search box then click Apply button
        ${DD_completion_selection_element}=    replace string      ${Completions_Select_pad_name_from_dd}       value             ${Completion_DropDown_Selection}
        click element    ${Completions_Name_DD_Arrow}
        sleep    3
        click element    ${DD_completion_selection_element}
        Input_Well_bores_Filter    ${Completions_Search_input_locator}    ${Completion_Search_Input}
        wait until element is enabled    ${Completions_Apply_Filter}
        click_button    ${Completions_Apply_Filter}

#=============================  END  =============================================================

Input_Well_bores_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

#=============================  END  =============================================================

Select_Completions_side_panel
    wait until element is visible    ${Completions_Side_Extend_Tab}
    click element       ${Completions_Side_Extend_Tab}

#=============================  END  =============================================================

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

#=============================  END  =============================================================

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

Select_Completions_Tab
    Wait Until Element Is Visible    ${Completions_Tab}
    click element       ${Completions_Tab}
    sleep  5

Select_Value_In_Table
    click element        ${Completions_Table_only_Wellname_Value}
    sleep    5

Get_Side_Panel_Title
    ${Get_side_panel_title_element}=        replace string    ${Completions_Ex_tab_Title}      value       ${Completion_Search_Input}
    ${side_panel_Title_Text}=                get text        ${Get_side_panel_title_element}
    [Return]    ${side_panel_Title_Text}


Assign_Completions_Side_Panel_info_Informations_Values_as_Variables
    [Arguments]    ${Side_Panel_table_list}
    ${Completion_Ex_Tab_info_information_wellname}=                     get from dictionary     ${Side_Panel_table_list}      Well_Name
    ${Completion_Ex_Tab_info_information_Padname}=                      get from dictionary     ${Side_Panel_table_list}      Pad_Name
    ${Completion_Ex_Tab_info_information_origin_corp_id}=               get from dictionary     ${Side_Panel_table_list}      Origin_Corp_ID
    ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}=      get from dictionary     ${Side_Panel_table_list}      Wellbore_Corp_ID
    set suite variable     ${Completion_Ex_Tab_info_information_wellname}
    set suite variable     ${Completion_Ex_Tab_info_information_Padname}
    set suite variable     ${Completion_Ex_Tab_info_information_origin_corp_id}
    set suite variable     ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}

Validation_Completions_Side_Panel_info_Table_Value
    [Documentation]    Validate Completions side panel info table value with Well origin and well bores Table Values
     #****     Validations    ********
     Log To Console    compare well name with well origin,wellbore,completions Tabs
     should be equal         ${Table_Value_wellname}        ${well_boar_Table_Value_wellname}       ignore_case=True
     should be equal         ${Table_Value_wellname}        ${Completion_Ex_Tab_info_information_wellname}       ignore_case=True
     #=================================
     Log To Console    Compare Pad name with well origin & completions tabs
     should be equal         ${Table_Value_padname}        ${Completion_Ex_Tab_info_information_Padname}       ignore_case=True
    #=================================
     Log To Console    Compare Origin_Corp_ID with well origin,well bore & completions tabs
     should be equal         ${new_Fetch_Origin_Corp_ID}        ${well_boar_Table_Value_Origin_Corp_ID}       ignore_case=True
     should contain         ${Completion_Ex_Tab_info_information_origin_corp_id}        ${new_Fetch_Origin_Corp_ID}       ignore_case=True
    #=================================
     Log To Console    Compare Wellbore corp ID with Wellbore and Completions Tab Values
     should be equal         ${well_boar_Table_Value_Wellbore_Corp_ID}        ${Completion_Ex_Tab_info_information_Wellbore_origin_corp_id}       ignore_case=True
