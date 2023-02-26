*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot
Library         Process
Resource        app_launcher.robot

*** Keywords ***
Begin 2 Mobiles for Test
    [Documentation]   Its setup keyowrd which take phone argument. Default variables are taken from
    ...               properties file.
    [Arguments]   ${device1}   ${device2}
    start apps   ${device1}
    start apps   ${device2}

Launch Android App2
    [Arguments]  ${phone}
    UIAction.Select Mobile   ${phone}
    Print Message  Launching application
    Launch Application

Launch Apps
    [Arguments]  ${device1}  ${device2}
    Launch Android App2  ${device1}
    Launch Android App2  ${device2}

Quit Android App
    [Arguments]  ${phone}
    UIAction.Select Mobile   ${phone}
    Print Message  Quitting application
    Quit Application

Quit Apps
    [Documentation]   Its setup keyowrd which take phone argument. Default variables are taken from
    ...               properties file.
    [Arguments]   ${device1}   ${device2}
    Quit Android App  ${device1}
    Quit Android App  ${device2}

End Mobile Test
    Print Message   Closing all application
    Run Keyword And Ignore Error  close all applications
    IF    '${setup}' == 'cloud_env'
        Log  running tests on Lambda
    ELSE
        Stop Appium Server
    END


start apps
    [Arguments]         ${phone}
    Print Message       Launching App freshly on ${phone.name} ${phone.version}
    IF    '${setup}' == 'cloud_env'
        Launch Application On LambdaTest     ${phone}
    ELSE
        Launch Application On Local Device   ${phone}
    END

Start Appium Server
    [Arguments]  ${phone}
    Print Message   Starting Appium Server on port ${phone.port}
    Start Process   ${start_appium_cmd} ${phone.port}  shell=True  alias=appiumserver  stdout=${stdout_file}  stderr=${stderror_file}
    Process Should Be Running  appiumserver
    sleep  5s

Stop Appium Server
    Print Message   Killing Appium server
    Start Process  ${kill_appium_cmd}  shell=True  stdout=${stdout_file}  stderr=${stderror_file}





Accept permission
    ${status} =  run keyword and return status  Wait For Element  id=com.android.permissioncontroller:id/permission_allow_button  0s
    run keyword if  ${status}  Tap Id  id=com.android.permissioncontroller:id/permission_allow_button  #Android 10
    ...  ELSE  Tap Id  id=com.android.permissioncontroller:id/permission_allow_foreground_only_button  #Android 11
    Print Message  Allowing permission

Check for permission pop up and Accept
    ${status}=  Run Keyword And Return Status  Wait For Element  id=com.android.permissioncontroller:id/content_container  3s
    Run Keyword If  ${status}  Accept Permission
    ...       ELSE  Print Message  Permission already granted

dismiss new control pop up
    ${status}=  Run Keyword And Return Status  Wait For Element     ${newcontrol_popup}  1s
    Run Keyword If  ${status}  tap id   ${newcontrol_popup}
    ...       ELSE  Print Message  No pop up shown

Check for camera pop up and Accept
    Run Keyword and Ignore Error   tap text  CONTINUE











