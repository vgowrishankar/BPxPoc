*** Settings ***
Documentation     Simple example using SeleniumLibrary.
Library           SeleniumLibrary
Variables         ../../Resources/PageObject/Login_Page.py

*** Variables ***
${BROWSER}      Chrome
${URL}          https://www.facebook.com
${UserName}     your_username
${Password}     your_password

*** Test Cases ***
Open Browser To Login Page
    open browser        ${URL}  ${BROWSER}
    title should be     Facebook – log in or sign up
    input text          ${Login_page_username}    ${UserName}
    input password      ${Login_page_password}     ${Password}
    click button        ${Login_page_login_btn}




