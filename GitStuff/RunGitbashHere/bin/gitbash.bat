@echo off
setlocal enabledelayedexpansion

set "originalPath=%CD%"

for /f "delims=" %%G in ('where git.exe') do (
   for %%A in ("%%G") do (
      set gitPath=%%~dpA
   )  
)

REM redirection from Git\cmd to Git\
set gitPath=!gitPath!
cd /d "%gitPath%"
cd ..
set gitPath=%cd%

start "" "%gitPath%\git-bash.exe" --cd=%originalPath%
