*** Settings ***
Library         SeleniumLibrary
Variables       ../Locators/Locators.py
Library         DataDriver      ../../../TestData/Database.xls

*** Keywords ***
Select Well Filter
    select from list by label  ${WellName}

Input Well Name
    Input text  ${WellName}

Click Refresh Table
    Click Element  ${RefreshTable}