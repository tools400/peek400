      *===============================================================*
      *                                                               *
      *  erstellt : 27.03.2012                                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Rahmentestprogramm mit Protokollausgabe                      *
      *  Thema:                                                       *
      *     Test: GRAPHIC Felder                                      *
      *                                                               *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *                                                               *
      *   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
      *                           SRCFILE(&SL/&SF) +                  *
      *                           SRCMBR(&SM);                        *
      *                                                               *
      *   >>COMPILE<<                                                 *
      *     >>PARM<< TRUNCNBR(*NO);                                   *
      *     >>PARM<< DBGVIEW(*LIST);                                  *
      *     >>PARM<< ALWNULL(*USRCTL);                                *
      *   >>END-COMPILE<<                                             *
      *                                                               *
      *   >>EXECUTE<<                                                 *
      *                                                               *
      *   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
      *                           MODULE(&LI/&OB          +           *
      *                                          ) +                  *
      *                           BNDSRVPGM(*LIBL/BASICS1      +      *
      *                                     *LIBL/PRTLOG       +      *
      *                                          ) +                  *
      *                           BNDDIR(*LIBL/QC2LE) +               *
      *                           DETAIL(*BASIC) +                    *
      *                           ACTGRP(*NEW);                       *
      *                                                               *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H DEBUG
     H OPTION(*SRCSTMT : *NODEBUGIO)
     H DECEDIT('0,') DATEDIT(*DMY.)
     H DATFMT(*ISO )  TIMFMT(*ISO )
     H EXPROPTS(*RESDECPOS)
     H EXTBININT(*YES)
      *===============================================================*
     FMARKTSTAMMUF   E             DISK    usropn
     F                                     rename(MARKTSTAMM: FMARKT)
      *
     FTEST003FM CF   E             WORKSTN usropn
     F                                     infds(workStn)
      *
     D workstn         DS                  qualified
     D  status                11     15S 0
     D  offset               241    242I 0
     D  AID                  369    369A
     D  csrPos               370    371I 0
      *
      /COPY QCOPYLE,D_WORKSTN
      *
      * ------------------------------------
      *  Type definitions
      * ------------------------------------
      *
      * ------------------------------------
      *  External Prototypes
      * ------------------------------------
      /COPY QBASICS1,PBASICS1                      SrvPgm: Basics 1
      /COPY QPRTLOG,PPRTLOG                        SrvPgm: Print log
      *
      * ------------------------------------
      *  Global Fields
      * ------------------------------------
      *
      *  Logger
     D g_hLogger       S                   like(prtLog_handle_t) inz
      *
      * ------------------------------------
      *  Globale Konstanten
      * ------------------------------------
      *
      * ------------------------------------
      *  Prototypes
      * ------------------------------------
      *
     D PGM_ENTRY_POINT...
     D                 PR                  extpgm('TEST003')
      *
     D main...
     D                 PR                         extproc('main')
      *
      *  Test for errors and log them.
     D isErrorMsg...
     D                 PR              N          extproc('isErrorMsg')
     D  i_msg                              const  likeds(msg_t    )
      *
      *  Open Logger
     D openLogger...
     D                 PR                         extproc('openLogger')
     D  i_layout                      1A   value
     D  i_splF                       10A   value  varying
     D  i_usrDta                     10A   value  varying
      *
      *  Logs a given string.
     D log...
     D                 PR                         extproc('log')
     D  i_msgText                   256A   const  varying
      *
      *  Logs a given message.
     D logMsg...
     D                 PR                         extproc('logMsg')
     D  i_msg                              const  likeds(msg_t        )
      *
      *  Logs a monitored message.
     D logMonitor...
     D                 PR                         extproc('logMonitor')
     D                                            likeds(msg_t   )
     D  i_text                      128A   const  varying
      *
      *  Close Logger
     D closeLogger...
     D                 PR                         extproc('closeLogger')
      *
      *  Abrufen letzte Abbruch-Nachricht.
     D rcvEscMsg...
     D                 PR                         extproc('rcvEscMsg')
     D                                            likeds(msg_t    )
     D  i_stckCnt                    10I 0 const
      *
      *  Abrufen Nachrichtentext für Nachricht.
     D rtvMsgText...
     D                 PR          1024A          varying
     D                                            extproc('rtvMsgText')
     D  i_msg                                     const  likeds(msg_t   )
      *
      *  Sends a message to QCMD
     D sndMsg...
     D                 PR                         extproc('sndMsg')
     D  i_text                      128A   value  varying
      *
      * ------------------------------------
      *  Program Status Information
      * ------------------------------------
     D sds            SDS                  qualified
     D  pgmName                1     10A                                        Pgm Name
     D  statusCode            11     15S 0                                      Status Code
     D  statusCodePrv         16     20S 0                                      Prv Stat Code
     D  srcLineNbr            21     28A                                        Src Line Nbr
     D  routine               29     36A                                        RPG routine
     D  numParms              37     39S 0                                      Num of Parms
     D  msgID                 40     46A                                        Message ID
     D   excType                      3A   overlay(msgID)                       Excp Type
     D   excNbr                       4A   overlay(msgID: *next)                Excp Number
     D  reserved_1            47     50A                                        Reserved
     D  msgWorkArea           51     80A                                        Work Area Msg
     D  pgmLib                81     90A                                        Program Librar
     D  msgText               91    170A                                        Rtv Excp Data
     D  excpID               171    174A                                        Excp ID RNX900
     D  lastFileUsed         175    184A                                        Last File Used
     D  reserved_2           185    190A                                        Reserved
     D  jobDate              191    198A                                        Job Date
     D  century              199    200S 0                                      Job Date Centu
     D  lastFileUsed8        201    208A                                        Last File Used
     D  lastFileStat         209    243A                                        Last File Stat
     D  job                  244    253A                                        Job Name
     D  user                 254    263A                                        User Name
     D  nbr                  264    269A                                        Job Number
     D  pgmDate              270    275S 0                                      Pgm Start Date
     D  date                 276    281S 0
     D  time                 282    287S 0
     D  pgmCrtDate           288    293A                                        Pgm Crt Date
     D  pgmCrtTime           294    299A                                        Pgm Crt Time
     D  compilerLvl          300    303A                                        Compiler Level
     D  srcFile              304    313A                                        Source: File
     D  srcLib               314    323A                                                Lib
     D  srcMbr               324    333A                                                Mbr
     D  prcOfPgm             334    343A                                        Pgm cont. Prc
     D  prcOfMod             344    353A                                        Mod cont. Prc
     D  Reserved             354    429A                                        Reserved
     D  curUsrPrf            358    367A                                        Curr User Prf
      *
      *===============================================================*
      *  Program Entry Point
      *===============================================================*
     D PGM_ENTRY_POINT...
     D                 PI
      *
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         // openLogger('L': sds.pgmName: '');

         main(
                              );

         // Close logger
         // closeLogger();

         *inlr = *on;

         return;

      /END-FREE
      *
      *===============================================================*
      *  Test for errors and log them.
      *===============================================================*
     P isErrorMsg...
     P                 B
      *
     D isErrorMsg...
     D                 PI              N
     D  i_msg                              const  likeds(msg_t    )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (i_msg.ID <> cMSG_ID_OK);
            logMsg(i_msg);
            return cTrue;
         else;
            return cFalse;
         endif;

      /END-FREE
      *
     P isErrorMsg...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Open Logger
      *===============================================================*
     P openLogger...
     P                 B
      *
     D openLogger...
     D                 PI
     D  i_layout                      1A   value
     D  i_splF                       10A   value  varying
     D  i_usrDta                     10A   value  varying
      *
      *  Helper fields
     D cmd             S            256A   inz   varying
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         cmd = 'OVRPRTF ' +
                  'FILE(PRTLOGP) '               +
                  'LPI(6) '                      +
                  'CPI(10) '                     +
                  'OVRSCOPE(*ACTGRPDFN) '        +
                  'SPLFNAME(' + i_splF + ') '    +
                  'MAXRCDS(*NOMAX) '             +
                  'USRDTA(''' + i_usrDta + ''') ';

         if (i_layout = 'P');
            cmd = cmd + 'PAGESIZE(70 80) ' +
                        'OVRFLW(64) ';
         else;
            cmd = cmd + 'PAGESIZE(49 132) ' +
                        'OVRFLW(42) ';
         endif;

         f_execute(cmd);

         // Open logger
         if f_opnPrtLog('Examinee: '+ i_usrDta: cFalse: g_hLogger);   //no scndlvl Tx
            log('######## Start of Test ########');
         endif;

         return;

      /END-FREE
      *
     P openLogger...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Logs a given string.
      *===============================================================*
     P log...
     P                 B
      *
     D log...
     D                 PI
     D  i_msgText                   256A   const  varying
      *
      *  Helper fields
     D msg             DS                  likeds(msg_t   ) inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         if (i_msgText = '');
            msg = f_newMsg(cMSG_ID_NONE: x'41');
         else;
            msg = f_newMsg(cMSG_ID_NONE: i_msgText);
         endif;

         logMsg(msg);

         return;

      /END-FREE
      *
     P log...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Logs a given message.
      *===============================================================*
     P logMsg...
     P                 B
      *
     D logMsg...
     D                 PI
     D  i_msg                              const  likeds(msg_t        )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         f_wrtPrtLog(g_hLogger: i_msg);

         return;

      /END-FREE
      *
     P logMsg...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Logs a monitored message.
      *===============================================================*
     P logMonitor...
     P                 B
      *
     D logMonitor...
     D                 PI                         likeds(msg_t   )
     D  i_text                      128A   const  varying
      *
      *  Funktionswert
     D msg             DS                  likeds(msg_t        ) inz
      *
      *  Arbeitsfelder
     D msgText         S           1024A   varying inz
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         msg = rcvEscMsg(2);

         msgText = 'MONITOR: ' + i_text + ' - ' + rtvMsgText(msg);

         log(msgText);

         return msg;

      /END-FREE
      *
     P logMonitor...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Close Logger
      *===============================================================*
     P closeLogger...
     P                 B
      *
     D closeLogger...
     D                 PI
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         log('########  End of Test  ########');

         // Close logger
         f_cloPrtLog(g_hLogger);

         g_hLogger = *NULL;

         return;

      /END-FREE
      *
     P closeLogger...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Abrufen letzte Abbruch-Nachricht.
      *===============================================================*
     P rcvEscMsg...
     P                 B
      *
     D rcvEscMsg...
     D                 PI                         likeds(msg_t    )
     D  i_stckCnt                    10I 0 const
      *
      *  Funktionswert
     D msg             DS                  likeds(msg_t    ) inz
      *
      *  Arbeitsfelder
     D msgKey          S              4A   inz
     D msgData         S            512A   inz varying
      *
     D rcvm0200        DS                  qualified inz
     D  bytRet                       10I 0
     D  bytAvl                       10I 0
     D  msgSev                       10I 0
     D  msgID                         7A
     D  msgType                       2A
     D  msgKey                        4A
     D  msgF                         10A
     D  msgLS                        10A
     D  msgLU                        10A
     D  sndJob                       10A
     D  sndUsr                       10A
     D  sndNbr                        6A
     D  sndPgm                       12A
     D  sndINb                        4A
     D  sndDat                        7A
     D  sndTim                        6A
     D  rcvPgm                       10A
     D  rcvINb                        4A
     D  sndTyp                        1A
     D  rcvTyp                        1A
     D  reserved_01                   1A
     D  cStIDTx                      10I 0
     D  cStIDDt                      10I 0
     D  alrOpt                        9A
     D  ccsidMH                      10I 0
     D  ccsidRD                      10I 0
     D  lnRplDtR                     10I 0
     D  lnRplDtA                     10I 0
     D  lnMgR                        10I 0
     D  lnMgA                        10I 0
     D  lnMgHR                       10I 0
     D  lnMgHA                       10I 0
     D  value                      4096A
      *
     D errCode         DS                  qualified inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
      *
      *  Receive Program Message (QMHRCVPM) API
     D QMHRCVPM        PR                         extpgm('QMHRCVPM')
     D  o_rcvVar                  32767A          options(*varsize )
     D  i_length                     10I 0 const
     D  i_format                      8A   const
     D  i_callStkE                   10A   const
     D  i_callStkC                   10I 0 const
     D  i_msgType                    10A   const
     D  i_msgKey                      4A   const
     D  i_wait                       10I 0 const
     D  i_action                     10A   const
     D  io_ErrCode                32767A          options(*varsize )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         QMHRCVPM(rcvm0200: %size(rcvm0200): 'RCVM0200': '*': i_stckCnt:
                  '*ESCAPE': msgKey: 0: '*SAME': errCode);

         if (rcvm0200.lnRplDtR > 0);
            msgData = %subst(rcvm0200.value: 1: rcvm0200.lnRplDtR);
         else;
            msgData = '';
         endif;

         clear msg;
         msg.file = rcvm0200.msgF;
         msg.lib  = rcvm0200.msgLU;
         msg.type = '*INFO';
         msg.ID   = rcvm0200.msgID;
         msg.data = msgData;

         return msg;

      /END-FREE
      *
     P rcvEscMsg...
     P                 E
      *
      *===============================================================*
    R *  *** Private ***
      *  Abrufen Nachrichtentext für Nachricht.
      *===============================================================*
     P rtvMsgText...
     P                 B
      *
     D rtvMsgText...
     D                 PI          1024A          varying
     D  i_msg                                     const  likeds(msg_t   )
      *
      *  Funktionswert
     D msgText         S           1024A   varying inz
      *
      *  Arbeitsfelder
     D rtvm0100        DS                  qualified inz
     D  bytRet                       10I 0
     D  bytAvl                       10I 0
     D  lenMsgRet                    10I 0
     D  lenMsgAvl                    10I 0
     D  lenHlpRet                    10I 0
     D  lenHlpAvl                    10I 0
     D  data                       4096A
      *
     D qMsgF           DS                  qualified inz
     D  name                         10A
     D  lib                          10A
      *
     D errCode         DS                  qualified inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
      *
      *  Retrieve Message (QMHRTVM) API
     D QMHRTVM         PR                         extpgm('QMHRTVM')
     D  o_msgInf                  32767A          options(*varsize )
     D  i_length                     10I 0 const
     D  i_format                      8A   const
     D  i_msgID                       7A   const
     D  i_qMsgF                      20A   const
     D  i_rplData                 32767A   const  options(*varsize )
     D  i_rpldataLen                 10I 0 const
     D  i_rplVars                    10A   const
     D  i_rtnCtrlChrs                10A   const
     D  io_ErrCode                32767A          options(*varsize )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         qMsgF.name = i_msg.file;
         qMsgF.lib  = i_msg.lib;

         QMHRTVM(rtvm0100: %size(rtvm0100): 'RTVM0100': i_msg.ID: qMsgF:
                 i_msg.data: %len(i_msg.data): '*YES': '*NO': errCode);

         if (rtvm0100.lenMsgRet > 0);
            msgText = %subst(rtvm0100.data: 1: rtvm0100.lenMsgRet);
         else;
            msgText = '';
         endif;

         return msgText;

      /END-FREE
      *
     P rtvMsgText...
     P                 E
      *
      *===============================================================*
      *  *** private ***
      *  Sends a message to the caller.
      *===============================================================*
     P sndMsg...
     P                 B
      *
     D sndMsg...
     D                 PI
     D  i_text                      128A   value  varying
      *
      *  Return value
     D pBuffer         S               *   inz
      *
      *  Local fields
     D msgKey          S              4A                        inz
      *
     D qMsgF           DS                  qualified            inz
     D  name                         10A
     D  lib                          10A
      *
     D errCode         DS                  qualified            inz
     D  bytPrv                       10I 0
     D  bytAvl                       10I 0
     D  excID                         7A
     D  reserved                      1A
     D  excDta                      256A
      *
      *  Send Program Message (QMHSNDPM) API
     D QMHSNDPM        PR                         extpgm('QMHSNDPM')
     D   i_msgID                      7A   const
     D   i_qMsgF                     20A   const
     D   i_msgData                32767A   const  options(*varsize )
     D   i_length                    10I 0 const
     D   i_msgType                   10A   const
     D   i_callStkE               32767A   const  options(*varsize )
     D   i_callStkC                  10I 0 const
     D   o_msgKey                     4A
     D   io_ErrCode               32767A          options(*varsize )
     D   i_lenStkE                   10I 0 const  options(*nopass  )
     D   i_callStkEQ                 20A   const  options(*nopass  )
     D   i_wait                      10I 0 const  options(*nopass  )
     D   i_callStkEDT                10A   const  options(*nopass  )
     D   i_ccsid                     10I 0 const  options(*nopass  )
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         clear qMsgF;
         qMsgF.name = 'QCPFMSG';
         qMsgF.lib  = '*LIBL';

         clear errCode;
         errCode.bytPrv = %size(errCode);

         QMHSNDPM('CPF9897': qMsgF: i_text: %len(i_text): '*INFO'
                  : '*CTLBDY': 1
                  : msgKey: errCode);

         return;

      /END-FREE
      *
     P sndMsg...
     P                 E
      *
      *===============================================================*
      *  Main procedure
      *===============================================================*
     P main...
     P                 B
      *
     D main...
     D                 PI
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         open TEST003FM;

         dow '1';

            open MARKTSTAMM;
            read(N) FMARKT;
            if (not %eof(MARKTSTAMM));
               ##MANDANT  = MANDANT;
               ##MARKTNR  = MARKTNR;
               ##HERKUNFT = HERKUNFT;
               ##STRASS01 = %subst(STRASSE: 1: 15);
               ##STRASS02 = %subst(STRASSE:16: 10);
               ##PLZ      = PLZ;
               ##ORT      = ORT;
            endif;

            close MARKTSTAMM;

            exfmt SCREEN01;

            select;
            when (workstn.AID = K_ENTER);
               open MARKTSTAMM;
               read FMARKT;
               if (not %eof(MARKTSTAMM));
                  MANDANT                = ##MANDANT;
                  MARKTNR                = ##MARKTNR;
                  HERKUNFT               = ##HERKUNFT;
                  %subst(STRASSE: 1: 15) = ##STRASS01;
                  %subst(STRASSE:16: 10) = ##STRASS02;
                  PLZ                    = ##PLZ;
                  ORT                    = ##ORT;
                  update FMARKT;
               endif;
               close MARKTSTAMM;
            when (workstn.AID = K_F3);
               leave;
            when (workstn.AID = K_F12);
               leave;
            endsl;

         enddo;

         if (%open(TEST003FM));
            close TEST003FM;
         endif;

         if (%open(MARKTSTAMM));
            close MARKTSTAMM;
         endif;

         return;

      /END-FREE
      *
     P main...
     P                 E
      *
