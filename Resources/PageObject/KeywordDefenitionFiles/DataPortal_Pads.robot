*** Settings ***
Library         SeleniumLibrary
Variables       ../Locators/Locators.py
Library         DataDriver      ../../../TestData/Database.xls

*** Keywords ***
Select Pad Filter
    select from list by label  ${PadName}

Input Pad Name
    Input text  ${PadName}

Click Refresh Table
    Click Element  ${RefreshTable}