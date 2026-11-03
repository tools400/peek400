@echo off
rem Startet release.ps1 aus der Eingabeaufforderung (cmd.exe), die .ps1-Dateien nicht ausfuehrt.
rem Aufruf: .github\release download -Version 4.0.8
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0release.ps1" %*
exit /b %ERRORLEVEL%
