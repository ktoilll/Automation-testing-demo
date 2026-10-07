*** Settings ***
Library     AppiumLibrary
Resource    ../../config/env.resource
Resource    ../../config/capabilities.resource


*** Keywords ***
Open Test Application
    Open Application    ${APPIUM_SERVER}
    ...    platformName=${PLATFORM_NAME}
    ...    appium:automationName=${AUTOMATION_NAME}
    ...    appium:deviceName=${DEVICE_NAME}
    ...    appium:app=${APP}
    ...    appium:autoGrantPermissions=${True}
    ...    appium:newCommandTimeout=300

Close Test Application
    Capture Page Screenshot
    Close Application
