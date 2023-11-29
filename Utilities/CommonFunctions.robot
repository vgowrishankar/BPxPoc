*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://www.google.com

*** Keywords ***
Start test
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window

End test
    Close All Browsers
