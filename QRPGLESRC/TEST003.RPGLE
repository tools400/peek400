**FREE
//===============================================================*
//                                                               *
//  erstellt : 27.03.2012                                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Rahmentestprogramm mit Protokollausgabe                      *
//  Thema:                                                       *
//     Test: GRAPHIC Felder                                      *
//                                                               *
//===============================================================*
// >>PRE-COMPILER<<                                              *
//                                                               *
//   >>CRTCMD<< CRTRPGMOD    MODULE(&LI/&OB) +                   *
//                           SRCFILE(&SL/&SF) +                  *
//                           SRCMBR(&SM);                        *
//                                                               *
//   >>COMPILE<<                                                 *
//     >>PARM<< TRUNCNBR(*NO);                                   *
//     >>PARM<< DBGVIEW(*LIST);                                  *
//     >>PARM<< ALWNULL(*USRCTL);                                *
//   >>END-COMPILE<<                                             *
//                                                               *
//   >>EXECUTE<<                                                 *
//                                                               *
//   >>CMD<<    CRTPGM       PGM(&LI/&OB) +                      *
//                           MODULE(&LI/&OB          +           *
//                                          ) +                  *
//                           BNDSRVPGM(*LIBL/BASICS1      +      *
//                                     *LIBL/PRTLOG       +      *
//                                          ) +                  *
//                           BNDDIR(*LIBL/QC2LE) +               *
//                           DETAIL(*BASIC) +                    *
//                           ACTGRP(*NEW);                       *
//                                                               *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
ctl-opt DEBUG OPTION(*SRCSTMT : *NODEBUGIO);
ctl-opt DECEDIT('0,') DATEDIT(*DMY.);
ctl-opt DATFMT(*ISO )  TIMFMT(*ISO );
ctl-opt EXPROPTS(*RESDECPOS);
ctl-opt EXTBININT(*YES);
//===============================================================*
dcl-f MARKTSTAMM usage(*update:*delete)
      usropn rename(MARKTSTAMM: FMARKT);
//
dcl-f TEST003FM WORKSTN(*ext) usage(*input:*output)
      usropn infds(workStn);
//
dcl-ds workstn qualified;
  status          zoned(5) pos(11);
  offset          int(5) pos(241);
  AID             char(1) pos(369);
  csrPos          int(5);
end-ds;
//
/COPY QCOPYLE,D_WORKSTN
//
// ------------------------------------
//  Type definitions
// ------------------------------------
//
// ------------------------------------
//  External Prototypes
// ------------------------------------
/COPY QBASICS1,PBASICS1                      SrvPgm: Basics 1
/COPY QPRTLOG,PPRTLOG                        SrvPgm: Print log
//
// ------------------------------------
//  Global Fields
// ------------------------------------
//
//  Logger
dcl-s g_hLogger       like(prtLog_handle_t) inz;
//
// ------------------------------------
//  Globale Konstanten
// ------------------------------------
//
// ------------------------------------
//  Prototypes
// ------------------------------------
//
dcl-pr PGM_ENTRY_POINT
       extpgm('TEST003');
end-pr;
//
dcl-pr main
       extproc('main');
end-pr;
//
//  Test for errors and log them.
dcl-pr isErrorMsg
       ind extproc('isErrorMsg');
  i_msg           const  likeds(msg_t    );
end-pr;
//
//  Open Logger
dcl-pr openLogger
       extproc('openLogger');
  i_layout        char(1) value;
  i_splF          varchar(10) value;
  i_usrDta        varchar(10) value;
end-pr;
//
//  Logs a given string.
dcl-pr log
       extproc('log');
  i_msgText       varchar(256) const;
end-pr;
//
//  Logs a given message.
dcl-pr logMsg
       extproc('logMsg');
  i_msg           const  likeds(msg_t        );
end-pr;
//
//  Logs a monitored message.
dcl-pr logMonitor
       extproc('logMonitor')
       likeds(msg_t   );
