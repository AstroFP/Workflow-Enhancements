@echo off
setlocal enabledelayedexpansion

set scriptPath=%cd%\bin

REM getting systemPATH (ensures the spaces get counted)
for /f "usebackq skip=2 delims=" %%j in (`
    reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path
`) do (
    set rawLine=%%j
)
for /f "tokens=2*" %%a in ("!rawLine!") do set systemPath=%%b

REM getting userPATH (ensures the spaces get counted)
for /f "usebackq skip=2 delims=" %%j in (`
    reg query HKCU\Environment /v Path
`) do (
    set rawLine=%%j
)
for /f "tokens=2*" %%a in ("!rawLine!") do set userPath=%%b

REM Removing \ at the end (if exists) to ensure the path variables will pass corectly in powershell script call
if not "!systemPath!"=="!systemPath:~0,3!" (
    if "!systemPath:~-1!"=="\" (
        set "systemPath=!systemPath:~0,-1!"
    )
)
if not "!userPath!"=="!userPath:~0,3!" (
    if "!userPath:~-1!"=="\" (
        set "userPath=!userPath:~0,-1!"
    )
)

REM make a backup of Systempath and UserPath in case something goes wrong
REM note: using powershell for correct UTF-8 encoding(i didnt wanna play with cmd anymore XD)
powershell -NoProfile -ExecutionPolicy Bypass -File "logIntoBackup.ps1" -SystemPath "!systemPath!" -UserPath "!userPath!"

echo %PATH% | find /I "%scriptPath%" > nul
if errorlevel 1 (
    echo variable path does not yet exist
    echo creating a PATH variable...

    REM im done with cmd, from now on im doing everything in powershell XD
    powershell -NoProfile -ExecutionPolicy Bypass -File "updateUserPATH.ps1" -NewVariable "%scriptPath%"

    REM Current CMD isntance won't see updated PATH 
    REM we're restarting to prevent a duplicate entry in PATH
    echo EXITING IN 5 SECOND ...
    timeout /t 5
    exit
) else (
    echo variable path is already setup
)

