**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - EXIT-Programm: Ermitteln Settings Datei      *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.3.1                               *
//  Programm : EXIT02                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 22.11.2004  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//  ===================                                          *
//  EXIT-Programm zur Ermittlung der Datei mit den               *
//  Benutzereinstellungen (PEEKUSR).                             *
//                                                               *
//  Parameterliste:                                              *
//  ===============                                              *
//     I/O:  gio_user   - Name Benutzerprofil                    *
//     I/O:  gio_file   - Name der Settings-Datei                *
//     I/O:  gio_lib    - Bibliothek mit Settings-Datei          *
//     Out:  go_msgID   - Nachrichten-ID                         *
//     Out:  go_msgDta  - Nachrichtendaten                       *
//                                                               *
//  Berechnen der Rückgabewerte:                                 *
//  ============================                                 *
//  In diesem Beispielprogramm wird der Name der Settings-Datei  *
//  gleich einem im Benutzerprofil hinterlegten Gruppenprofil    *
//  gesetzt.                                                     *
//                                                               *
//  Natürlich könnte der Name der Settings-Datei auch über eine  *
//  andere Logik, bspw. einer Mapping-Datei ermittelt werden.    *
//                                                               *
//  Erstellen des Programms:                                     *
//  ========================                                     *
//  CRTRPGMOD MODULE(PEEK/EXIT02) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
//  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT02)                       *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V4R5M0)                 *
//                                                               *
//  CRTPGM PGM(PEEK/EXIT02) MODULE(PEEK/EXIT02*)                 *
//  BNDDIR( QC2LE PEEK) REPLACE(*YES)                            *
//  TEXT('Peek/400 - EXIT-Programm: Ermitteln Settings Datei')   *
//  TGTRLS(V4R5M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
//                                                               *
// ============================================================= *
/include QCOPYLE,H_SPEC
/include QCOPYLE,COPYRIGHT

/include QCOPYLE,D_VARDEF

/define internal_prototype
/include QCOPYLE,PEXIT02
/undefine internal_prototype

//  main procedure
dcl-pr p_main;
  io_user  like(gio_user);
  io_file  like(gio_file);
  io_lib   like(gio_lib);
  o_msgID  like(go_msgID);
  o_msgDta like(go_msgDta);
end-pr;

//  retrieve user profile information
dcl-pr f_rtvUsrPrfInf char(256);
  i_user   char(10) const;
  i_format char(8) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

//  Programminformationsdatenstruktur                            *
dcl-ds sds qualified psds;
  // Programmname
  pgmName  char(10);
  // Programmfehlerstatus
  pgmStat  zoned(5);
  // vorheriger Programmfehlerstatus
  prevStat zoned(5);
  // Letzte Anweisungsnummer
  lastSeq  char(8);
  // Letzte Unterroutine
  lastSubr char(8);
  // Anzahl übergebener Parameter
  nbrParm  zoned(3);
  // Fehler-Msg
  msgID    char(7);
  //  Fehler-Art
  msgPrfx  char(3) overlay(msgID);
  //  Fehler-Nummer
  msgNbr   char(4) overlay(msgID: 4);
  // MI-Instruktions-Nr.
  mi_instr char(4);
  // Arbeitsbereich für Nachrichten
  workArea char(30);
  // Programmbiblitohek
  pgmLib   char(10);
  // CPF-Fehlertext
  msgText  char(80);
  // Kz der Ausnahmebedingung
  aube     char(4);
  // unbenutzt
  unused_1 char(16);
  // Datumsformat
  datfmt   char(8);
  // Ersten 2 stellen von *YEAR
  year     zoned(2);
  // Letzte Dateioperation: Dateiname
  fileOpr  char(8);
  // Datei-Staus-Information
  fileStat char(35);
  // Jobname
  job      char(10);
  // Benutzer
  user     char(10);
  // Jobnummer
  jobNbr   zoned(6);
  // Jobdatum, Aufbau wie UDATE
  jobD     zoned(6);
  // Programm-Ausführungsdatum, Aufbau wie UDATE
  jobdate  zoned(6);
  // Job-Zeit (HHMMSS)
  jobTime  zoned(6);
  // Umwandlungsdatum
  crtDate  char(6);
  // Umwandlungszeit (HHMMSS)
  crtTime  char(6);
  // Compiler Version
  compVer  char(4);
  // Quellendatei
  srcFile  char(10);
  // Bibliothek mit Quellendatei
  srcLib   char(10);
  // Quellenteildatei
  srcMbr   char(10);
  // Program containing procedure
  pgmProc  char(10);
  // Module containing procedure
  modProc  char(10);
  // unbenutzt
  unused_2 char(76);
