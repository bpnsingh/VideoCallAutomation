*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot

*** Variables ***
${outside_control_id}    id=com.whatsapp:id/touch_outside
${end_call_id}           id=com.whatsapp:id/footer_end_call_btn


*** Keywords ***
verify call is initiated
    [Arguments]       ${name}
    Wait For Text     ${name}

accept video call
    [Arguments]     ${name}
    UIAction.Lock Screen
    Wait For Text      ${name}
    #to accept call with keycode
    UIAction.accept call with keycode

launch call controls
    tap id     ${outside_control_id}

end call
    tap id     ${end_call_id}


