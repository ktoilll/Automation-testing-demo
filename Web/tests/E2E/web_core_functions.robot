*** Settings ***
Library    SeleniumLibrary    WITH NAME    Web

Suite Teardown    Web.Close Browser


*** Variables ***
${BASE_URL}    https://the-internet.herokuapp.com
${BROWSER}     chrome


*** Test Cases ***
TC_001 Verify Login Success
    Open Page    /login
    Web.Input Text    id=username    tomsmith
    Web.Input Text    id=password    SuperSecretPassword!
    Web.Click Button    xpath=//button[@type="submit"]
    Web.Wait Until Page Contains    You logged into a secure area!    10s


TC_002 Verify Login Failed
    Open Page    /login
    Web.Input Text    id=username    wronguser
    Web.Input Text    id=password    wrongpass
    Web.Click Button    xpath=//button[@type="submit"]
    Web.Wait Until Page Contains    Your username is invalid!    10s


TC_003 Verify Checkbox Can Be Selected
    Open Page    /checkboxes
    Web.Select Checkbox    xpath=(//input[@type="checkbox"])[1]
    Web.Checkbox Should Be Selected    xpath=(//input[@type="checkbox"])[1]


TC_004 Verify Checkbox Can Be Unselected
    Open Page    /checkboxes
    Web.Unselect Checkbox    xpath=(//input[@type="checkbox"])[2]
    Web.Checkbox Should Not Be Selected    xpath=(//input[@type="checkbox"])[2]


TC_005 Verify Dropdown Option 1
    Open Page    /dropdown
    Web.Select From List By Label    id=dropdown    Option 1
    Web.List Selection Should Be    id=dropdown    Option 1


TC_006 Verify Dropdown Option 2
    Open Page    /dropdown
    Web.Select From List By Label    id=dropdown    Option 2
    Web.List Selection Should Be    id=dropdown    Option 2


TC_007 Verify Add Remove Element
    Open Page    /add_remove_elements/
    Web.Click Button    xpath=//button[text()="Add Element"]
    Web.Wait Until Element Is Visible    xpath=//button[text()="Delete"]    10s
    Web.Click Button    xpath=//button[text()="Delete"]
    Web.Wait Until Element Is Not Visible    xpath=//button[text()="Delete"]    10s


TC_008 Verify Multiple Add Elements
    Open Page    /add_remove_elements/
    Web.Click Button    xpath=//button[text()="Add Element"]
    Web.Click Button    xpath=//button[text()="Add Element"]
    Web.Click Button    xpath=//button[text()="Add Element"]
    ${count}=    Web.Get Element Count    xpath=//button[text()="Delete"]
    Should Be Equal As Integers    ${count}    3


TC_009 Verify Table Is Displayed
    Open Page    /tables
    Web.Wait Until Element Is Visible    id=table1    10s
    Web.Page Should Contain    Last Name
    Web.Page Should Contain    First Name
    Web.Page Should Contain    Email


TC_010 Verify First Row Data In Table
    Open Page    /tables
    ${last_name}=    Web.Get Text    xpath=//table[@id="table1"]/tbody/tr[1]/td[1]
    ${first_name}=   Web.Get Text    xpath=//table[@id="table1"]/tbody/tr[1]/td[2]
    Should Be Equal As Strings    ${last_name}     Smith
    Should Be Equal As Strings    ${first_name}    John


TC_011 Verify File Upload
    Open Page    /upload
    Web.Choose File    id=file-upload    ${CURDIR}/test_file.txt
    Web.Click Button    id=file-submit
    Web.Wait Until Page Contains    File Uploaded!    10s


TC_012 Verify Dynamic Loading
    Open Page    /dynamic_loading/1
    Web.Click Button    xpath=//button[text()="Start"]
    Web.Wait Until Page Contains    Hello World!    15s


*** Keywords ***
Open Page
    [Arguments]    ${path}
    Web.Open Browser    ${BASE_URL}${path}    ${BROWSER}
    Web.Maximize Browser Window