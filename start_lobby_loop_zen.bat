@echo off
title Start Lobby Loop Zen
cd /d "%~dp0"
rem Starts lobby_loop_zen.ahk. Installs AutoHotkey v2 first if it's missing.
rem (The .exe version doesn't need AutoHotkey at all.)

if not exist "lobby_loop_zen.ahk" (
  echo lobby_loop_zen.ahk isn't in this folder. Put this file next to it.
  pause
  exit /b
)
call :ensure_ahk
if not defined AHK (
  pause
  exit /b
)
start "" "%AHK%" "%~dp0lobby_loop_zen.ahk"
exit /b

:find_ahk
set "AHK="
for %%P in ("%ProgramFiles%\AutoHotkey\v2\AutoHotkey64.exe" "%LocalAppData%\Programs\AutoHotkey\v2\AutoHotkey64.exe" "%ProgramFiles(x86)%\AutoHotkey\v2\AutoHotkey64.exe") do if exist %%P set "AHK=%%~P"
if defined AHK goto :eof
for %%K in (HKLM HKCU) do for /f "tokens=2,*" %%A in ('reg query "%%K\SOFTWARE\AutoHotkey" /v InstallDir 2^>nul ^| find "InstallDir"') do if exist "%%B\v2\AutoHotkey64.exe" set "AHK=%%B\v2\AutoHotkey64.exe"
goto :eof

:ensure_ahk
call :find_ahk
if defined AHK goto :eof
echo.
echo AutoHotkey v2 isn't installed. Installing it now (free, from autohotkey.com)...
echo If Windows asks "Do you want to allow this app to make changes", click Yes.
echo.
where winget >nul 2>nul
if errorlevel 1 goto ahk_download
winget install --id AutoHotkey.AutoHotkey -e --silent --accept-package-agreements --accept-source-agreements
call :find_ahk
if defined AHK goto ahk_done
:ahk_download
echo Downloading the AutoHotkey v2 installer...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; Invoke-WebRequest 'https://www.autohotkey.com/download/ahk-v2.exe' -OutFile (Join-Path $env:TEMP 'ahk-v2-setup.exe')"
if not exist "%TEMP%\ahk-v2-setup.exe" goto ahk_failed
start "" /wait "%TEMP%\ahk-v2-setup.exe" /silent
rem the installer may restart itself as admin, so wait up to a minute for it to finish
set /a TRIES=0
:ahk_wait
call :find_ahk
if defined AHK goto ahk_cleanup
set /a TRIES+=1
if %TRIES% geq 30 goto ahk_failed
timeout /t 2 /nobreak >nul
goto ahk_wait
:ahk_cleanup
del "%TEMP%\ahk-v2-setup.exe" >nul 2>nul
:ahk_done
echo AutoHotkey v2 is installed.
goto :eof
:ahk_failed
echo.
echo Couldn't install AutoHotkey v2 by itself.
echo Install it from https://www.autohotkey.com (the v2 button), then run this again.
start "" "https://www.autohotkey.com"
goto :eof
