*** Settings ***
Library         AppiumLibrary   timeout=20   run_on_failure=Capture Page Screenshot
Library         Process
Resource        UC.robot
Resource        app_launcher.robot

*** Keywords ***
Begin Mobile Test
    [Arguments]  ${phone}   ${reset}=${false}
    #for cloud based devices we need not start/stop appium server
    IF    '${setup}' == 'cloud_env'
        Log  running tests on Lambda
    ELSE
        Start Appium Server  ${phone}
    END
    Print Message   Starting App on ${phone.name}
    Run Keyword If  ${reset} == ${false}  Launch android app  ${phone}  false
    ...    ELSE IF  ${reset} == ${true}  Launch android app  ${phone}

#Reason for using ${reset} == ${false} by deafult is, in cloud it will always be a fresh install for each suite.
#Each time the login will happen. A logic is introduced to perform a login if not already.
#With this configuration, in local there is no need to perform a login for each suite as ${reset} == ${false}

Begin 1 Mobile for Test
    [Documentation]   Its setup keyowrd which take phone argument. Default variables are taken from
    ...               properties file.
    [Arguments]   ${device}  ${user}
    start apps  ${device}
    Check login state and perform login if not already  ${user}

Begin 2 Mobiles for Test
    [Documentation]   Its setup keyowrd which take phone argument. Default variables are taken from
    ...               properties file.
    [Arguments]   ${device1}   ${device2}   ${first}=${user1}  ${second}=${user2}   ${reset}=${false}
    start apps   ${device1}
    retry   Check login state and perform login if not already  ${first}
    start apps   ${device2}
    retry   Check login state and perform login if not already  ${second}

Begin 2 Mobiles Guest Test
    [Documentation]   Its setup keyowrd which take phone argument. Default variables are taken from
    ...               properties file.
    [Arguments]   ${device1}   ${device2}   ${first}=${user1}  ${second}=${user2}   ${reset}=${false}
    start apps   ${device1}
    retry   Check login state and perform login if not already  ${first}
    start apps   ${device2}
    Check for permission pop up and Accept



Check login state and perform login if not already
    [Arguments]  ${user}
    Check for permission pop up and Accept
    ${status}=  Run Keyword And Return Status  Wait For Text      ${app_description}    1s
    Run Keyword If  ${status}  Run Keywords   UC.Login UC App  ${user}   AND   HomeScreen.verify home screen is launched
    ...                  ELSE  Print Message  Already logged in

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

Launch android app
    [Arguments]     ${phone}  ${fullReset}=true  ${app}=${ucbeta_app}
    Print Message       Launching ${app.pkg} App
    Run Keyword If   '${fullReset}'== 'true'  start apps  ${phone}
    ...  ELSE  Start app with reset  ${phone}  ${app}
        #app=${android_app.${env}}

start apps
    [Arguments]         ${phone}
    Print Message       Launching App freshly on ${phone.name} ${phone.version}
    IF    '${setup}' == 'cloud_env'
        Launch Application On LambdaTest     ${phone}
    ELSE
        Launch Application On Local Device   ${phone}
    END

Start app with reset
    [Arguments]         ${phone}  ${app}=${ucbeta_app}
    IF    '${setup}' == 'cloud_env'
        Launch Application On LambdaTest     ${phone}
    ELSE
        Launch Application On Local Device   ${phone}    false
    END

Start Appium Server
    [Arguments]  ${phone}
    Print Message   Starting Appium Server on port ${phone.port}
    Start Process   ${start_appium_cmd} ${phone.port}  shell=True  alias=appiumserver  stdout=${PROJECT_DIR}/tmp/appium_stdout.txt  stderr=${PROJECT_DIR}/tmp/appium_stderr.txt
    Process Should Be Running  appiumserver
    sleep  5s

Stop Appium Server
    Print Message   Killing Appium server
    Start Process  ${kill_appium_cmd}  shell=True  stdout=${PROJECT_DIR}/tmp/appium_kill_stdout.txt  stderr=${PROJECT_DIR}/tmp/appium_kill_stderr.txt




Turn OFF all network
    set network connection status  0
    Print Message  Turning OFF WiFi...

Turn ON Wifi
    set network connection status  2
    Print Message  Turning ON WiFi...
    wait  10

Switch to previous app from recent apps
    press keycode  187
    press keycode  21
    press keycode  66
    wait  2

Kill App From Background
    press keycode  187
    ${status} =  run keyword and return status  Wait For Element  id=com.sec.android.app.launcher:id/clear_all_button  2s
    run keyword if  ${status}  Tap Id  id=com.sec.android.app.launcher:id/clear_all_button  #Samsung
    ...                  ELSE  Tap Id  id=com.android.launcher3:id/clear_all_button         #Nokia
    Print Message  App killed from background

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

Launch TextNow App
    [Arguments]  ${phone}
    UIAction.Select Mobile   ${phone}
    Print Message  Launching TextNow app on ${phone.name}
#    Start Activity  ${textnow_app.pkg}  authorization.ui.LaunchActivity  #Activity for login screen
    Start Activity  ${textnow_app.pkg}  ${textnow_app.activity}

Launch Native Dialer
    [Arguments]  ${phone}
    UIAction.Select Mobile   ${phone}
    Print Message  Launching Native Dialer app on ${phone.name}
    Start Activity  ${native_dialer_app.pkg}  ${native_dialer_app.activity}

reset phones
    [Arguments]   ${phone1}   ${phone2}
    Print Message   reseting ${phone1.name}
    Launch Application On Local Device   ${phone1}   false
    Print Message   reseting ${phone2.name}
    Launch Application On Local Device   ${phone2}   false












Reset Device
    [Arguments]  ${device}
    Print Message  Resetting ${device.name}
    Launch Application On Local Device  ${device}  false

Reset Local Devices
    [Arguments]  ${device1}  ${device2}
    Reset Device  ${device1}
    Reset Device  ${device2}