@echo off
title Deep RAM Optimizer v1.1 - Makaveli JR
setlocal

if not exist "%SystemRoot%\rammap64.exe" (
 echo Downloading RAMMap...
 curl -L -o "%SystemRoot%\rammap64.exe" "https://live.sysinternals.com/rammap64.exe"
 if not exist "%SystemRoot%\rammap64.exe" (
  echo Failed to download RAMMap.
  pause
  exit /b
 )
)

:menu
cls
echo ============================================================
echo                 Deep RAM Optimizer v1.1
echo ============================================================
echo Developer : Makaveli JR
echo GitHub    : https://github.com/makavelijr
echo YouTube   : https://www.youtube.com/@KINGMAKAVELI
echo ============================================================
echo 1. Empty Standby List
echo 2. Empty Working Sets
echo 3. Full Cleanup
echo 4. Enable Auto Cleanup (Hourly)
echo 5. Disable Auto Cleanup
echo 0. Exit
set /p c=Choice: 

if "%c%"=="1" "%SystemRoot%\rammap64.exe" -accepteula -Et & pause & goto menu
if "%c%"=="2" "%SystemRoot%\rammap64.exe" -accepteula -Ew & pause & goto menu
if "%c%"=="3" (
 "%SystemRoot%\rammap64.exe" -accepteula -Ew
 "%SystemRoot%\rammap64.exe" -accepteula -Et
 pause
 goto menu
)
if "%c%"=="4" (
md "C:\WinRTP" 2>nul
(
echo @echo off
echo "%SystemRoot%\rammap64.exe" -accepteula -Et
echo "%SystemRoot%\rammap64.exe" -accepteula -Ew
)>"C:\WinRTP\AutoRAMClean.bat"
schtasks /create /tn "WinRTP_AutoRAM" /tr "C:\WinRTP\AutoRAMClean.bat" /sc hourly /mo 1 /ru SYSTEM /rl highest /f
pause
goto menu
)
if "%c%"=="5" (
schtasks /delete /tn "WinRTP_AutoRAM" /f
del /q "C:\WinRTP\AutoRAMClean.bat" 2>nul
pause
goto menu
)
