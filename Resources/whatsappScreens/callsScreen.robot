*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot

*** Variables ***
${calls_tab}        accessibility_id=Calls
${video_call_id}    accessibility_id=Video call
*** Keywords ***
select calls tab
    tap id    ${calls_tab}

select video call
    tap id    ${video_call_id}

verify call is established
    [Arguments]       ${name}
    Wait For Text     ${name}

verify call screen is launched
    wait for element       ${calls_tab}
