*** Settings ***
Resource    ../Keywords/Common.robot
Resource    ../Locators/NavigationBarLocators.robot


*** Keywords ***
Navigate To Login Screen
    Click Element [Arguments] ${loginIcon} ${SMALL_RETRY_COUNT}