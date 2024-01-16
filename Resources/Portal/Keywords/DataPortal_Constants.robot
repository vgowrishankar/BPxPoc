*** Settings ***
Resource        ../../../Utilities/Read_data_from_excel_file.robot




*** Keywords ***
Portal_Variables_Read_from_Excel
    [Documentation]    This Function used to get cell value from Excel file
    #variable                                Methods name                 Excel File name     Sheet name  Row     Column
    ${BROWSER}=                             Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    2        2
    ${Login_URL}=                           Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    3        2
    ${UserName}=                            Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    4        2
    ${Password}=                            Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    5        2
    ${Pads_DropDown_Selection}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    6        2
    ${Pads_Search_Input}=                   Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    7        2
    ${Pads_Add_Comments}=                   Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    8        2
    ${Pads_Attachments_URL_Name}=           Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    9        2
    ${Pads_Attachments_URL}=                Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    10       2
    ${Pads_Uploading_files}=                Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    11       2
    ${Pads_Uploading_file_names}=           Read_Row_Values_and_store_In_List    User_Dashboard.xlsx      12       1      2         Portal
    ${WellOrigins_DropDown_Selection}=      Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    13       2
    ${WellOrigins_Search_Input}=            Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    14       2
    ${WellOrigins_Add_Comments}=            Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    15       2
    ${WellOrigins_Attachments_URL_Name}=    Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    16       2
    ${WellOrigins_Attachments_URL}=         Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    17       2
    ${WellOrigins_Uploading_files}=         Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    18       2
    ${WellOrigins_Uploading_file_names}=    Read_Row_Values_and_store_In_List    User_Dashboard.xlsx      19       1      2         Portal
    ${Well_bores_DropDown_Selection}=       Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    20       2
    ${Well_bores_Search_Input}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    21       2
    ${Wellbores_Add_Comments}=              Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    22       2
    ${Wellbores_Attachments_URL_Name}=      Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    23       2
    ${Wellbores_Attachments_URL}=           Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    24       2
    ${Wellbores_Uploading_files}=           Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    25       2
    ${Wellbores_Uploading_file_names}=      Read_Row_Values_and_store_In_List    User_Dashboard.xlsx      26       1      2         Portal
    ${Completion_DropDown_Selection}=       Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    27       2
    ${Completion_Search_Input}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    28       2
    ${Completion_Add_Comments}=             Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    29       2
    ${Completion_Attachments_URL_Name}=     Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    30       2
    ${Completion_Attachments_URL}=          Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    31       2
    ${Completion_Uploading_files}=          Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    32       2
    ${Completion_Uploading_file_names}=     Read_Row_Values_and_store_In_List    User_Dashboard.xlsx      33       1      2         Portal
    ${Toggle_option}=                       Read_Data_From_Excel_File    User_Dashboard.xlsx    Portal    34       2
    ${List_of_Search_Input}=                Read_Row_Values_and_store_In_List    User_Dashboard.xlsx      35       1      2         Portal

    #Set All variable as Global to access all Testcases
     set global variable    ${BROWSER}
     set global variable    ${Login_URL}
     set global variable    ${UserName}
     set global variable    ${Password}
     set global variable    ${Pads_DropDown_Selection}
     set global variable    ${Pads_Search_Input}
     set global variable    ${Pads_Add_Comments}
     set global variable    ${Pads_Attachments_URL_Name}
     set global variable    ${Pads_Attachments_URL}
     set global variable    ${Pads_Uploading_files}
     set global variable    ${Pads_Uploading_file_names}
     set global variable    ${WellOrigins_DropDown_Selection}
     set global variable    ${WellOrigins_Search_Input}
     set global variable    ${WellOrigins_Add_Comments}
     set global variable    ${WellOrigins_Attachments_URL_Name}
     set global variable    ${WellOrigins_Attachments_URL}
     set global variable    ${WellOrigins_Uploading_files}
     set global variable    ${WellOrigins_Uploading_file_names}
     set global variable    ${Well_bores_DropDown_Selection}
     set global variable    ${Well_bores_Search_Input}
     set global variable    ${Wellbores_Add_Comments}
     set global variable    ${Wellbores_Attachments_URL_Name}
     set global variable    ${Wellbores_Attachments_URL}
     set global variable    ${Wellbores_Uploading_files}
     set global variable    ${Wellbores_Uploading_file_names}
     set global variable    ${Completion_DropDown_Selection}
     set global variable    ${Completion_Search_Input}
     set global variable    ${Completion_Add_Comments}
     set global variable    ${Completion_Attachments_URL_Name}
     set global variable    ${Completion_Attachments_URL}
     set global variable    ${Completion_Uploading_files}
     set global variable    ${Completion_Uploading_file_names}
