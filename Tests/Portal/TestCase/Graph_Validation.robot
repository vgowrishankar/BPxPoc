*** Settings ***
Library         SeleniumLibrary
Library         Collections
Variables       ../../../PageObject/Locators.py
#Resource            ../../../Resources/DataBase/Keywords/common.resource    # user to Extend other robot Test file
#Library         DataDriver      ../../../TestData/Database.xls      #User to Extend Data file like excel json


*** Variables ***
${single_variable}    mohammed      # ( $ symbol used To declar Single variables)
@{list_of_Values}       md       asif         khan     sample  # ( @ symbol used To declar List based variables)
&{Sample_dictonary}     first=asif      lastname=khan   # ( & symbol used To declar Dictionary based variables)


*** Test Cases ***




*** Keywords ***

Graph Validation
    [Documentation]     This Test Case used to get value from graph tooltip and store in list
    open browser    https://emicalculator.net/  Chrome
    maximize browser window
    @{listofelement}=   get webelements    //*[local-name()='svg']//*[name()='g' and @class='highcharts-series-group']//*[name()='rect']
    capture page screenshot    selenium.png
    FOR  ${list}    IN  @{listofelement}
        scroll element into view    ${list}
        mouse over    ${list}
        ${Text_Value}=  get text    //*[local-name()='svg']//*[name()='g' and @class='highcharts-label highcharts-tooltip highcharts-color-undefined']//*[name()='text']
        append to list    ${list_of_Values}       ${Text_Value}
        LOG    ${Text_Value}
        log    ${list_of_Values}
    END
    log    ${list_of_Values}
    capture page screenshot    selenium1.png
