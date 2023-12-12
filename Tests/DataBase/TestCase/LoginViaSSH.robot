*** Settings ***
Library         SSHLibrary

*** Variables ***
${USER_NAME}        <username>
${PASSWORD}         <password>
${IP_ADDRESS}       127.0.0.1         #<ip address>
${PORT}             <port>

*** Keywords ***
Open Device CLI via SSH
    Open Connection  ${IP_ADDRESS}
    Enable SSH Logging  ssh.log
    Login  ${USER_NAME}  ${PASSWORD}

*** Test Cases ***
Connect Device via SSH
    Open Device CLI via SSH
    Write  sh ru
    ${output}=	Read Until  end