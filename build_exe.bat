@echo off
title Build Lobby Loop .exe
cd /d "%~dp0"
rem Builds lobby_loop.exe / lobby_loop_zen.exe. Installs AutoHotkey v2 and its compiler first if they're missing.

call :ensure_ahk
if not defined AHK (
  pause
  exit /b
)
call :ensure_a2e
if not defined A2E (
  pause
  exit /b
)

rem ---- build an .exe for every Lobby Loop script in this folder ----
for %%F in (lobby_loop.ahk lobby_loop_zen.ahk) do (
  if exist "%%F" (
    echo Building %%~nF.exe ...
    start "" /wait "%A2E%" /in "%%F" /out "%%~nF.exe" /base "%AHK%" /silent
    if exist "%%~nF.exe" (echo   OK: %%~nF.exe) else (echo   FAILED: %%F)
  )
)
echo.
echo Done. Send your friend the .exe file (for example lobby_loop_zen.exe).
pause
exit /b

:find_a2e
set "A2E="
for %%P in ("%ProgramFiles%\AutoHotkey\Compiler\Ahk2Exe.exe" "%LocalAppData%\Programs\AutoHotkey\Compiler\Ahk2Exe.exe" "%ProgramFiles(x86)%\AutoHotkey\Compiler\Ahk2Exe.exe") do if exist %%P set "A2E=%%~P"
if defined A2E goto :eof
if exist "%CD%\Ahk2Exe" for /r "%CD%\Ahk2Exe" %%X in (Ahk2Exe.exe) do if exist "%%X" set "A2E=%%X"
goto :eof

:ensure_a2e
call :find_a2e
if defined A2E goto :eof
echo.
echo The AutoHotkey compiler (Ahk2Exe) isn't installed. Downloading it from GitHub...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; $r = Invoke-RestMethod 'https://api.github.com/repos/AutoHotkey/Ahk2Exe/releases/latest'; $u = ($r.assets | Where-Object { $_.name -like '*.zip' } | Select-Object -First 1).browser_download_url; $z = Join-Path $env:TEMP 'ahk2exe.zip'; Invoke-WebRequest $u -OutFile $z; Expand-Archive -Force $z (Join-Path (Get-Location) 'Ahk2Exe'); Remove-Item $z"
call :find_a2e
if defined A2E (
  echo Ahk2Exe is ready.
  goto :eof
)
echo.
echo Couldn't get Ahk2Exe by itself.
echo Open "AutoHotkey Dash" from the Start menu, click "Compile" once so it installs, then run this again.
goto :eof

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
