@echo off
@color 0A
@mode con:cols=120 lines=45
setlocal enabledelayedexpansion

set /p ver=<rarversion.txt
set /a newver=%ver%+1
set url=https://www.rarlab.com/rar/winrar-x64-%newver%.exe
echo Testing !url!
echo.
echo.
start /wait wget.exe -q --spider !url!
rem echo %ERRORLEVEL%
if errorlevel 8 (
    echo No newer version of WinRAR found. Latest recorded %ver%
    goto :exit
)
if errorlevel 0 (
    echo Possible newer version of WinRAR found. Downloading..
    start /wait wget.exe --tries=5 --timeout=30 --retry-connrefused !url!
    echo %newver% > rarversion.txt
    echo.
    echo winrar-x64-%newver%.exe
)
echo 
echo 
timeout /t 10
:exit