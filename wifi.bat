@echo off
setlocal enabledelayedexpansion

set "counter=0"

(
    for /f "skip=2 tokens=4,* delims=: " %%A in ('netsh wlan show profiles ^| findstr /i "All User Profile"') do (
        set "profileName=%%A"
        echo Retrieving key for !profileName!
        netsh wlan show profile "!profileName!" key=clear | findstr /i "Key Content"
        set /a "counter+=1"
    )
) > wifi_with_keys.txt

if !counter! lss 1 (
    echo No user profiles found.
) else (
    echo Found and retrieved keys for !counter! user profiles. Results saved to wifi_with_keys.txt.
)

pause
endlocal
