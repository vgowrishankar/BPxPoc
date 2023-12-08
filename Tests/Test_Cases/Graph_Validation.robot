*** Settings ***
Library         SeleniumLibrary
Library    Collections


*** Variables ***

@{list_of_Values}



*** Test Cases ***
Graph Validation
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


*** Keywords ***

