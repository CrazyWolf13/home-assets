@echo off
::Writer
setlocal enableextensions enabledelayedexpansion
goto type1
:type2

set speed=1
set lines=11


set "line1= ooooo   ooooo                                                  oooooooooo.   o8o               .   oooo              .o8                             "
set "line2= `888'   `888'                                                  `888'   `Y8b  `'`             .o8   `888             '888                             "
set "line3=  888     888   .oooo.   oo.ooooo.  oo.ooooo.  oooo    ooo       888     888 oooo  oooo d8b .o888oo  888 .oo.    .oooo888   .oooo.   oooo    ooo      "
set "line4=  888ooooo888  `P  )88b   888' `88b  888' `88b  `88.  .8'        888oooo888' `888  `888''8P   888    888P'Y88b  d88' `888  `P  )88b   `88.  .8'       "
set "line5=  888     888   .oP'888   888   888  888   888   `88..8'         888    `88b  888   888       888    888   888  888   888   .oP'888    `88..8'        "
set "line6=  888     888  d8(  888   888   888  888   888    `888'          888    .88P  888   888       888 .  888   888  888   888  d8(  888     `888'         "
set "line7= o888o   o888o `Y888'''8o  888bod8P'  888bod8P'     .8'          o888bood8P'  o888o d888b     '888' o888o o888o `Y8bod88P' `Y888''8o     .8'          "
set "line8=                          888        888       .o..P'                                                                                .o..P'           "
set "line9=                         o888o      o888o      `Y8P'                                                                                 `Y8P'            "
set "line10= "
set "line11= "





for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"

for /L %%a in (1,1,%lines%) do set num=0&set "line=!line%%a!"&call :type

pause>nul
goto :EOF


:type1
echo Starting Tasks
ping localhost -n 2 >NUL
cls
echo .
ping localhost -n 1 >NUL
cls
echo ..
ping localhost -n 1 >NUL
cls
echo ...
ping localhost -n 1 >NUL
cls
echo .
ping localhost -n 1 >NUL
cls
echo ..
ping localhost -n 1 >NUL
cls
echo ...
ping localhost -n 1 >NUL
cls
echo Required Process Ready!
ping localhost -n 2 >NUL
cls
echo _
ping localhost -n 1 >NUL
cls
goto type2

:type

set "letter=!line:~%num%,1!"
if not "%letter%"=="" set /p "=a%bs%%letter%" <nul

for /L %%b in (1,%speed%,2) do rem
if "%letter%"=="" echo.&goto :EOF
set /a num+=1
goto :type