*** Settings ***
Library     SeleniumLibrary

*** Variables ***
${BROWSER}      Chrome
${Login_URL}    https://www.facebook.com/login
${UserName}     your_username
${Password}     your_password

*** Keywords ***

Open Browser Facebook
    Open Browser    ${Login_URL}    ${BROWSER}
    Maximize Browser Window

Close Browser Facebook
    Close All Browsers

Open Login Page
    Go To    ${Login_URL}

Input UserName
    [Arguments]    ${UserName}
    Input Text    id=email    ${UserName}

Input Password
    [Arguments]    ${Password}
    Input Text    id=pass     ${Password}

Click login button
    Click Button    name=login

Click signout button
    Click Link    Logout

Error message should be visible
    Page Should Contain    The email address or mobile number you entered isn't connected to an account.

Home Page should be visible
    Page Should Contain    Home