i_text          varchar(128) const;
end-pr;
//
//  Close Logger
dcl-pr closeLogger
       extproc('closeLogger');
end-pr;
//
//  Abrufen letzte Abbruch-Nachricht.
dcl-pr rcvEscMsg
       extproc('rcvEscMsg')
       likeds(msg_t    );
i_stckCnt       int(10) const;
end-pr;
//
//  Abrufen Nachrichtentext für Nachricht.
dcl-pr rtvMsgText
       varchar(1024)
       extproc('rtvMsgText');
  i_msg           const  likeds(msg_t   );
end-pr;
//
//  Sends a message to QCMD
dcl-pr sndMsg
       extproc('sndMsg');
  i_text          varchar(128) value;
end-pr;
//
// ------------------------------------
//  Program Status Information
// ------------------------------------
dcl-ds sds qualified psds;
  pgmName         char(10) pos(1);                                       // Pgm Name
  statusCode      zoned(5) pos(11);                                      // Status Code
  statusCodePrv   zoned(5) pos(16);                                      // Prv Stat Code
  srcLineNbr      char(8) pos(21);                                       // Src Line Nbr
  routine         char(8) pos(29);                                       // RPG routine
  numParms        zoned(3) pos(37);                                      // Num of Parms
  msgID           char(7) pos(40);                                       // Message ID
  excType         char(3) overlay(msgID);                                // Excp Type
  excNbr          char(4) overlay(msgID: *next);                         // Excp Number
  reserved_1      char(4) pos(47);                                       // Reserved
  msgWorkArea     char(30) pos(51);                                      // Work Area Msg
  pgmLib          char(10) pos(81);                                      // Program Librar
  msgText         char(80) pos(91);                                      // Rtv Excp Data
  excpID          char(4) pos(171);                                      // Excp ID RNX900
  lastFileUsed    char(10) pos(175);                                     // Last File Used
  reserved_2      char(6) pos(185);                                      // Reserved
  jobDate         char(8) pos(191);                                      // Job Date
  century         zoned(2) pos(199);                                     // Job Date Centu
  lastFileUsed8   char(8) pos(201);                                      // Last File Used
  lastFileStat    char(35) pos(209);                                     // Last File Stat
  job             char(10) pos(244);                                     // Job Name
  user            char(10) pos(254);                                     // User Name
  nbr             char(6) pos(264);                                      // Job Number
  pgmDate         zoned(6) pos(270);                                     // Pgm Start Date
  date            zoned(6) pos(276);
  time            zoned(6) pos(282);
  pgmCrtDate      char(6) pos(288);                                      // Pgm Crt Date
  pgmCrtTime      char(6) pos(294);                                      // Pgm Crt Time
  compilerLvl     char(4) pos(300);                                      // Compiler Level
  srcFile         char(10) pos(304);                                     // Source: File
  srcLib          char(10) pos(314);                                     //         Lib
  srcMbr          char(10) pos(324);                                     //         Mbr
  prcOfPgm        char(10) pos(334);                                     // Pgm cont. Prc
  prcOfMod        char(10) pos(344);                                     // Mod cont. Prc
  Reserved        char(76) pos(354);                                     // Reserved
  curUsrPrf       char(10) pos(358);                                     // Curr User Prf
end-ds;
//
//===============================================================*
//  Program Entry Point
//===============================================================*
dcl-pi PGM_ENTRY_POINT;
end-pi;
//
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// openLogger('L': sds.pgmName: '');

main(
                     );

// Close logger
// closeLogger();

*inlr = *on;

return;

//
//===============================================================*
//  Test for errors and log them.
//===============================================================*
dcl-proc isErrorMsg;
//
dcl-pi isErrorMsg
       ind;
  i_msg           const  likeds(msg_t    );
end-pi;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (i_msg.ID <> cMSG_ID_OK);
   logMsg(i_msg);
   return cTrue;
else;
   return cFalse;
endif;

