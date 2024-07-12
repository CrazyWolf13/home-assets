@echo off 

rem Code to allow colored text in CMD
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

rem Make header Green
color 0a
echo                 _              _ _       _      _____           _       _ 
echo      /\        ^| ^|            (_) ^|     ^| ^|    / ____^|         (_)     ^| ^|    
echo     /  \  _   _^| ^|_ ___  _ __  _^| ^| ___ ^| ^|_  ^| (___   ___ _ __ _ _ __ ^| ^|_   
echo    / /\ \^| ^| ^| ^| __/ _ \^| '_ \^| ^| ^|/ _ \^| __^|  \___ \ / __^| '__^| ^| '_ \^| __^|  
echo   / ____ \ ^|_^| ^| ^|^| (_) ^| ^|_) ^| ^| ^| (_) ^| ^|_   ____) ^| (__^| ^|  ^| ^| ^|_) ^| ^|_   
echo  /_/    \_\__,_^|\__\___/^| .__/^|_^|_^|\___/ \__^| ^|_____/ \___^|_^|  ^|_^| .__/ \__^|  
echo  ^| ^|           ^|__   __^|^| ^| ^|   (_)                              ^| ^|          
echo  ^| ^|__  _   _     ^| ^| __^|_^| ^|__  _  __ _ ___                     ^|_^|          
echo  ^| '_ \^| ^| ^| ^|    ^| ^|/ _ \^| '_ \^| ^|/ _` / __^|                                 
echo  ^| ^|_) ^| ^|_^| ^|    ^| ^| (_) ^| ^|_) ^| ^| (_^| \__ \                                 
echo  ^|_.__/ \__, ^|    ^|_^|\___/^|_.__/^|_^|\__,_^|___/                                 
echo          __/ ^|                                                                
echo         ^|___/    
timeout /t 5 >NUL
rem Reset color to default
color 0f

rem Colorcodes
rem    0 = Schwarz        8 = Dunkelgrau
rem    1 = Dunkelblau     9 = Blau
rem    2 = Dunkelgrün     A = Grün
rem    3 = Blaugrün       B = Zyan
rem    4 = Dunkelrot      C = Rot
rem    5 = Lila           D = Magenta
rem    6 = Ocker          E = Gelb
rem    7 = Hellgrau       F = Weiß

rem Script begins here

:ask1
cls
echo.
call :ColorText 6f "======================================================================================================"
echo.
call :ColorText 6f "This Script will ask for Admin Priviledges and a internet connection is neccessary                    I"
echo.
call :ColorText 6f "Attention on the American Keyboard layout "y" is "z"!                                                 I"
echo.
call :ColorText 6f "======================================================================================================"
echo.
set /p "ready= Are those requirements met? [y/n]: "
if /I "%ready%" == "y" goto ask2
goto eof

:ask2
cls
echo.
call :ColorText 6f "======================================================================================================"
echo.
call :ColorText 6f "Please make sure both Scripts are in the folder Autopilot-Script located in the USB-Root Folder      I"
echo.
call :ColorText 6f "======================================================================================================"
echo.
set /p "ready= Are those requirements met? [y/n]: "
if /I "%ready%" == "y" goto check1
goto eof

:check1
cls
call :ColorText 0a "Checking Internet Access..."
timeout /t 2 >NUL
cls
echo.
ping -n 4 github.com >nul
if %errorlevel% equ 0 (
    goto check2
) else (
    echo.
    echo.
    call :ColorText 4f "======================================================================================================"
    echo.
    call :ColorText 4f "Could not connect to the internet, Github.com                                                        I"
    echo.
    call :ColorText 4f "======================================================================================================"
    echo.
    pause
    goto ask1
)

:check2
cls
call :ColorText 0a "Checking if Helper Script exists..."
timeout /t 2 >NUL
cls
IF EXIST "helper_autopilotidextractor.ps1" (
  goto check3
) ELSE (
   echo.
   echo.
   call :ColorText 4f "======================================================================================================"
   echo.
   call :ColorText 4f "Could not find the file 'helper_autopilotidextractor.ps1' in the current directory                   I"
   echo.
   call :ColorText 4f "======================================================================================================"
   echo.
   pause
   goto ask2
)

:check3
cls
call :ColorText 0a "Checking if the Folder-Names are correct..."
timeout /t 2 >NUL
cls
echo.
set "expectedPath=%~d0\Autopilot-Script\%~nx0"
if "%expectedPath%"=="%~f0" (
 goto execution
) ELSE (
   echo.
   call :ColorText 4f "======================================================================================================"
   echo.
   call :ColorText 4f "The Scripts are not in the correct directory.                                                        I"
   echo.
   call :ColorText 4f "======================================================================================================"
   echo.
   pause
   goto ask2
)


:execution
cls
call :ColorText 0a "Executing the Helper Script..."
timeout /t 2 >NUL
cls
echo.
cd /d %~dp0
rem remove old HWID folder
rmdir /s /q HWID >nul 2>&1
rem execute command
PowerShell.exe -Command "Start-Process PowerShell -Verb RunAs -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File \"%~dp0helper_autopilotidextractor.ps1\"'
rem Change directory to userprofile and save drive letter to temp file.
cd /d "%USERPROFILE%"
SET drive_path=%~dp0
echo %drive_path:~0,2% > drive_path.txt

rem Code for custom colored text
goto :eof
:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof

endlocal