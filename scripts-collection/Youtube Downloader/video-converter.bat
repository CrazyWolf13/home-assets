@echo off
setlocal enabledelayedexpansion
echo __   __          _         _                             
echo \ \ / /__  _   _^| ^|_ _   _^| ^|__   ___                    
echo  \ V / _ \^| ^| ^| ^| __^| ^| ^| ^| '_ \ / _ \                   
echo   ^| ^| (_) ^| ^|_^| ^| ^|_^| ^|_^| ^| ^|_) ^|  __/                   
echo  _^|_^|\___/ \__,_^|\__^|\__,_^|_.__/ \___^|       _           
echo ^|  _ \  _____      ___ __ ^| ^| ___   __ _  __^| ^| ___ _ __ 
echo ^| ^| ^| ^|/ _ \ \ /\ / / '_ \^| ^|/ _ \ / _` ^|/ _` ^|/ _ \ '__^|
echo ^| ^|_^| ^| (_) \ V  V /^| ^| ^| ^| ^| (_) ^| (_^| ^| (_^| ^|  __/ ^|   
echo ^|____/ \___/ \_/\_/_^|_^| ^|_^|_^|\___/ \__,_^|\__,_^|\___^|_^|   
echo ^| __ ) _   _  ^|_   _^|__ ^| ^|__ (_) __ _ ___               
echo ^|  _ \^| ^| ^| ^|   ^| ^|/ _ \^| '_ \^| ^|/ _` / __^|              
echo ^| ^|_) ^| ^|_^| ^|   ^| ^| (_) ^| ^|_) ^| ^| (_^| \__ \              
echo ^|____/ \__, ^|   ^|_^|\___/^|_.__/^|_^|\__,_^|___/              
echo        ^|___/                                             
timeout /t 5 >NUL

cls
echo ======================================================================================================
echo.
echo With this Script you can download any Youtube Video and convert it to a local file.
echo.
echo ======================================================================================================
echo.
timeout /t 4 >NUL
cls
echo ======================================================================================================
echo.
echo The Script will now check if yt-dlp and it's dependencies are installed.
echo.
echo ======================================================================================================
echo.
timeout /t 4 >NUL
cls
echo   ____ _               _    _             
echo  / ___^| ^|__   ___  ___^| ^| _(_)_ __   __ _ 
echo ^| ^|   ^| '_ \ / _ \/ __^| ^|/ / ^| '_ \ / _` ^|
echo ^| ^|___^| ^| ^| ^|  __/ (__^|   ^<^| ^| ^| ^| ^| (_^| ^|
echo  \____^|_^| ^|_^|\___^|\___^|_^|\_\_^|_^| ^|_^|\__, ^|
echo                                     ^|___/ 
echo.
timeout /t 3 >NUL
cls


if "%PATH%"=="%PATH:yt-dlp=%" (
    goto ytdlp-installation
) else (
    goto ffmpeg-check
)


:ffmpeg-check
if "%PATH%"=="%PATH:ffmpeg=%" (
    goto ytdlp-installation
) else (
    goto ytdlp-available
)

:ytdlp-installation
echo  _____     _ _          _                                                     
echo ^|  ___^|_ _(_) ^| ___  __^| ^|                                                    
echo ^| ^|_ / _` ^| ^| ^|/ _ \/ _` ^|                                                    
echo ^|  _^| (_^| ^| ^| ^|  __/ (_^| ^|                                                    
echo ^|_^|__\__,_^|_^|_^|\___^|\__,_^|               ___           _        _ _           
echo / ___^|^| ^|_ __ _ _ __^| ^|_(_)_ __   __ _  ^|_ _^|_ __  ___^| ^|_ __ _^| ^| ^| ___ _ __ 
echo \___ \^| __/ _` ^| '__^| __^| ^| '_ \ / _` ^|  ^| ^|^| '_ \/ __^| __/ _` ^| ^| ^|/ _ \ '__^|
echo  ___) ^| ^|^| (_^| ^| ^|  ^| ^|_^| ^| ^| ^| ^| (_^| ^|  ^| ^|^| ^| ^| \__ \ ^|^| (_^| ^| ^| ^|  __/ ^|   
echo ^|____/ \__\__,_^|_^|   \__^|_^|_^| ^|_^|\__, ^| ^|___^|_^| ^|_^|___/\__\__,_^|_^|_^|\___^|_^|   
echo                                  ^|___/                                        
echo.
timeout /t 5 >NUL
cls
winget install yt-dlp.yt-dlp
winget install gyan.ffmpeg
timeout /t 4
cls
echo ======================================================================================================
echo.
echo The Script will now exit, please start it again.
echo.
echo ======================================================================================================
echo.
timeout /t 5 >NUL
exit

:ytdlp-available
echo  ____                              
echo / ___^| _   _  ___ ___ ___  ___ ___ 
echo \___ \^| ^| ^| ^|/ __/ __/ _ \/ __/ __^|
echo  ___) ^| ^|_^| ^| (_^| (_^|  __/\__ \__ \
echo ^|____/ \__,_^|\___\___\___^|^|___/___/
echo.
timeout /t 5 >NUL
cls

echo  _   _           _       _   _                                 
echo ^| ^| ^| ^|_ __   __^| ^| __ _^| ^|_(_)_ __   __ _                     
echo ^| ^| ^| ^| '_ \ / _` ^|/ _` ^| __^| ^| '_ \ / _` ^|                    
echo ^| ^|_^| ^| ^|_) ^| (_^| ^| (_^| ^| ^|_^| ^| ^| ^| ^| (_^| ^|                    
echo  \___/^| .__/ \__,_^|\__,_^|\__^|_^|_^|_^|_^|\__, ^|        _           
echo ^|  _ \^|_^|__ _ __   ___ _ __   __^| ^| _^|___/__   ___(_) ___  ___ 
echo ^| ^| ^| ^|/ _ \ '_ \ / _ \ '_ \ / _` ^|/ _ \ '_ \ / __^| ^|/ _ \/ __^|
echo ^| ^|_^| ^|  __/ ^|_) ^|  __/ ^| ^| ^| (_^| ^|  __/ ^| ^| ^| (__^| ^|  __/\__ \
echo ^|____/ \___^| .__/ \___^|_^| ^|_^|\__,_^|\___^|_^| ^|_^|\___^|_^|\___^|^|___/
echo            ^|_^|                                                 
echo.
echo.
timeout /t 5 >NUL
yt-dlp -U 
winget update ffmpeg
cls


:download
cls
set "mp3_format=-x --audio-format mp3"
set "mp4_format=-S res,ext:mp4:m4a --recode mp4"
set "mp4a_format=-x --audio-format m4a"
set "default="

cls
echo ======================================================================================================
echo.
echo Choose your desired output format (mp3, mp4, m4a, default) 
echo.
echo ======================================================================================================
echo.
set /p "format=> "
cls

if "%format%"=="mp4" (
    set "file_format=%mp4_format%"
)
if "%format%"=="mp3" (
    set "file_format=%mp3_format%"
)
if "%format%"=="m4a" (
    set "file_format=%mp4a_format%"
)
if "%format%"=="default" (
    set "file_format=%default%"
)

cls
echo ======================================================================================================
echo.
echo Enter the URL to the Youtube Video: 
echo.
echo ======================================================================================================
echo.
set /p "link=> "
cls
echo.
echo Starting yt-dlp, this may take a moment...
echo.
echo ----------------------------------------
echo.
yt-dlp %file_format% %link%
pause
cls
echo ======================================================================================================
echo.
echo Exit [e]
echo Download another Video [d]
echo.
echo ======================================================================================================
echo.
set /p "exit=> "
if "%exit%"=="e" (
    exit
)
if "%exit%"=="d" (
    goto download
)
pause
