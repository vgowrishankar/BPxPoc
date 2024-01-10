*** Settings ***
Library    ExcelLibrary
Library     OperatingSystem
Library         Collections
Library         String

*** Variables ***
#${file_path}=   ${CURDIR}${/}..\\TestData\\User_Dashboard.xlsx
${file_path1}=   ${CURDIR}${/}..\\TestData\\filename



*** Keywords ***
Read_Data_From_Excel_File
    [Arguments]    ${filename}   ${sheet_name}  ${rownum}  ${colnum}
    ${file_path}=    replace string    ${file_path1}    filename     ${filename}
    open excel document    ${file_path}     doc_id=docid
    ${sheets}=  ExcelLibrary.get list sheet names
    ${data}=     read excel cell      ${rownum}    ${colnum}    ${sheet_name}
    [Return]    ${data}
    close current excel document


Excel_Variables
    ${exceldata}=    Read_Data_From_Excel_File        User_Dashboard.xlsx   Portal     2        2
    ${exceldata1}=    Read_Data_From_Excel_File        User_Dashboard.xlsx      OneMapRouting     2         2
    #OneMapRouting
    log to console    ${exceldata}
    log to console    ${exceldata1}

