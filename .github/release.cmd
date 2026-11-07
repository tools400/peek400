@echo off
rem Startet release.ps1 aus der Eingabeaufforderung (cmd.exe), die .ps1-Dateien nicht ausfuehrt.
rem Aufruf: .github\release download -Version 4.0.8
rem Hilfe:  .github\release help, .github\release /? oder ohne Parameter
if "%~1"=="/?" goto help
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0release.ps1" %*
exit /b %ERRORLEVEL%

:help
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0release.ps1" help
exit /b %ERRORLEVEL%
