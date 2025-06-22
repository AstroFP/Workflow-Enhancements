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

REM make a backup of Systempath and UserPath in case something goes wrong
REM note: using powershell for correct UTF-8 encoding
powershell -NoProfile -Command ^
    "Add-Content -Encoding UTF8 backupPath.txt '----------';" ^
    "Add-Content -Encoding UTF8 backupPath.txt '%date%';" ^
    "Add-Content -Encoding UTF8 backupPath.txt 'SystemPath:';" ^
    "Add-Content -Encoding UTF8 backupPath.txt \"!systemPath!\";" ^
    "Add-Content -Encoding UTF8 backupPath.txt 'UserPath:';" ^
    "Add-Content -Encoding UTF8 backupPath.txt \"!userPath!\""

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