//
end-proc isErrorMsg;
//
//===============================================================*
//  *** Private ***
//  Open Logger
//===============================================================*
dcl-proc openLogger;
//
dcl-pi openLogger;
  i_layout        char(1) value;
  i_splF          varchar(10) value;
  i_usrDta        varchar(10) value;
end-pi;
//
//  Helper fields
dcl-s cmd             varchar(256) inz;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

//
end-proc openLogger;
//
//===============================================================*
//  *** Private ***
//  Logs a given string.
//===============================================================*
dcl-proc log;
//
dcl-pi log;
  i_msgText       varchar(256) const;
end-pi;
//
//  Helper fields
dcl-ds msg likeds(msg_t   ) inz;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (i_msgText = '');
   msg = f_newMsg(cMSG_ID_NONE: x'41');
else;
   msg = f_newMsg(cMSG_ID_NONE: i_msgText);
endif;

logMsg(msg);

return;

//
end-proc log;
//
//===============================================================*
//  *** Private ***
//  Logs a given message.
//===============================================================*
dcl-proc logMsg;
//
dcl-pi logMsg;
  i_msg           const  likeds(msg_t        );
end-pi;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

f_wrtPrtLog(g_hLogger: i_msg);

return;

//
end-proc logMsg;
//
//===============================================================*
//  *** Private ***
//  Logs a monitored message.
//===============================================================*
dcl-proc logMonitor;
//
dcl-pi logMonitor
       likeds(msg_t   );
i_text          varchar(128) const;
end-pi;
//
//  Funktionswert
dcl-ds msg likeds(msg_t        ) inz;
//
//  Arbeitsfelder
dcl-s msgText         varchar(1024) inz;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

msg = rcvEscMsg(2);

msgText = 'MONITOR: ' + i_text + ' - ' + rtvMsgText(msg);

log(msgText);

return msg;

//
end-proc logMonitor;
//
//===============================================================*
//  *** Private ***
//  Close Logger
//===============================================================*
dcl-proc closeLogger;
//
dcl-pi closeLogger;
end-pi;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

log('########  End of Test  ########');

// Close logger
f_cloPrtLog(g_hLogger);

g_hLogger = *NULL;

return;

//
end-proc closeLogger;
//
//===============================================================*
//  *** Private ***
//  Abrufen letzte Abbruch-Nachricht.
//===============================================================*
dcl-proc rcvEscMsg;
//
dcl-pi rcvEscMsg
       likeds(msg_t    );
i_stckCnt       int(10) const;
end-pi;
//
//  Funktionswert
dcl-ds msg likeds(msg_t    ) inz;
//
//  Arbeitsfelder
dcl-s msgKey          char(4) inz;
dcl-s msgData         varchar(512) inz;
//
dcl-ds rcvm0200 qualified inz;
  bytRet          int(10);
  bytAvl          int(10);
  msgSev          int(10);
  msgID           char(7);
  msgType         char(2);
  msgKey          char(4);
  msgF            char(10);
  msgLS           char(10);
  msgLU           char(10);
  sndJob          char(10);
  sndUsr          char(10);
  sndNbr          char(6);
  sndPgm          char(12);
  sndINb          char(4);
  sndDat          char(7);
  sndTim          char(6);
  rcvPgm          char(10);
  rcvINb          char(4);
  sndTyp          char(1);
  rcvTyp          char(1);
  reserved_01     char(1);
  cStIDTx         int(10);
  cStIDDt         int(10);
  alrOpt          char(9);
  ccsidMH         int(10);
  ccsidRD         int(10);
  lnRplDtR        int(10);
  lnRplDtA        int(10);
  lnMgR           int(10);
  lnMgA           int(10);
  lnMgHR          int(10);
  lnMgHA          int(10);
  value           char(4096);
end-ds;
//
dcl-ds errCode qualified inz;
  bytPrv          int(10);
  bytAvl          int(10);
