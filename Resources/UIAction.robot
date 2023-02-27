*** Settings ***
Documentation   This file includes all  UI Action for this project
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot


*** Keywords ***
tap id
    [Arguments]  ${id}   ${wait}=20s   ${delay}=True
    wait until page contains element  ${id}   ${wait}
    Print Message   tapping on ${id}
    CLICK ELEMENT  ${id}
#    Run Keyword If  '${delay}' == 'True'   sleep  3s

tap text
    [Arguments]    ${text}   ${wait}=20s   ${delay}=True   ${exactMatch}=True
    wait until page contains   ${text}    ${wait}
    Print Message   tapping on ${text}
    click text  ${text}   ${exactMatch}
#    Run Keyword If  '${delay}' == 'True'   sleep  3s

Swipe Down
    #Swipe    418    1370    418    670
    Print Message    swiping down
    Run Keyword And Ignore Error   swipe by percent    50    80    50    20    2000


Swipe Up
    Swipe    418    0       418     670

Tap on Screen
    Print Message    tapping on middle of screen
    click a point    500  700    2000

Refresh App
#    Swipe    418    300       418     670
    swipe by percent  50  30  50  60

Kill Appium
    Print Message   Stopping Appium  Server
    stop appium server

Select Mobile
    [Arguments]  ${phonename}
    #sleep    2s
    Print Message   Switching to ${phonename.name}
    switch application  ${phonename.name}

Fill Input
    [Arguments]  ${locator}  ${text}
    Wait For Element       ${locator}
    Print Message   filling up ${text}
    Input Text  ${locator}  ${text}

Lock Screen
    Print Message     locking phone
    Press Keycode      26

Put App on Background
    Press Keycode     3

Go Back one screen
    Press Keycode     4

Enter Digit One
    Print Message     Sending 1 . . .
    Press Keycode     8

select digit from keypad
    [Arguments]    ${number}
    Press Keycode    ${keycode.${number}}

enter user digits
    [Arguments]    ${string_digit}
    @{list_digit}=  Split String   ${string_digit}
    FOR  ${digit}  IN  @{list_digit}
        Print Message    Pressing key code for digit ${digit}
        Press Keycode    ${keycode.${digit}}
    END
    #If more than one similiar name are present in compmay , for that scenario
    wait      3
    Run Keyword If  '${runner}' == 'bipin'  Run Keyword And Ignore Error   Press Keycode    ${keycode.one}
    ...                               ELSE  Run Keyword And Ignore Error   Press Keycode    ${keycode.two}

Send Enter
    Print Message     Sending enter
    Press Keycode    66

Get Random Message
    ${string}=   randomString
    [return]     ${string}

Chenge To Web Context
    #sleep    10s
    ${ctx}=    Get Current Context
    Print Message   Switching to ${ctx}
    Switch To Context    ${ctx}

    
Toggle Button
    [Arguments]     ${btn_name}
    tap id          ${btn_name}



Clear Notification
    [Documentation]      test
    ${appium}=  Get Library Instance    AppiumLibrary
    Evaluate    $appium._current_application().open_notifications()
    wait      2
    ${flag}=  Run Keyword And Return Status  Page Should Contain Element   //*[@text="Clear all"]
    Run Keyword If  ${flag}  tap id   //*[@text="Clear all"]  ELSE  Tap Clear All

getDeviceTime
    ${appium}=  Get Library Instance    AppiumLibrary
    ${time}=  Evaluate    $appium._current_application().get_device_time()
    [Return]   ${time}


set landscape
    [Arguments]   ${device}
    Print Message   setting ${device.name} to landscape mode
    Landscape

set portrait
    [Arguments]   ${device}
    Print Message   setting ${device.name} to portrait mode
    Portrait

accept call with keycode
    Press Keycode      5


