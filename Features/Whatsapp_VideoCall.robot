*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot
Resource        ../Resources/whatsapp.robot
Force Tags      regression   smoke   cloud

Suite Setup     Common.Begin 2 Mobiles for Test  ${D2}  ${D1}
Suite Teardown  Common.End Mobile Test

*** Variables ***
${callee_name}      iPhone Pstn 11
${caller_name}      F62

*** Test Cases ***
WA_001_Make a video call from app
    [Documentation]      This TC make a video call from Calls tab
    [Tags]    videocall
    UIAction.Select Mobile   ${D1}
    callsScreen.select calls tab
    callsScreen.select video call
    activeCallScreen.verify call is initiated   ${callee_name}


WA_002_Receive a video call from app
    [Documentation]      This TC make a video call from Calls tab
    [Tags]    videocall
    UIAction.Select Mobile   ${D2}
    activeCallScreen.accept video call      ${caller_name}
    UIAction.Select Mobile   ${D1}
    wait       10
    activeCallScreen.launch call controls
    activeCallScreen.end call
    callsScreen.verify call screen is launched
    UIAction.Select Mobile   ${D2}
    callsScreen.verify call screen is launched
