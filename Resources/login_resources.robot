*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://www.google.com
${UserName}     your_username
${Password}     your_password

*** Test Cases ***
Open Browser
    Open Browser    ${UserName}    ${Password}
    Maximize Browser Window

Close Browser
    Close All Browsers

Open Login Page
    Go To    ${Login_URL}

Input UserName
    [Arguments]    ${UserName}
    Input Text    id=email    ${UserName}

Input Password
    [Arguments]    ${Password}
    Input Password    id=pass     ${Password}

Click login button
    Click Button    name=login

Click signout button
    Click Link    Logout

Error message should be visible
    Page Should Contain    The email address or mobile number you entered isn't connected to an account.

Home Page should be visible
    Page Should Contain    Home