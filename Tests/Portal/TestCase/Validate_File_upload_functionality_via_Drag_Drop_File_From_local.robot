*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py

Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
*** Variables ***
*** Test Cases ***
testing









*** Keywords ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    login_to_Data_Portal
    sleep    5
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function    Pad Name  Landgre
    sleep    5
    get_all_values_from_table

Get_all_values_From_Data_porta_Pads_table
    locators.minwindow
    sleep   10
    wait until element is visible    ${Pads_Tab}
    click element     ${Pads_Tab}

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
    FOR    ${i}    IN RANGE     1       ${Total_data}
    LOG TO CONSOLE    1stloop started
        FOR    ${j}    IN RANGE     1       ${column}+1
        #LOG TO CONSOLE    2ndloop started
        ${locatores}=   get webelement    xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        scroll element into view        ${locatores}
        ${data_text}=   GET TEXT     xpath=(//table[@class='mat-mdc-table mdc-data-table__table cdk-table table']//tbody)[1]//tr[${i}]//td[${j}]
        log to console    ${data_text}
        END
    #LOG TO CONSOLE    loop_completed
    END
