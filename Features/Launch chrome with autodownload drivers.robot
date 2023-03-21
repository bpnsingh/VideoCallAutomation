*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot
Resource        ../Resources/chrome.robot
Force Tags      regression   smoke   cloud

Suite Setup     launch chrome in local device  ${D2}
Suite Teardown  Common.End Mobile Test

*** Variables ***
${link}      https://www.linkedin.com/in/bipinsengar/

*** Test Cases ***
CH_001_Linkedin_Deeplik_verification
    [Documentation]      This TC open lnikedin link
    [Tags]    deeplink
    Print Message    Opening ${link}
    Go To Url     ${link}
    Switch To Context    NATIVE_APP
    Print Message     waiting for 10 seconds
    sleep        10s
    Get Source
