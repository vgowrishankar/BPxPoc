*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py
Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
#Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py


*** Variables ***
${filter_value}       OR
@{table_value}=     anstate    state     anstEate    st
@{list_of_input}=   an      STATE




*** Test Cases ***
sample
    Table_Value_validation_with_filter_option       ${table_value}      ${list_of_input}        ${filter_value}




*** Keywords ***
Validate_The_Filter_Functionality_using_And_Condition
    [Tags]    TC151123011
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function_using_Arrow     gre
    Select_AND_Toggle_button
    Pads_Filter_Function_using_Arrow     gre
    Custome_Methods.minwindow
    sleep    5
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5

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