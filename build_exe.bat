@echo off
title Build Lobby Loop .exe
cd /d "%~dp0"

rem ---- find the AutoHotkey compiler (Ahk2Exe) ----
set "A2E="
for %%P in ("%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe" "%LocalAppData%\Programs\AutoHotkey\Compiler\Ahk2Exe.exe" "%ProgramFiles(x86)%\AutoHotkey\Compiler\Ahk2Exe.exe") do (
  if exist %%P set "A2E=%%~P"
)
if "%A2E%"=="" (
  echo Could not find Ahk2Exe.
  echo Open "AutoHotkey Dash", click "Compile" once so it installs, then run this again.
  pause
  exit /b
)

rem ---- find the AutoHotkey v2 base file ----
set "BASEFILE="
for %%P in ("%ProgramFiles%\AutoHotkey\v2\AutoHotkey64.exe" "%LocalAppData%\Programs\AutoHotkey\v2\AutoHotkey64.exe") do (
  if exist %%P set "BASEFILE=%%~P"
)
if "%BASEFILE%"=="" (
  echo Could not find AutoHotkey v2. Install it from autohotkey.com and run this again.
  pause
  exit /b
)

rem ---- build an .exe for every Lobby Loop script in this folder ----
for %%F in (lobby_loop.ahk lobby_loop_zen.ahk) do (
  if exist "%%F" (
    echo Building %%~nF.exe ...
    start "" /wait "%A2E%" /in "%%F" /out "%%~nF.exe" /base "%BASEFILE%" /silent
    if exist "%%~nF.exe" (echo   OK: %%~nF.exe) else (echo   FAILED: %%F)
  )
)
echo.
echo Done. Send your friend the .exe file (for example lobby_loop_zen.exe).
pause
