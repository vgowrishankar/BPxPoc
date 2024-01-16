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
    #open excel document    ${file_path}     1
    ${sheets}=  ExcelLibrary.get list sheet names
    ${data}=     read excel cell      ${rownum}    ${colnum}    ${sheet_name}

    [Return]    ${data}
    close current excel document


Write_Data_To_Excel_File
    [Arguments]    ${filename}     ${sheet_name}    ${rownum}    ${colnum}    ${Value}
    ${file_path}=    replace string    ${file_path1}    filename     ${filename}
    open excel document    ${file_path}     doc_id=docid
    write excel cell    ${rownum}    ${colnum}    ${Value}     ${sheet_name}
    close current excel document


Read_Row_Values_and_store_In_List
    [Arguments]    ${filename}  ${Column_No}   ${Row_Start_From}   ${Max_value_to_Pick}   ${sheet_name}
    ${file_path}=    replace string    ${file_path1}    filename     ${filename}
    open excel document    ${file_path}     doc_id=docid
    ${list}=        Read Excel Row           ${Column_No}     ${Row_Start_From}     ${Max_value_to_Pick}     ${sheet_name}
    [Return]     ${list}
    close current excel document