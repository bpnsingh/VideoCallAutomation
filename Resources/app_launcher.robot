*** Settings ***
Library         AppiumLibrary   timeout=30   run_on_failure=Capture Page Screenshot

*** Keywords ***
Launch Application On Local Device
    [Arguments]  ${phone}  ${apk_info}=${WHATSAPP_APKINFO}  ${no_reset}=true        #Values for no_reset: true, false
    Start Appium Server  ${phone}
    Open Application  http://127.0.0.1:${phone.port}/wd/hub  alias=${phone.name}  deviceName=${phone.name}
         ...          udid=${phone.udid}  platformName=${phone.platformName}  platformVersion=${phone.version}
         ...          appActivity=${apk_info.activity}  appPackage=${apk_info.pkg}  noReset=${no_reset}
         ...          newCommandTimeout=600  automationName=UiAutomator2
         ...          unicodeKeyboard=true  resetKeyboard=true

Launch Application On LambdaTest
    [Arguments]  ${phone}
    Open Application  https://${lambdatest.user}:${lambdatest.key}@mobile-hub.lambdatest.com/wd/hub  alias=${phone.name}
         ...          visual=true  devicelog=true  isRealMobile=true   idleTimeout=500  queueTimeout=500
         ...          platformName=android    noReset=true       deviceName=${phone.name}
         ...          unicodeKeyboard=true  resetKeyboard=true  app=${lambdatest.app}  deviceOrientation=portrait
         ...          project=DM_Android  build=${lambdatest.build}  name=${SUITE NAME}     console=true  region=US