@echo off
rem **************************************************************
rem *  This is an MS-DOS BATCH file for downloading the          *
rem *  PEEK/400 source code to a PC.                             *
rem **************************************************************
set PEEK_VERSION=408

set TEMPFILE=peek.ftpcmds
set HOST=ghentw.gfd.de
set USER=RADDATZ
set PASS=%1
set DEV_LIB=PEEK%PEEK_VERSION%P

if "%PASS%"=="" goto usage

rem **************************************
rem   Löschen Verzeichnisse
rem **************************************

if exist *.file (
   for /F %%a in ('dir /B *.file') do (
      rd %%a /S /Q
   )
)

rem **************************************
rem   Löschen Sicherungsdateien
rem **************************************

if exist *.savf (
   for /F %%a in ('dir /B *.savf') do (
      del %%a
   )
)

rem **************************************
rem   Auflisten Teildateien
rem   ftp.exe sendet bei mget TYPE A und
rem   hebt damit TYPE C 819 auf. Deshalb
rem   erst auflisten, dann einzeln holen.
rem **************************************

call :signon
call :list PEEKSRC   %DEV_LIB%
call :list QCMDSRC   %DEV_LIB%
call :list QCOPYLE   %DEV_LIB%
call :list QDDSSRC   %DEV_LIB%
rem PEEK96 erstellt QEXAMPLE nur in PEEK
call :list QEXAMPLE  PEEK
call :list QMSG_ENG  %DEV_LIB%
call :list QMSG_FRA  %DEV_LIB%
call :list QMSG_GER  %DEV_LIB%
call :list QMSG_ITA  %DEV_LIB%
call :list QMSG_SPA  %DEV_LIB%
call :list QRPGLESRC %DEV_LIB%
call :list QSRVSRC   %DEV_LIB%
echo quit >> %TEMPFILE%

pause
ftp -i -s:%TEMPFILE% %HOST%

rem **************************************
rem   Download Teildateien
rem   ascii: ftp.exe sendet danach kein
rem   TYPE A mehr vor einem get.
rem **************************************

call :signon
echo ascii>> %TEMPFILE%
echo quote type c 819>> %TEMPFILE%
call :get PEEKSRC   %DEV_LIB%
call :get QCMDSRC   %DEV_LIB%
call :get QCOPYLE   %DEV_LIB%
call :get QDDSSRC   %DEV_LIB%
call :get QEXAMPLE  PEEK
call :get QMSG_ENG  %DEV_LIB%
call :get QMSG_FRA  %DEV_LIB%
call :get QMSG_GER  %DEV_LIB%
call :get QMSG_ITA  %DEV_LIB%
call :get QMSG_SPA  %DEV_LIB%
call :get QRPGLESRC %DEV_LIB%
call :get QSRVSRC   %DEV_LIB%

rem **************************************
rem   Download save file
rem **************************************

set PRD_LIB=RADDATZ
set PRD_FILE=PEEK%PEEK_VERSION%
echo binary >> %TEMPFILE%
echo get %PRD_LIB%/%PRD_FILE%  %PRD_FILE%.SAVF >> %TEMPFILE%

rem **************************************
rem   Download save file development
rem **************************************

set PRD_LIB=RADDATZ
set PRD_FILE=PEEK%PEEK_VERSION%P
echo binary >> %TEMPFILE%
echo get %PRD_LIB%/%PRD_FILE%  %PRD_FILE%.SAVF >> %TEMPFILE%

echo quit >> %TEMPFILE%
ftp -i -s:%TEMPFILE% %HOST%
del %TEMPFILE%
goto end

rem **************************************
rem   sign on
rem **************************************
:signon
echo %USER%> %TEMPFILE%
echo %PASS%>> %TEMPFILE%
echo quote site namefmt 0 >> %TEMPFILE%
goto :eof

rem **************************************
rem   Auflisten: Datei Bibliothek
rem **************************************
:list
echo cd %2>> %TEMPFILE%
echo ls %1.* %1.lst>> %TEMPFILE%
goto :eof

rem **************************************
rem   Download: Datei Bibliothek
rem **************************************
:get
if not exist %1.FILE (
   md %1.FILE
)
echo cd %2>> %TEMPFILE%
echo lcd %1.FILE>> %TEMPFILE%
if exist %1.lst (
   for /F %%m in (%1.lst) do echo get %%m>> %TEMPFILE%
   del %1.lst
)
echo lcd ..>> %TEMPFILE%
goto :eof

:usage
echo.
echo USAGE: download PASSWORD
echo.
echo  PASSWORD = Password to log in with
echo.
:end
