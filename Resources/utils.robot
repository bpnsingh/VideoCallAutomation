*** Settings ***
Documentation   Misc Keyword for the Project
Library         String
Library         OperatingSystem
Library         DateTime



*** Keywords ***
To TitleCase
    [Arguments]    ${text}
    ${res} =  convert to title case  ${text}
    [return]  ${res}

Check And Execute
    [Documentation]       ${passed}=  Run Keyword And Return Status  page should contain element     ${hd_call_title}
    ...                   Run Keyword If  ${passed}   Log To Console  Voila  ELSE  Handle Slow Network
    [Arguments]     @{args}
    ${passed}=  Run Keyword And Return Status   ${args}[0]  ${args}[1]
    Run Keyword If  ${passed}  log to console  ${args}[0] ${args}[1] is Success   ELSE    ${args}[2]



Verify Element is Present
    [Arguments]     ${locator}
    Print Message   Verify ${locator} is Present
    Page Should Contain Element    ${locator}

Verify Element is not Present
    [Arguments]     ${locator}
    Print Message   Verify ${locator} is not Present
    page should not contain element    ${locator}

Verify Text is not Present
    [Arguments]     ${text}
    Print Message   Verify ${text} is not Present
    Page Should Not Contain Text    ${text}

Verify Until Text is not Present
    [Arguments]     ${text}   ${wait}=20s
    Print Message   Waiting ${text} to disappear
    Wait Until Page Does Not Contain    ${text}   ${wait}

Verify Until element is not Present
    [Arguments]     ${ele}   ${wait}=20s
    Print Message   Waiting ${ele} to disappear
    Wait Until Page Does Not Contain Element    ${ele}   ${wait}


Verify Element Type
    [Arguments]    ${element}  ${type}  ${value}
    Print Message   Verifying ${element}'s ${type} is ${value}
    Wait For Element    ${element}
    Element Attribute Should Match  ${element}  ${type}    ${value}

Verify Element Visible
    [Arguments]    ${element}
    Print Message   Verifying ${element} is Visible
    Wait For Element      ${element}
    Element Should Be Visible  ${element}
    Element Should Be Enabled  ${element}



Verify text is Present
    [Arguments]     ${text}
    Print Message   Verify ${text} is Present
    Page Should Contain text    ${text}

Wait For Element
    [Arguments]     ${locator}    ${timeout}=20s
    Print Message   Waiting for ${locator} to get visible witin ${timeout}
    Wait Until Page Contains Element    ${locator}  ${timeout}

Wait For Text
    [Arguments]     ${locator}  ${timeout}=20s
    Print Message   Waiting for ${locator} to get visible witin ${timeout}
    Wait Until Page Contains    ${locator}  ${timeout}


Print Message
    [Arguments]   ${msg}
    Run Keyword If    "${log_level}" == "DEBUG"    compose message with timestamp   ${msg}

compose message with timestamp
    [Arguments]   ${msg}
    ${time}=  Get Current Date	result_format=datetime
    log to console   ${\n}${time}***** ${msg} *****

Capture Screen Recording
    Print Message   Starting Screen Recording
    ${pass}             Run Keyword And Return Status   Start Screen Recording
    Run Keyword If  ${pass}     Log  pass
    ...   ELSE   Log    Could not start screen recording

End Screen Recording
    Print Message   Stopping Screen Recording
    Run Keyword And Ignore Error    Remove Screen Recording If Pass

Remove Screen Recording If Pass
    ${filename}                     Stop Screen Recording
    Run Keyword If Test Passed      Remove File     ${filename}
    Run Keyword If Test Passed      Log             Screen recording not saved because test execution passed.

Switch Context
    ${ctx}=    Get Current Context
    Switch To Context    ${ctx}

wait
    [Arguments]    ${time}
    Print Message  sleeping for ${time}s
    sleep          ${time}s

Verify Text is Visible N times
    [Arguments]                  ${text}    ${n}=2
    Print Message        Verify ${text} is Visible ${n} times
    Wait For Element     //*[@text="${text}"]
    Xpath Should Match X Times     //*[@text="${text}"]   ${n}

Verify ele is Visible N times
    [Arguments]                  ${xpath}    ${n}=2
    Print Message        Verify ${xpath} is Visible ${n} times
    Xpath Should Match X Times     ${xpath}   ${n}


verify text is visible upto N times
    [Arguments]                  ${text}     ${n}=3
    Print Message        Verify ${text} is Visible upto ${n} times
    Wait For Element       //*[@text="${text}"]
    ${count}	Get Matching Xpath Count	//*[@text="${text}"]
    Should Be True   ${count}  >= ${n}

verify element is visible upto N times
    [Arguments]                  ${ele}     ${n}=3
    Print Message        Verify ${ele} is Visible upto ${n} times
    Wait For Element       ${ele}
    ${count}	Get Matching Xpath Count	${ele}
    Should Be True   ${count}  >= ${n}



Select element from elemnets
    [Arguments]      ${locator}  ${n}   ${long_press}=false
    @{elements}  Get Webelements	${locator}
    Run Keyword If   '${long_press}'=='false'  click element     ${elements}[${n}]
    ...  ELSE   Long Press    ${elements}[${n}]   3000

verify nth element from elements
    [Arguments]   ${locator}  ${n}  ${username}
    @{elements}  Get Webelements	${locator}
    Verify Element Type   ${elements}[${n}]  text   ${username}

retry
    [Arguments]    ${kw}  ${kw_argument}=${FALSE}
    Run Keyword If   ${kw_argument}     Wait Until Keyword Succeeds  3x  3s  ${kw}    ${kw_argument}
    ...   ELSE                          Wait Until Keyword Succeeds  3x  3s  ${kw}

