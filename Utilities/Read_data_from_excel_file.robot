*** Settings ***
Library    ExcelLibrary
Library     OperatingSystem

*** Variables ***

*** Keywords ***
Read_Data_Portal_Excel_File
    [Arguments]   ${sheet_name}   ${rownum}  ${colnum}
    ${file_path}=   ${CURDIR}${/}../TestData/DataPortal.xls

    open excel document    ${file_path}
    get sheet    ${sheet_name}
    ${data}=     read excel cell      ${rownum}    ${colnum}
    [Return]    ${data}
    close current excel document