*** Settings ***
Documentation   Page Object in Robot Framework
Library         SeleniumLibrary
Resource        ../../../Resources/Portal/Keywords/DataPortal_Pads.robot
Resource        ../../../Resources/Portal/Keywords/DataPortal_Wells.robot

*** Variables ***
${site_url}     http://portal.intranet.bpx.com/
${browser}      Chrome

*** Test Cases ***
Verify Successful Login to BPx Data Portal
    [Documentation]    This test case verifies that the user is able to successfully Login and Logout to BPx Data Portal using Page Object
    [Tags]    Smoke
    Open Browser  ${site_url}  ${browser}
    Input Pad Name
    Input Well Name
    Click Refresh Table
    Close Browser

*** Keywords ***