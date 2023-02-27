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








