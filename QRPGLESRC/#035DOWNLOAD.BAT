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
rem   sign on
rem **************************************

echo %USER%> %TEMPFILE%
echo %PASS%>> %TEMPFILE%
echo quote site namefmt 0 >> %TEMPFILE%
echo cd %DEV_LIB%>> %TEMPFILE%
echo quote type c 819>> %TEMPFILE%

rem **************************************
rem   Download: PEEKSRC
rem **************************************

set TFR_FILE=PEEKSRC
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*  >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QCMDSRC
rem **************************************

set TFR_FILE=QCMDSRC
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*  >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QCOPYLE
rem **************************************

set TFR_FILE=QCOPYLE
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QDDSSRC
rem **************************************

set TFR_FILE=QDDSSRC
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QEXAMPLE
rem   PEEK96 erstellt QEXAMPLE nur in PEEK
rem **************************************

set TFR_FILE=QEXAMPLE
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo cd PEEK>> %TEMPFILE%
echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%
echo cd %DEV_LIB%>> %TEMPFILE%

rem **************************************
rem   Download: QMSG_ENG
rem **************************************

set TFR_FILE=QMSG_ENG
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QMSG_FRA
rem **************************************

set TFR_FILE=QMSG_FRA
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QMSG_GER
rem **************************************

set TFR_FILE=QMSG_GER
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QMSG_ITA
rem **************************************

set TFR_FILE=QMSG_ITA
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QMSG_SPA
rem **************************************

set TFR_FILE=QMSG_SPA
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QRPGLESRC
rem **************************************

set TFR_FILE=QRPGLESRC
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

rem **************************************
rem   Download: QSRVSRC
rem **************************************

set TFR_FILE=QSRVSRC
set RMT_FILE=%TFR_FILE%
set LCL_FILE=%RMT_FILE%.FILE

if not exist %LCL_FILE% (
   md %LCL_FILE%
)

echo lcd %LCL_FILE%      >> %TEMPFILE%
echo mget %RMT_FILE%.*   >> %TEMPFILE%
echo lcd ..              >> %TEMPFILE%

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
pause
ftp -i -s:%TEMPFILE% %HOST%
del %TEMPFILE%
goto end

:usage
echo.
echo USAGE: download PASSWORD
echo.
echo  PASSWORD = Password to log in with
echo.
:end