end-ds;
//
//  Receive Program Message (QMHRCVPM) API
dcl-pr QMHRCVPM        extpgm('QMHRCVPM');
  o_rcvVar        char(32767) options(*varsize );
  i_length        int(10) const;
  i_format        char(8) const;
  i_callStkE      char(10) const;
  i_callStkC      int(10) const;
  i_msgType       char(10) const;
  i_msgKey        char(4) const;
  i_wait          int(10) const;
  i_action        char(10) const;
  io_ErrCode      char(32767) options(*varsize );
end-pr;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

//
end-proc rcvEscMsg;
//
//===============================================================*
//  *** Private ***
//  Abrufen Nachrichtentext für Nachricht.
//===============================================================*
dcl-proc rtvMsgText;
//
dcl-pi rtvMsgText
       varchar(1024);
  i_msg           const  likeds(msg_t   );
end-pi;
//
//  Funktionswert
dcl-s msgText         varchar(1024) inz;
//
//  Arbeitsfelder
dcl-ds rtvm0100 qualified inz;
  bytRet          int(10);
  bytAvl          int(10);
  lenMsgRet       int(10);
  lenMsgAvl       int(10);
  lenHlpRet       int(10);
  lenHlpAvl       int(10);
  data            char(4096);
end-ds;
//
dcl-ds qMsgF qualified inz;
  name            char(10);
  lib             char(10);
end-ds;
//
dcl-ds errCode qualified inz;
  bytPrv          int(10);
  bytAvl          int(10);
end-ds;
//
//  Retrieve Message (QMHRTVM) API
dcl-pr QMHRTVM        extpgm('QMHRTVM');
  o_msgInf        char(32767) options(*varsize );
  i_length        int(10) const;
  i_format        char(8) const;
  i_msgID         char(7) const;
  i_qMsgF         char(20) const;
  i_rplData       char(32767) const  options(*varsize );
  i_rpldataLen    int(10) const;
  i_rplVars       char(10) const;
  i_rtnCtrlChrs   char(10) const;
  io_ErrCode      char(32767) options(*varsize );
end-pr;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

//
end-proc rtvMsgText;
//
//===============================================================*
//  *** private ***
//  Sends a message to the caller.
//===============================================================*
dcl-proc sndMsg;
//
dcl-pi sndMsg;
  i_text          varchar(128) value;
end-pi;
//
//  Return value
dcl-s pBuffer         pointer inz;
//
//  Local fields
dcl-s msgKey          char(4) inz;
//
dcl-ds qMsgF qualified            inz;
  name            char(10);
  lib             char(10);
end-ds;
//
dcl-ds errCode qualified            inz;
  bytPrv          int(10);
  bytAvl          int(10);
  excID           char(7);
  reserved        char(1);
  excDta          char(256);
end-ds;
//
//  Send Program Message (QMHSNDPM) API
dcl-pr QMHSNDPM        extpgm('QMHSNDPM');
  i_msgID         char(7) const;
  i_qMsgF         char(20) const;
  i_msgData       char(32767) const  options(*varsize );
  i_length        int(10) const;
  i_msgType       char(10) const;
  i_callStkE      char(32767) const  options(*varsize );
  i_callStkC      int(10) const;
  o_msgKey        char(4);
  io_ErrCode      char(32767) options(*varsize );
  i_lenStkE       int(10) const  options(*nopass  );
  i_callStkEQ     char(20) const  options(*nopass  );
  i_wait          int(10) const  options(*nopass  );
  i_callStkEDT    char(10) const  options(*nopass  );
  i_ccsid         int(10) const  options(*nopass  );
end-pr;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

clear qMsgF;
qMsgF.name = 'QCPFMSG';
qMsgF.lib  = '*LIBL';

clear errCode;
errCode.bytPrv = %size(errCode);

QMHSNDPM('CPF9897': qMsgF: i_text: %len(i_text): '*INFO'
         : '*CTLBDY': 1
         : msgKey: errCode);

return;

//
end-proc sndMsg;
//
//===============================================================*
//  Main procedure
//===============================================================*
dcl-proc main;
//
dcl-pi main;
end-pi;
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

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

//
end-proc main;
//
