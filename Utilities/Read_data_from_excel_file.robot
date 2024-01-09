*** Settings ***
Library    ExcelLibrary
Library     OperatingSystem

*** Variables ***
${file_path}=   ${CURDIR}${/}..\\TestData\\User_Dashboard.xlsx
*** Test Cases ***
sample
    ${data}=    Read_Data_Portal_Excel_File     Portal    1       2
    log to console    ${data}
    ${data}=    Read_Data_Portal_Excel_File     Portal    2       2
    log to console    ${data}



*** Keywords ***
Read_Data_Portal_Excel_File
    [Arguments]   ${sheet_name}   ${rownum}  ${colnum}
    open excel document    ${file_path}     doc_id=docid
    get sheet    ${sheet_name}
    ${data}=     read excel cell      ${rownum}    ${colnum}
    [Return]    ${data}
    close current excel document