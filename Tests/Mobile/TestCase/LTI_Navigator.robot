*** Settings ***
Resource         ../../../Resources/Mobile/Keywords/Common.robot



*** Test Cases ***
Launch LTI Application
    [Tags]
    Open Android Application
    Allow Notification
    Swipe    ${538}    ${1189}    ${538}    ${1635}




