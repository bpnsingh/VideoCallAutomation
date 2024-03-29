*** Variables ***
#possible values android or iOS
${mob}                         android
#possible values for env are beta,stag,prod
${env}                         beta
${PROJECT_DIR}                 ${EXECDIR}
${stdout_file}                 ${PROJECT_DIR}/Report/appium_stdout.txt
${stderror_file}               ${PROJECT_DIR}/Report/appium_stdout.txt
${REMOTE_URL}                 http://127.0.0.1:4723/wd/hub
&{CHROME_APKINFO}             pkg=com.android.chrome
                         ...  activity=com.google.android.apps.chrome.Main
${kill_appium_cmd}            ps -aef|grep appium|grep -v grep|awk '{print $2}'|xargs kill -9
${start_appium_cmd}           /usr/local/bin/appium -a 127.0.0.1 -p
${start_appium_cmd_autodownlaod}           /usr/local/bin/appium --allow-insecure chromedriver_autodownload
${chromedriverExecutableDir}   ${PROJECT_DIR}/tmp
