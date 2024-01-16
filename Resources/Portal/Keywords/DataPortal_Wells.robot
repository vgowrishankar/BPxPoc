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
Resource        DataPortal_Constants.robot


*** Variables ***
@{Well_origin_Table_Headings}=        ${EMPTY}     Well_Name      Pad_Name       Business_Unit      stage     Origin_Corp_ID       API      POL_Date
@{Well_origin_side_panel_information_headings}=     ${EMPTY}     Pad_ID       Concept_ID      Origin_Corp_ID     Wellbores       Completions      Operator    Business_Unit     Bu_Dso      County      State       Asset       Assigned_Field      Pad_Name        Rig_Name        Stage       Planned_Operator_Type       Operator_Type       Cost_Center


*** Keywords ***
Well_origin_Filter_Function_using_Arrow
        sleep    2
        ${DD_Value}=     replace string    ${Well_origin_Select_pad_name_from_dd}       value      ${WellOrigins_DropDown_Selection}
        click element    ${Pad_Name_DD_Arrow}
        sleep    3
        click element    ${DD_Value}
        Input_Well_origin_Filter    ${Well_origin_Search_input}    ${WellOrigins_Search_Input}
        wait until element is enabled    ${Well_Origins_Apply_Filter}
        click_button    ${Well_Origins_Apply_Filter}
        Custome_Methods.minwindow

#=============================  END  =============================================================

Input_Well_origin_Filter
    [Documentation]   used to input value in Filter dropdown
    [Arguments]    ${Element}   ${Pad_filter_Value}
    wait until element is visible    ${Element}
    clear element text    ${Element}
    input text    ${Element}    ${Pad_filter_Value}

#=============================  END  =============================================================

Select_Side_Panel_Extent_Arrow
    wait until element is visible    ${Well_Origins_Side_Extend_Tab}
    click element       ${Well_Origins_Side_Extend_Tab}

#=============================  END  =============================================================

Select Well Filter
    select from list by label  ${WellName}

#=============================  END  =============================================================

Input Well Name
    Input text  ${WellName}

#=============================  END  =============================================================

Click Refresh Table
    Click Element  ${RefreshTable}

#=============================  END  =============================================================

Get_all_values_From_Data_porta_Well_origin_table
    sleep   10
    ${column}   get element count     ${Well_Origins_Table_Rows}
    LOG TO CONSOLE    ${column}
    FOR     ${i}    IN RANGE       1       ${column}+1
         ${locators}=   get webelement    ${Well_Origins_Table_Rows}\[${i}]
         ${text}=      GET TEXT       ${Well_Origins_Table_Rows}\[${i}]
    END
    log to console    Header_values_Fetch_successfully
    ${Total_data}   GET ELEMENT COUNT     ${Well_Origins_Table_all_values_elements}
    LOG TO CONSOLE    Total_Data_Count_Is=${Total_data}

    ${Total_rr}   GET ELEMENT COUNT     ${Well_Origins_Table_coloum}
    Set Global Variable    ${Total_rr}
    LOG TO CONSOLE    Total_Row_Count_Is=${Total_rr}
     ${list_of_value}=    create list
    FOR    ${i}    IN RANGE     1       ${Total_rr}+1
        # Replace String methods can't use in integer so converting  ${i} integer value into strings
        ${rowindex}=    convert to string    ${i}
        ${dict}=    create dictionary
        FOR    ${j}    IN RANGE     1       ${column}+1
        ${dataindex}=    convert to string     ${j}
        ${Row_index_added_element}=     replace string    ${Well_Origins_Table_focus_Each_elements}       Rowindex       ${rowindex}
        ${Text_element}=    replace string    ${Row_index_added_element}       Dataindex       ${dataindex}
        scroll element into view        ${Text_element}
        ${data_text}=   GET TEXT     ${Text_element}
        log to console    ${data_text}
        set to dictionary    ${dict}        ${Well_origin_Table_Headings}[${j}]       ${data_text}
        END

    append to list    ${list_of_value}     ${dict}
    END
    log to console          ${list_of_value}
    log    ${list_of_value}
    sleep  2
    Set Global Variable    ${list_of_value}
    [Return]    ${list_of_value}

#=============================  END  =============================================================

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

#=============================  END  =============================================================

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

#=============================  END  =============================================================

Click_Table_Row_By_Index
    [Arguments]    ${index}
    sleep    5
    click element        ${Well_Origins_Table_coloum}\[${index}]
    sleep    5

#=============================  END  =============================================================

