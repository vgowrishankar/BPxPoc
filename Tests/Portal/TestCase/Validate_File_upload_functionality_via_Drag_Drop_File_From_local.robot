*** Settings ***
Library         SeleniumLibrary
Library         ../../../Resources/Portal/PageObject/Locators.py

Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
#Resource        ../../../Resources/Portal/Keywords/login_resources.robot
Library         ../../../Resources/Portal/PageObject/Locators.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_LogIn.robot
Library         ../../../Resources/Portal/Keywords/Custome_Methods.py


*** Variables ***
@{keys}=        ${EMPTY}     padname      padid       businessunit        fine
${file_input}=    "C:${/}Users${/}10712370${/}PycharmProjects${/}pythonProject${/}BPxPoc${/}selenium-screenshot-1.png"

*** Test Cases ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    Data Portal MFA Login
    sleep    10
    wait until element is visible    ${Pads_Tab}
    click element    ${Pads_Tab}
    Pads_Filter_Function_using_Arrow     gre
    Custome_Methods.minwindow
    sleep    5
    click element        ${Pads_Table_only_Padname_Value}
    sleep    5
    Select_side_panel
    wait until element is visible     ${Pads_Ex_Tab_Pad_data_Attachemnts}
    click element        ${Pads_Ex_Tab_Pad_data_Attachemnts}
    sleep    5
    #Upload_Document_using_Drag_Drop         ${Pads_Ex_Tab_Pad_data_Attachements_first_upload_area}          ${file_input}
    Simulate Drag and Drop        ${Pads_Ex_Tab_Pad_data_Attachements_first_upload_area}          ${file_input}








*** Keywords ***


Upload_Document_using_Drag_Drop
    [Arguments]    ${source_locator}        ${targeted}
    ${source}=      get webelement    ${source_locator}
    #${target}=      get webelement    ${targeted}
    ${action}=      evaluate    seleniumlibrary.create webdriver.common.action_chains.ActionChains(driver).drag_and_drop(${source},${targeted})
    [Return]     ${action}

Simulate Drag and Drop
    [Arguments]    ${target_element}    ${file_path}
    Execute JavaScript        arguments[0].style.display = 'block';    # Display drop area if hidden
    ${source_position}=    Evaluate    [window.innerWidth/2, window.innerHeight/2]    # Center of the window
    ${target_position}=    Get Element Position    ${target_element}
    Execute JavaScript    var dropEvent = new DragEvent('drop', { bubbles: true, dataTransfer: { files: [new File(['${file_path}'], 'document.pdf')] } });
                          dropEvent.clientX = ${target_position}[0];
                          dropEvent.clientY = ${target_position}[1];
                          document.dispatchEvent(dropEvent);
    Sleep    2s   # Add a delay to ensure the drop event is processe