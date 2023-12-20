*** Settings ***
Library         SeleniumLibrary
Variables       ../../../Resources/Portal/PageObject/DataPortal_Pads.py
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
*** Variables ***
*** Test Cases ***
Validate_File_upload_functionality_via_Drag_Drop_File_From_local
    login_to_Portal
    sleep    5
    wait until element is visible    ${Pads_Tab}
    Wait For Condition    return document.readyState == "complete"
    click element    ${Pads_Tab}
    Pads_Filter_Function    Pad ID  Landgre






*** Keywords ***
login_to_Portal
    open browser    https://portal.stage.intranet.bpx.com/data-portal/well_origins  chrome   options=add_argument("--incognito");add_experimental_option("detach", True)
    maximize browser window
    wait until element is visible    id=i0116
    input text    id=i0116    SVC-AUTOFRAMEWORK-TEST-S@bpx.com
    click element    id=idSIButton9
    wait until element is visible    id=i0118
    input text    id=i0118  xGP&X8L6M2#9(f^$
    click element    idSIButton9