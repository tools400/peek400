      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.3.1                               *
      *  Programm : EXIT02                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 22.11.2004  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
      *  EXIT-Programm zur Ermittlung der Datei mit den               *
      *  Benutzereinstellungen (PEEKUSR).                             *
      *                                                               *
      *  Parameterliste:                                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
      *     I/O:  gio_user   - Name Benutzerprofil                    *
      *     I/O:  gio_file   - Name der Settings-Datei                *
      *     I/O:  gio_lib    - Bibliothek mit Settings-Datei          *
      *     Out:  go_msgID   - Nachrichten-ID                         *
      *     Out:  go_msgDta  - Nachrichtendaten                       *
      *                                                               *
      *  Berechnen der Rückgabewerte:                                 *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                 *
      *  In diesem Beispielprogramm wird der Name der Settings-Datei  *
      *  gleich einem im Benutzerprofil hinterlegten Gruppenprofil    *
      *  gesetzt.                                                     *
      *                                                               *
      *  Natürlich könnte der Name der Settings-Datei auch über eine  *
      *  andere Logik, bspw. einer Mapping-Datei ermittelt werden.    *
      *                                                               *
      *  Erstellen des Programms:                                     *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
      *  CRTRPGMOD MODULE(PEEK/EXIT02) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
      *  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT02)                       *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V4R5M0)                 *
      *                                                               *
      *  CRTPGM PGM(PEEK/EXIT02) MODULE(PEEK/EXIT02*)                 *
      *  BNDDIR( QC2LE PEEK) REPLACE(*YES)                            *
      *  TEXT('Peek/400 - EXIT-Programm: Ermitteln Settings Datei')   *
      *  TGTRLS(V4R5M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
      /include QCOPYLE,H_SPEC
      /include QCOPYLE,COPYRIGHT
      *
      *  *ENTRY-Liste
     D EXIT02          PR                         extpgm('EXIT02')
     D  gio_user                                  like(user_t)
     D  gio_file                                  like(file_t)
     D  gio_lib                                   like(lib_t)
     D  go_msgID                                  like(msgID_t)
     D  go_msgDta                                 like(msgDta_t)
      *
      *---Referenzfelder & Konstanten----------------------*
      /include QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---------------------------------------------------------------*
      *  main procedure
     D p_main          PR
     D  io_user                                   like(gio_user  )
     D  io_file                                   like(gio_file  )
     D  io_lib                                    like(gio_lib   )
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *
      *---------------------------------------------------------------*
      *  retrieve user profile information
     D f_rtvUsrPrfInf  PR           256A
     D  i_user                       10A   const
     D  i_format                      8A   const
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *---------------------------------------------------------------*
      *  Programminformationsdatenstruktur                            *
      *---------------------------------------------------------------*
     D sds            SDS                  qualified
      * Programmname
     D  PgmName                      10A
      * Programmfehlerstatus
     D  PgmStat                       5S 0
      * vorheriger Programmfehlerstatus
     D  PrevStat                      5S 0
      * Letzte Anweisungsnummer
     D  LastSeq                       8A
      * Letzte Unterroutine
     D  LastSubr                      8A
      * Anzahl übergebener Parameter
     D  NbrParm                       3S 0
      * Fehler-Msg
     D  MsgID                         7A
      *  Fehler-Art
     D   MsgPrfx                      3A   OVERLAY(MsgID)
      *  Fehler-Nummer
     D   MsgNbr                       4A   OVERLAY(MsgID:4)
      * MI-Instruktions-Nr.
     D  MI_Instr                      4A
      * Arbeitsbereich für Nachrichten
     D  WorkArea                     30A
      * Programmbiblitohek
     D  PgmLib                       10A
      * CPF-Fehlertext
     D  MsgText                      80A
      * Kz der Ausnahmebedingung
     D  AUBE                          4A
      * unbenutzt
     D  Unused_1                     16A
      * Datumsformat
     D  DatFmt                        8A
      * Ersten 2 stellen von *YEAR
     D  Year                          2S 0
      * Letzte Dateioperation: Dateiname
     D  FileOpr                       8A
      * Datei-Staus-Information
     D  FileStat                     35A
      * Jobname
     D  Job                          10A
      * Benutzer
     D  User                         10A
      * Jobnummer
     D  JobNbr                        6S 0
      * Jobdatum, Aufbau wie UDATE
     D  JobD                          6S 0
      * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  JobDate                       6S 0
      * Job-Zeit (HHMMSS)
     D  JobTime                       6S 0
      * Umwandlungsdatum
     D  CrtDate                       6A
      * Umwandlungszeit (HHMMSS)
     D  CrtTime                       6A
      * Compiler Version
     D  CompVer                       4A
      * Quellendatei
     D  SrcFile                      10A
      * Bibliothek mit Quellendatei
     D  SrcLib                       10A
      * Quellenteildatei
     D  SrcMbr                       10A
      * Program containing procedure
     D  PgmProc                      10A
      * Module containing procedure
     D  ModProc                      10A
      * unbenutzt
     D  Unused_2                     76A
      *
      *===============================================================*
      *    S T E U E R L E I S T E                                    *
      *===============================================================*
      *
     D EXIT02          PI
     D  gio_user                                  like(user_t)
     D  gio_file                                  like(file_t)
     D  gio_lib                                   like(lib_t)
     D  go_msgID                                  like(msgID_t)
     D  go_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------------------*
      *
     C                   Callp     p_main(gio_user  :
     C                                    gio_file  :
     C                                    gio_lib   :
     C                                    go_msgID  :
     C                                    go_msgDta )
      *
     C                   Eval      *INLR = *ON
      *
      *===============================================================*
      *    Prozedur:                                                  *
      *    p_main        Hauptprozedur (wegen lokaler Variablen)      *
      *===============================================================*
      *
     P p_main          B
      *
     D p_main          PI
     D  io_user                                   like(gio_user  )
     D  io_file                                   like(gio_file  )
     D  io_lib                                    like(gio_lib   )
     D  o_msgID                                   like(go_msgID  )
     D  o_msgDta                                  like(go_msgDta )
      *
      *  lokale Arbeitsfelder
     D USRI0200        DS           256
     D  UI2_bytRet             1      4I 0
     D  UI2_bytAvl             5      8I 0
     D  UI2_usrPrf             9     18A
     D  UI2_usrCls            19     28A
     D  UI2_spcAut            29     43A
     D  UI2_grpPrf            44     53A
     D  UI2_owner             54     63A
     D  UI2_grpAut            64     73A
     D  UI2_lmtCpb            74     83A
     D  UI2_grpAutTyp         84     93A
     D  UI2_reserved1         94     96A
     D  UI2_ofsSplGrp         97    100I 0
     D  UI2_numSplGrp        101    104I 0
      *---------------------------------------------------------------*
      *
      *  Use default settings: Name of settings file = user profile
     C                   If        (io_user = '*DFT')
     C                   Eval      io_user = sds.User
     C                   Endif
      *
     C                   If        (io_file = '*DFT')
     C                   Eval      io_file = sds.User
     C                   Eval      io_lib  = sds.PgmLib
     C                   Endif
      *
     C                   If        (io_lib = '*PRDLIB')
     C                   Eval      io_lib  = sds.PgmLib
     C                   Endif
      *
      *  Remove "Return" statement to override settings file and
      *  user name to group profile.
     C                   Return
      *
      *  Use group profile as name of settings file
     C                   Eval      USRI0200 = f_rtvUsrPrfInf(io_user    :
     C                                                       'USRI0200' :
     C                                                       o_msgID    :
     C                                                       o_msgDta   )
      *
     C                   If        o_msgID = ' '
     C                   Eval      io_user = UI2_grpPrf
     C                   Eval      io_file = UI2_grpPrf
     C                   Endif
      *
     C                   Return
      *
     P p_main          E
      *
      *===============================================================*
      *    Funktion:                                                  *
      *    Abrufen Informationen über Benutzerprofil                  *
      *===============================================================*
      *
     P f_rtvUsrPrfInf  B
      *
     D f_rtvUsrPrfInf  PI           256A
     D  i_user                       10A   const
     D  i_format                      8A   const
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
     D rcvVar          DS           256    inz
     D  rcv_bytRet                   10I 0 inz
     D  rcv_bytAvl                   10I 0 inz
      *
     D errCode         DS
     D  err_bytPrv                   10I 0 inz(%size(errCode))
     D  err_bytAvl                   10I 0 inz
     D  err_excID                     7A   inz
     D  err_reserved                  1A   inz
     D  err_excData                 256A   inz
      *
      *  Retrieve User Information (QSYRUSRI) API
     D QSYRUSRI        PR                  extpgm('QSYRUSRI')
     D  o_rcvVar                  65535A          options(*varsize)
     D  i_rcvVarLen                  10I 0 const
     D  i_format                      8A   const
     D  i_usrPrf                     10A   const
     D  io_errCode                65535A          options(*varsize)
      *---------------------------------------------------------------*
      *
     C                   Reset                   errCode
     C                   Callp     QSYRUSRI(rcvVar: %size(rcvVar): i_format:
     C                                      i_user: errCode)
      *
     C                   If        err_bytAvl <> 0
     C                   Eval      o_msgID  = err_excID
     C                   Eval      o_msgDta = err_excData
     C                   Else
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Endif
      *
     C                   Return    %subst(rcvVar: 1: rcv_bytRet)
      *
     P f_rtvUsrPrfInf  E
      *
