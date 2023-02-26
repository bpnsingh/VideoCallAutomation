*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot
Resource        ../Resources/whatsapp.robot
Force Tags      regression   smoke   cloud

Suite Setup     Common.Begin 2 Mobiles for Test  ${D2}  ${D1}
Suite Teardown  Common.End Mobile Test

*** Test Cases ***
WA_001_Make a video call from app
    [Documentation]      This TC make a video call from Calls tab
    [Tags]    videocall
    UIAction.Select Mobile   ${D1}
    tap id    accessibility_id=Calls
    tap id    accessibility_id=Video call
    Wait For Text     iPhone Pstn 11

WA_002_Receive a video call from app
    [Documentation]      This TC make a video call from Calls tab
    [Tags]    videocall
    UIAction.Select Mobile   ${D2}
    Press Keycode      26
    Wait For Text      F62
    Press Keycode      5
    UIAction.Select Mobile   ${D1}
    wait       10
    tap id     id=com.whatsapp:id/touch_outside
    tap id     com.whatsapp:id/footer_end_call_btn

