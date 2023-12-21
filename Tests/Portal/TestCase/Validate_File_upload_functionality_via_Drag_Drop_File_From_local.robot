*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py

Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
*** Variables ***
*** Test Cases ***
sample_test
    check_table








*** Keywords ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    login_to_Data_Portal
    sleep    5
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function    Pad Name  Landgre
    sleep    5
    get_all_values_from_table

check_table
    login_to_Data_Portal
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}
    click element     ${Pads_Tab}

    #get_all_values_from_table
    sleep   3
    ${data1}=   get text     ${Pads_Tab}
    LOG TO CONSOLE    ${data1}

    ${data}=    get text         xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table' or @role=table]//thead//tr)[1]//th[1]
    LOG TO CONSOLE    ${data}
    ${column}   get element count     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th

    LOG TO CONSOLE    ${column}



    FOR     ${i}    IN RANGE     1    ${column}+1
    LOG TO CONSOLE    forloopstarted
    ${text}=    GET TEXT     xpath=((//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//thead//tr)[1]//th)[${i}]
    LOG TO CONSOLE    forloopended
    LOG TO CONSOLE    ${text}
    END


    ${Total_data}   GET ELEMENT COUNT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td
    LOG TO CONSOLE    Totaldatacountis=${Total_data}

    FOR  ${i}    IN RANGE     1       ${Total_data}
    LOG TO CONSOLE    forloopstarted
    ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//td[${i}]
    LOG TO CONSOLE    forloopended
    LOG TO CONSOLE    ${data_text}
    END