Assign_WellOrigin_Table_Values_as_Variables
    #[Arguments]    ${List_Of_Dictionary}
    ${all_list_Values}=             Get_all_values_From_Data_porta_Well_origin_table
    #**********************Have to Input list of Dictionary Fetch from Table and declard each value as variable for validation purpose *************************
    &{Fetch_table_value_from_list}=            get from list           ${all_list_Values}                  0
    ${Table_Value_wellname}=                   get from dictionary     ${Fetch_table_value_from_list}      Well_Name
    ${Table_Value_padname}=                    get from dictionary     ${Fetch_table_value_from_list}      Pad_Name
    ${Table_Value_Business_Unit}=              get from dictionary     ${Fetch_table_value_from_list}      Business_Unit
    ${Table_Value_stage}=                      get from dictionary     ${Fetch_table_value_from_list}      stage
    ${Fetch_Origin_Corp_ID}=                   get from dictionary     ${Fetch_table_value_from_list}      Origin_Corp_ID
    ${Table_Value_API}=                        get from dictionary     ${Fetch_table_value_from_list}      API
    ${Table_Value_POL_Date}=                   get from dictionary     ${Fetch_table_value_from_list}      POL_Date
    #For Empty values Shows - in table value blank in side panel Value for validation purpose changing - to empty values
    ${new_Fetch_Origin_Corp_ID}=     replace string     ${Fetch_Origin_Corp_ID}       —     ${EMPTY}
    set suite variable    ${Table_Value_wellname}
    set suite variable    ${Table_Value_padname}
    set suite variable    ${Table_Value_Business_Unit}
    set suite variable    ${Table_Value_stage}
    set suite variable    ${new_Fetch_Origin_Corp_ID}
    set suite variable    ${Fetch_Origin_Corp_ID}
    set suite variable    ${Table_Value_API}
    set suite variable    ${Table_Value_POL_Date}
    #===============
    sleep    5

#=============================  END  =============================================================

Validate_Table_Value_with_Side_Panel_Information_Values
    #Get Total Row Count For iteration
    ${Total_Row}=    GET ELEMENT COUNT     ${Well_Origins_Table_coloum}
    #Fetch All value From Table and Store in list of Dictionary
    ${all_list_Values}=     Get_all_values_From_Data_porta_Well_origin_table
    #Click Each Row in Table and Fetch Value and Compare from side panel information Values
    FOR    ${i}    IN RANGE    0     ${Total_rr}
    #From Stored List of Dictionary Itereate each Dictionary and using the key store each value in Variable
    &{Fetch_table_value_from_list}=        get from list           ${all_list_Values}     ${i}
    ${Table_Value_padname}=                get from dictionary     ${Fetch_table_value_from_list}      Pad_Name
    ${Fetch_Origin_Corp_ID}=               get from dictionary     ${Fetch_table_value_from_list}      Origin_Corp_ID
    #For Empty values Shows - in table value blank in side panel Value for validation purpose changing - to empty values
    ${new_Fetch_Origin_Corp_ID}=     replace string     ${Fetch_Origin_Corp_ID}       —     ${EMPTY}
    #============================================================================

    #Click Each Row
    ${Row_Count_index}=   Evaluate       ${i}+1
    Click_Table_Row_By_Index     ${Row_Count_index}
    #Navigate to Side Panel
    Select_Side_Panel_Extent_Arrow
    #Get Side Panel Title
    ${Get_side_panel_title_element}=        replace string    ${Well_Origins_Ex_tab_Title}      value       ${WellOrigins_Search_Input}
    ${side_panel_Title_Text}=       get text        ${Get_side_panel_title_element}

    #******************* Get all value from Side panel table *********************
    ${side_panel_Table_value}=      Get_all_Value_from_side_panel_info_table
    #******************* Set Side panel values in Variables for Validation *********************
    ${side_panel_information_value}=    Get_all_Value_from_side_panel_info_Tab_informations
    ${side_panel_Pad_Name}=             get from dictionary     ${side_panel_information_value}      Pad_Name
    ${side_panel_Pad_ID}=               get from dictionary     ${side_panel_information_value}      Pad_ID
    ${side_panel_Concept_ID}=           get from dictionary     ${side_panel_information_value}      Concept_ID
    ${side_panel_Origin_Corp_ID}=       get from dictionary     ${side_panel_information_value}      Origin_Corp_ID

                            #***** Validation ******
    #Validate Side Panel Heading
    should be equal         ${side_panel_Title_Text}        ${WellOrigins_Search_Input}       ignore_case=True
    #Validate side panel table value with side panel table values
    dictionaries should be equal     ${Fetch_table_value_from_list}      ${side_panel_Table_value}
    #Validate side panel information value
    should be equal         ${Table_Value_padname}             ${side_panel_Pad_Name}             ignore_case=True
    should be equal         ${new_Fetch_Origin_Corp_ID}        ${side_panel_Origin_Corp_ID}       ignore_case=True
    Click Element    ${Well_Origins_Extend_Tab_Close_btn}
    sleep  2
    END