end-ds;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit02;
  gio_user  like(user_t);
  gio_file  like(file_t);
  gio_lib   like(lib_t);
  go_msgID  like(msgId_t);
  go_msgDta like(msgDta_t);
end-pi;

p_main(gio_user  :
      gio_file  :
      gio_lib   :
      go_msgID  :
      go_msgDta );

*inlr = *on;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*

dcl-proc p_main;
  dcl-pi *n;
    io_user  like(gio_user);
    io_file  like(gio_file);
    io_lib   like(gio_lib);
    o_msgID  like(go_msgID);
    o_msgDta like(go_msgDta);
  end-pi;

  //  lokale Arbeitsfelder
  dcl-ds usri0200 len(256);
    ui2_bytRet    int(10);
    ui2_bytAvl    int(10);
    ui2_usrPrf    char(10);
    ui2_usrCls    char(10);
    ui2_spcAut    char(15);
    ui2_grpPrf    char(10);
    ui2_owner     char(10);
    ui2_grpAut    char(10);
    ui2_lmtCpb    char(10);
    ui2_grpAutTyp char(10);
    ui2_reserved1 char(3);
    ui2_ofsSplGrp int(10);
    ui2_numSplGrp int(10);
  end-ds;
  //---------------------------------------------------------------*

  //  Use default settings: Name of settings file = user profile
  if (io_user = '*DFT');
    io_user = sds.user;
  endif;

  if (io_file = '*DFT');
    io_file = sds.user;
    io_lib  = sds.pgmLib;
  endif;

  if (io_lib = '*PRDLIB');
    io_lib  = sds.pgmLib;
  endif;

  //  Remove "Return" statement to override settings file and
  //  user name to group profile.
  return;

  //  Use group profile as name of settings file
  usri0200 = f_rtvUsrPrfInf(io_user    :
                           'USRI0200' :
                           o_msgID    :
                           o_msgDta   );

  if (o_msgID = ' ');
    io_user = ui2_grpPrf;
    io_file = ui2_grpPrf;
  endif;

  return;

end-proc;

//===============================================================*
//    Funktion:                                                  *
//    Abrufen Informationen über Benutzerprofil                  *
//===============================================================*

dcl-proc f_rtvUsrPrfInf;
  dcl-pi *n char(256);
    i_user   char(10) const;
    i_format char(8) const;
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  dcl-ds rcvVar len(256) inz;
    rcv_bytRet int(10) inz;
    rcv_bytAvl int(10) inz;
  end-ds;

  dcl-ds errCode;
    err_bytPrv   int(10) inz(%size(errCode));
    err_bytAvl   int(10) inz;
    err_excID    char(7) inz;
    err_reserved char(1) inz;
    err_excData  char(256) inz;
  end-ds;

  //  Retrieve User Information (QSYRUSRI) API
  dcl-pr qsyrusri extpgm('QSYRUSRI');
    o_rcvVar    char(65535) options(*varsize);
    i_rcvVarLen int(10) const;
    i_format    char(8) const;
    i_usrPrf    char(10) const;
    io_errCode  char(65535) options(*varsize);
  end-pr;
  //---------------------------------------------------------------*

  reset errCode;
  qsyrusri(rcvVar: %size(rcvVar): i_format:
          i_user: errCode);

  if (err_bytAvl <> 0);
    o_msgID  = err_excID;
    o_msgDta = err_excData;
  else;
    o_msgID  = ' ';
    o_msgDta = ' ';
  endif;

  return %subst(rcvVar: 1: rcv_bytRet);

end-proc;

