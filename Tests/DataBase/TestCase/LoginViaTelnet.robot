*** Settings ***
Library         Telnet

*** Variables ***
${USER_NAME}        <username>
${PASSWORD}         <password>
${IP_ADDRESS}       127.0.0.1         #<ip address>
${PORT}             <port>

*** Keywords ***
Open Device CLI via TELNET
    Open Connection  ${IP_ADDRESS}
    Write     admin
    ${output}=	Read Until  Password:
    Write     ${PASSWORD}
    ${output}=	Read Until  CLI# 

*** Test Cases ***
Connect Device via TELNET
    Open Device CLI via TELNET 
    Write  sh ru
    ${output}=	Read Until  end 