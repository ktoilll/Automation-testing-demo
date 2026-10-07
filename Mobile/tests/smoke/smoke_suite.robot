*** Settings ***
Resource         ../../resources/common/setup_teardown.resource
Test Setup       Open Test Application
Test Teardown    Close Test Application
Force Tags       smoke


*** Test Cases ***
SMOKE_001 Verify App Can Launch
    ${source}=    Get Source
    Should Not Be Empty    ${source}
