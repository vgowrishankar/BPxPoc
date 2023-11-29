*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library     SeleniumLibrary

*** Variables ***
${BROWSER}      Chrome
${URL}          https://www.facebook.com
${UserName}     your_username
${Password}     your_password

*** Test Cases ***
Open Browser To Login Page
    open browser        ${URL}  ${BROWSER}
    title should be     Facebook – log in or sign up
    input text          id=email    ${UserName}
    input password      id=pass     ${Password}
    click button        name=login
