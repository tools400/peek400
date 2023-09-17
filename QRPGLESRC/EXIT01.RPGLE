      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : EXIT01                                            *
      *  Typ      : RPGLE                                             *
      *                                                               *
      *  erstellt : 28.04.1999  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
      *  EXIT-Programm zur Prüfung der Sicherheitswerte:              *
      *                                                               *
      *     - Änderung der Bibliothek erlaubt                         *
      *     - Änderung der Datei erlaubt                              *
      *     - Änderung der Teildatei erlaubt                          *
      *     - Datensatzänderungen erlaubt                             *
      *     - Ändern SQL WHERE erlaubt                                *
      *     - Ändern SQL ORDER BY erlaubt                             *
      *     - Zugriff auf Datei erlaubt                               *
      *                                                               *
      *  Parameterliste:                                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
      *     Inp:  gi_qFile    - qualifizierter Dateiname              *
      *     Inp:  gi_mbr      - Teildatei                             *
      *     Inp:  gi_access   - Zugriffsmodus                         *
      *     I/O:  gio_chgL    - Änderung Bibliothek erlaubt           *
      *     I/O:  gio_chgF    - Änderung Datei erlaubt                *
      *     I/O:  gio_chgM    - Änderung Teildatei erlaubt            *
      *     I/O:  gio_updMd   - Datensatzänderung erlaubt             *
      *     I/O:  gio_updKy   - Schlüsseländerung erlaubt             *
      *     I/O:  gio_chgSqlW - Änderung SQL WHERE erlaubt            *
      *     I/O:  gio_chgSqlO - Änderung SQL ORDER BY erlaubt         *
      *     I/O:  gio_accAt   - allg. Zugriffsberechtigung            *
      *     Out:  go_msgID    - Nachrichten-ID                        *
      *     Out:  go_msgDta   - Nachrichtendaten                      *
      *                                                               *
      *  Herkunft der Eingangsparameter:                              *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                              *
      *     I/O:  gio_chgL    - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_chgF    - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_chgM    - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_updMd   - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_updKy   - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_chgSqlW - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_chgSqlO - Befehl PEEK oder *SECATRDFT wenn *DFT *
      *     I/O:  gio_accAt   - *SECATRDFT                            *
      *                                                               *
      *  Bis hierher gibt es keine Prioritäten bei der Ermittlung     *
      *  der Werte. Sofern im Befehl für einen der Parameter          *
      *  *YES oder *NO angegeben worden ist, so werden diese          *
      *  Werte verwendet. Bei *DFT werden die Werte aus *SECATRDFT    *
      *  benutzt.                                                     *
      *                                                               *
      *  Berechnen der Rückgabewerte:                                 *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                 *
      *  Die Ermittlung der Rückgabewerte erfolgt in folgender        *
      *  Reihenfolge:                                                 *
      *                                                               *
      *     (1) spez. Benutzerberechtigung für qualifiziertes Objekt  *
      *     (2) spez. Benutzerberechtigung für Objekt in *ALLLIB      *
      *     (3) allg. Objektberechtigung für qualifiziertes Objekt    *
      *     (4) allg. Objektberechtigung für Objekt in *ALLLIB        *
      *     (5) spez. *SECATR für einen Benutzer, Bibliothek          *
      *     (6) allg. *SECATR für einen Benutzer, *ALLLIB             *
      *     (7) spez. *SECATR für alle Benutzer, Bibliothek           *
      *     (8) allg. *SECATR für alle Benutzer, *ALLUSR              *
      *     (9) bisher ermittelte Berechtigung (Eing.Wert)            *
      *                                                               *
      *  Hinweise:                                                    *
      *  ¯¯¯¯¯¯¯¯¯                                                    *
      *  Im Systemwert *SECATRDFT werden die Standardwerte für        *
      *  die Benutzer definiert.                                      *
      *                                                               *
      *  Ohne Datensätze in der Datei EXIT01PF können diese Standard- *
      *  werte über die Parameterwerte des Befehls PEEK überschrieben *
      *  werden.                                                      *
      *                                                               *
      *  Mit Datensätzen in der Datei PEEK können diese Standardwerte *
      *  gezielt abgeändert werden. Hierbei haben die Werte aus       *
      *  der Datei EXIT01PF Vorrang vor den Standardwerten aus        *
      *  *SECATRDFT.                                                  *
      *                                                               *
      *  AUSNAHME:                                                    *
      *  Wenn in der EXIT01PF der Wert '-' (not defined) gefunden     *
      *  wird, wird der entsprechnde Wert aus *SECATRDFT genommen.    *
      *                                                               *
      *  Erstellen des Programms:                                     *
      *  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
      *  CRTRPGMOD MODULE(PEEK/EXIT01) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
      *  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT01)                       *
      *  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V4R5M0)                 *
      *                                                               *
      *  CRTPGM PGM(PEEK/EXIT01) MODULE(PEEK/EXIT01*)                 *
      *  BNDDIR( QC2LE PEEK) REPLACE(*YES)                            *
      *  TEXT('Peek/400 - EXIT-Programm: Berechtigungsprüfung')       *
      *  TGTRLS(V4R5M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FEXIT01PF  IF   E           K DISK    USROPN
     F                                     PREFIX(ex_)
     F                                     INFDS(file_ex)
      *
     Dfile_ex          DS
     D ex_open                 9      9A
     D ex_status              11     15S 0
     D ex_file                83     92A
     D ex_lib                 93    102A
     D ex_rcdLen             125    126I 0
     D ex_mbr                129    138A
     D ex_rcdNbr             397    400I 0
      *
      *  *ENTRY-Liste
     D gi_qFile        DS
     D  gi_file                            like(r§file    )
     D  gi_lib                             like(r§lib     )
     D gi_mbr          S                   like(r§mbr     )
     D gi_access       S                   like(r§accMode )
     D gio_chgL        S                   like(r§bool    )
     D gio_chgF        S                   like(r§bool    )
     D gio_chgM        S                   like(r§bool    )
     D gio_updMd       S                   like(r§bool    )
     D gio_updKy       S                   like(r§bool    )
     D gio_chgSqlW     S                   like(r§bool    )
     D gio_chgSqlO     S                   like(r§bool    )
     D gio_accAt       S                   like(r§bool    )
     D go_msgID        S                   like(r§msgID   )
     D go_msgDta       S                   like(r§msgDta  )
      *
      *---Referenzfelder & Konstanten----------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---------------------------------------------------------------*
      *  main prozedure
     D p_main          PR
      *---------------------------------------------------------------*
      *  get user authority
     D f_usrAut        PR                         like(r§bool    )
     D  o_usrChgL                                 like(r§bool    )
     D  o_usrChgF                                 like(r§bool    )
     D  o_usrChgM                                 like(r§bool    )
     D  o_usrUpdMd                                like(r§bool    )
     D  o_usrUpdKy                                like(r§bool    )
     D  o_usrChgSqlW                              like(r§bool    )
     D  o_usrChgSqlO                              like(r§bool    )
     D  o_usrAccAt                                like(r§bool    )
     D  i_user                             const  like(r§user    )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *---------------------------------------------------------------*
      *  get object authority
     D f_objAut        PR                         like(r§bool    )
     D  o_objChgL                                 like(r§bool    )
     D  o_objChgF                                 like(r§bool    )
     D  o_objChgM                                 like(r§bool    )
     D  o_objUpdMd                                like(r§bool    )
     D  o_objUpdKy                                like(r§bool    )
     D  o_objChgSqlW                              like(r§bool    )
     D  o_objChgSqlO                              like(r§bool    )
     D  o_objAccAt                                like(r§bool    )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *---------------------------------------------------------------*
      *  get *SECATR authority
     D f_secAut        PR                         like(r§bool    )
     D  o_secChgL                                 like(r§bool    )
     D  o_secChgF                                 like(r§bool    )
     D  o_secChgM                                 like(r§bool    )
     D  o_secUpdMd                                like(r§bool    )
     D  o_secUpdKy                                like(r§bool    )
     D  o_secChgSqlW                              like(r§bool    )
     D  o_secChgSqlO                              like(r§bool    )
     D  o_secAccAt                                like(r§bool    )
     D  i_user                             const  like(r§user    )
     D                                     options(*NOPASS:
     D                                             *OMIT  )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *---------------------------------------------------------------*
      *  merge authority
     D f_mrgAut        PR                         like(r§bool    )
     D  usrAut                             const  like(r§bool    )
     D  objAut                             const  like(r§bool    )
     D  secAut                             const  like(r§bool    )
     D  dftAut                             const  like(r§bool    )
      *---------------------------------------------------------------*
      *  open file
     D p_openFile      PR
      *---------------------------------------------------------------*
      *  test omitted parameter (CEETSTA)
     D p_testOmit      PR                  extproc('CEETSTA')
     D   isPresent                                like(r§int4)
     D   argNumber                         const  like(r§int4)
     D   fc                                       like(r§fc  )
     D                                     options(*OMIT)
      *---------------------------------------------------------------*
      *
      *---Nachrichtenaufbau-------------------------------------------*
      /COPY QCOPYLE,USR1000
      *---------------------------------------------------------------*
      *
      *---------------------------------------------------------------*
      *  Programminformationsdatenstruktur                            *
      *---------------------------------------------------------------*
     D                SDS
      * Programmname
     D  §§PgmName                    10A
      * Programmfehlerstatus
     D  §§PgmStat                     5S 0
      * vorheriger Programmfehlerstatus
     D  §§PrevStat                    5S 0
      * Letzte Anweisungsnummer
     D  §§LastSeq                     8A
      * Letzte Unterroutine
     D  §§LastSubr                    8A
      * Anzahl übergebener Parameter
     D  §§NbrParm                     3S 0
      * Fehler-Msg
     D  §§MsgID                       7A
      *  Fehler-Art
     D   §§MsgPrfx                    3A   OVERLAY(§§MsgID)
      *  Fehler-Nummer
     D   §§MsgNbr                     4A   OVERLAY(§§MsgID:4)
      * MI-Instruktions-Nr.
     D  §§MI_Instr                    4A
      * Arbeitsbereich für Nachrichten
     D  §§WorkArea                   30A
      * Programmbiblitohek
     D  §§PgmLib                     10A
      * CPF-Fehlertext
     D  §§MsgText                    80A
      * Kz der Ausnahmebedingung
     D  §§AUBE                        4A
      * unbenutzt
     D  §§Unused_1                   16A
      * Datumsformat
     D  §§DatFmt                      8A
      * Ersten 2 stellen von *YEAR
     D  §§Year                        2S 0
      * Letzte Dateioperation: Dateiname
     D  §§FileOpr                     8A
      * Datei-Staus-Information
     D  §§FileStat                   35A
      * Jobname
     D  §§Job                        10A
      * Benutzer
     D  §§User                       10A
      * Jobnummer
     D  §§JobNbr                      6S 0
      * Jobdatum, Aufbau wie UDATE
     D  §§JobD                        6S 0
      * Programm-Ausführungsdatum, Aufbau wie UDATE
     D  §§JobDate                     6S 0
      * Job-Zeit (HHMMSS)
     D  §§JobTime                     6S 0
      * Umwandlungsdatum
     D  §§CrtDate                     6A
      * Umwandlungszeit (HHMMSS)
     D  §§CrtTime                     6A
      * Compiler Version
     D  §§CompVer                     4A
      * Quellendatei
     D  §§SrcFile                    10A
      * Bibliothek mit Quellendatei
     D  §§SrcLib                     10A
      * Quellenteildatei
     D  §§SrcMbr                     10A
      * Program containing procedure
     D  §§PgmProc                    10A
      * Module containing procedure
     D  §§ModProc                    10A
      * unbenutzt
     D  §§Unused_2                   76A
      *
      *---------------------------------------------------------------*
     C     *ENTRY        Plist
     C                   Parm                    gi_qFile                       global, input
     C                   Parm                    gi_mbr                         global, input
     C                   Parm                    gi_access                      global, input
     C                   Parm                    gio_chgL                       global, I/O
     C                   Parm                    gio_chgF                       global, I/O
     C                   Parm                    gio_chgM                       global, I/O
     C                   Parm                    gio_updMd                      global, I/O
     C                   Parm                    gio_updKy                      global, I/O
     C                   Parm                    gio_chgSqlW                    global, I/O
     C                   Parm                    gio_chgSqlO                    global, I/O
     C                   Parm                    gio_accAt                      global, I/O
     C                   Parm                    go_msgID                       global, output
     C                   Parm                    go_msgDta                      global, output
      *
     C     ex_key3       Klist
     C                   Kfld                    ex_user
     C                   Kfld                    ex_file
     C                   Kfld                    ex_lib
      *
      *===============================================================*
      *    S T E U E R L E I S T E                                    *
      *===============================================================*
      *
     C                   Callp     p_main
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
      *
      *  lokale Arbeitsfelder
      *  ... ändern Bibliothek erlaubt
     D usrChgL         S                   like(r§bool    )
     D                                     inz(bFalse)
     D objChgL         S                   like(r§bool    )
     D                                     inz(bFalse)
     D secChgL         S                   like(r§bool    )
     D                                     inz(bFalse)
     D chgL            S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... ändern Datei erlaubt
     D usrChgF         S                   like(r§bool    )
     D                                     inz(bFalse)
     D objChgF         S                   like(r§bool    )
     D                                     inz(bFalse)
     D secChgF         S                   like(r§bool    )
     D                                     inz(bFalse)
     D chgF            S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... ändern Teildatei erlaubt
     D usrChgM         S                   like(r§bool    )
     D                                     inz(bFalse)
     D objChgM         S                   like(r§bool    )
     D                                     inz(bFalse)
     D secChgM         S                   like(r§bool    )
     D                                     inz(bFalse)
     D chgM            S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... Datensatzänderungen erlaubt
     D usrUpdMd        S                   like(r§bool    )
     D                                     inz(bFalse)
     D objUpdMd        S                   like(r§bool    )
     D                                     inz(bFalse)
     D secUpdMd        S                   like(r§bool    )
     D                                     inz(bFalse)
     D updMd           S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... Schlüsseländerung erlaubt
     D usrUpdKy        S                   like(r§bool    )
     D                                     inz(bFalse)
     D objUpdKy        S                   like(r§bool    )
     D                                     inz(bFalse)
     D secUpdKy        S                   like(r§bool    )
     D                                     inz(bFalse)
     D updKy           S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... ändern SQL WHERE erlaubt
     D usrChgSqlW      S                   like(r§bool    )
     D                                     inz(bFalse)
     D objChgSqlW      S                   like(r§bool    )
     D                                     inz(bFalse)
     D secChgSqlW      S                   like(r§bool    )
     D                                     inz(bFalse)
     D chgSqlW         S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... ändern SQL ORDERR BY erlaubt
     D usrChgSqlO      S                   like(r§bool    )
     D                                     inz(bFalse)
     D objChgSqlO      S                   like(r§bool    )
     D                                     inz(bFalse)
     D secChgSqlO      S                   like(r§bool    )
     D                                     inz(bFalse)
     D chgSqlO         S                   like(r§bool    )
     D                                     inz(bFalse)
      *  ... Zugriffsberechtigung
     D usrAccAt        S                   like(r§bool    )
     D                                     inz(bFalse)
     D objAccAt        S                   like(r§bool    )
     D                                     inz(bFalse)
     D secAccAt        S                   like(r§bool    )
     D                                     inz(bFalse)
     D accAt           S                   like(r§bool    )
     D                                     inz(bFalse)
      *---------------------------------------------------------------*
      *
      *  ermitteln Benutzerberechtigung ...
      *  ... genau diese Datei (Priorität 1)
     C                   If        f_usrAut(usrChgL   :
     C                                      usrChgF   :
     C                                      usrChgM   :
     C                                      usrUpdMd  :
     C                                      usrUpdKy  :
     C                                      usrChgSqlW:
     C                                      usrChgSqlO:
     C                                      usrAccAt  :
     C                                      §§user    :
     C                                      gi_file   :
     C                                      gi_lib    ) = bFalse
      *      ... alle Dateien diesen Typs (Priorität 2)
     C                   Callp     f_usrAut(usrChgL   :
     C                                      usrChgF   :
     C                                      usrChgM   :
     C                                      usrUpdMd  :
     C                                      usrUpdKy  :
     C                                      usrChgSqlW:
     C                                      usrChgSqlO:
     C                                      usrAccAt  :
     C                                      §§user    :
     C                                      gi_file   )
     C                   Endif
      *
      *  ermitteln Objektberechtigung ...
      *  ... genau diese Datei (Priorität 3)
     C                   If        f_objAut(objChgL   :
     C                                      objChgF   :
     C                                      objChgM   :
     C                                      objUpdMd  :
     C                                      objUpdKy  :
     C                                      objChgSqlW:
     C                                      objChgSqlO:
     C                                      objAccAt  :
     C                                      gi_file   :
     C                                      gi_lib    ) = bFalse
      *      ... alle Dateien diesen Typs (Priorität 4)
     C                   Callp     f_objAut(objChgL   :
     C                                      objChgF   :
     C                                      objChgM   :
     C                                      objUpdMd  :
     C                                      objUpdKy  :
     C                                      objChgSqlW:
     C                                      objChgSqlO:
     C                                      objAccAt  :
     C                                      gi_file   )
     C                   Endif
      *
      *  ermitteln *SECATR ...
      *  ... für diesen Benutzer, diese Bibliothek (Priorität 5)
     C                   If        f_secAut(secChgL   :
     C                                      secChgF   :
     C                                      secChgM   :
     C                                      secUpdMd  :
     C                                      secUpdKy  :
     C                                      secChgSqlW:
     C                                      secChgSqlO:
     C                                      secAccAt  :
     C                                      §§user    :
     C                                      gi_lib    ) = bFalse
      *      ... für diesen Benutzer (Priorität 6)
     C                   If        f_secAut(secChgL   :
     C                                      secChgF   :
     C                                      secChgM   :
     C                                      secUpdMd  :
     C                                      secUpdKy  :
     C                                      secChgSqlW:
     C                                      secChgSqlO:
     C                                      secAccAt  :
     C                                      §§user    )  = bFalse
      *          ... für alle Benutzer, diese Bibliothek (Priorität 7)
     C                   If        f_secAut(secChgL   :
     C                                      secChgF   :
     C                                      secChgM   :
     C                                      secUpdMd  :
     C                                      secUpdKy  :
     C                                      secChgSqlW:
     C                                      secChgSqlO:
     C                                      secAccAt  :
     C                                      *omit     :
     C                                      gi_lib    ) = bFalse
      *              ... für alle Benutzer (Priorität 8)
     C                   If        f_secAut(secChgL   :
     C                                      secChgF   :
     C                                      secChgM   :
     C                                      secUpdMd  :
     C                                      secUpdKy  :
     C                                      secChgSqlW:
     C                                      secChgSqlO:
     C                                      secAccAt  ) = bFalse
     C                   Endif
     C                   Endif
     C                   Endif
     C                   Endif
      *
      *  Verknüpfen Änderung der Bibliothek erlaubt aus
      *  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
     C                   Eval      chgL   = f_mrgAut(usrChgL   :
     C                                               objChgL   :
     C                                               secChgL   :
     C                                               gio_chgL  )
      *
      *  Verknüpfen Änderung der Datei erlaubt aus
      *  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
     C                   Eval      chgF   = f_mrgAut(usrChgF    :
     C                                               objChgF    :
     C                                               secChgF   :
     C                                               gio_chgF   )
      *
      *  Verknüpfen Änderung der Teildatei erlaubt aus
      *  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
     C                   Eval      chgM   = f_mrgAut(usrChgM   :
     C                                               objChgM   :
     C                                               secChgM   :
     C                                               gio_chgM  )
      *
      *  verknüpfen Objekt- und Benutzerberechtigung
      *  zur Datensatzänderungen (Prioritäten 1-9)
     C                   Eval      updMd  = f_mrgAut(usrUpdMd  :
     C                                               objUpdMd  :
     C                                               secUpdMd  :
     C                                               gio_updMd )
      *
      *  verknüpfen Objekt- und Benutzerberechtigung
      *  zur Schlüsseländerung (Prioritäten 1-9)
     C                   Eval      updKy  = f_mrgAut(usrUpdKy  :
     C                                               objUpdKy  :
     C                                               secUpdKy  :
     C                                               gio_updKy )
      *
      *  Verknüpfen Änderung SQL WHERE erlaubt aus
      *  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
     C                   Eval      chgSqlW= f_mrgAut(usrChgSqlW:
     C                                               objChgSqlW:
     C                                               secChgSqlW:
     C                                               gio_chgSqlW)
      *
      *  Verknüpfen Änderung SQL ORDER BY erlaubt aus
      *  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
     C                   Eval      chgSqlO= f_mrgAut(usrChgSqlO:
     C                                               objChgSqlO:
     C                                               secChgSqlO:
     C                                               gio_chgSqlO)
      *
      *  verknüpfen Objekt- und Benutzerberechtigung
      *  zur Zugriffsberechtigung (Prioritäten 1-9)
     C                   Eval      accAt  = f_mrgAut(usrAccAt  :
     C                                               objAccAt  :
     C                                               secAccAt  :
     C                                               gio_accAt )
      *
      *  Füllen Output-Parameter
     C                   Eval      gio_chgL    = chgL
     C                   Eval      gio_chgF    = chgF
     C                   Eval      gio_chgM    = chgM
     C                   Eval      gio_updMd   = updMd
     C                   Eval      gio_updKy   = updKy
     C                   Eval      gio_chgSqlW = chgSqlW
     C                   Eval      gio_chgSqlO = chgSqlO
      *
     C                   If        accAt  = bTrue
     C                   Eval      gio_accAt = bTrue
     C                   Eval      go_msgID  = ' '
     C                   Eval      go_msgDta = ' '
     C                   Else
     C                   Eval      gio_accAt = bFalse
     C                   Clear                   USR1000
     C                   Eval      USR10001  = gi_file
     C                   Eval      USR10002  = gi_lib
     C                   Eval      USR10003  = gi_mbr
     C                   Eval      go_msgID  = 'USR1000'
     C                   Eval      go_msgDta = USR1000
     C                   Endif
      *
     C                   Return
      *
     P p_main          E
      *
      *===============================================================*
      *    Funktion:                                                  *
      *    f_usrAut      Ermitteln Benutzerrechte                     *
      *===============================================================*
      *
     P f_usrAut        B
      *
     D f_usrAut        PI                         like(r§bool    )
     D  o_usrChgL                                 like(r§bool    )
     D  o_usrChgF                                 like(r§bool    )
     D  o_usrChgM                                 like(r§bool    )
     D  o_usrUpdMd                                like(r§bool    )
     D  o_usrUpdKy                                like(r§bool    )
     D  o_usrChgSqlW                              like(r§bool    )
     D  o_usrChgSqlO                              like(r§bool    )
     D  o_usrAccAt                                like(r§bool    )
     D  i_user                             const  like(r§user    )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *
      *  Funktionswert
     D  isFound        S                   like(r§bool    )
     D                                     inz(bFalse)
      *
      *  Hilfsfelder für optionale Parameter
     D  i5_lib         S                   like(i_lib     )
     D                                     inz
      *
      *  Parameterpositionen
     D p_lib           C                   11
      *
      *  lokale Arbeitsfelder
      *---------------------------------------------------------------*
      *
      *  Öffnen Datei
     C                   Callp     p_openFile
      *
      *  Prüfen optionale Parameter
     C                   If        %parms >= p_lib
     C                   Eval      i5_lib = i_lib
     C                   Else
     C                   Eval      i5_lib = '*ALLLIB'
     C                   Endif
      *
     C                   Eval      ex_user = i_user
     C                   Eval      ex_file = i_file
     C                   Eval      ex_lib  = i5_lib
     C     ex_key3       chain     FEXIT01                            01
     C                   If        *IN01 = *OFF
     C                   Eval      isFound     = bTrue
     C                   Eval      o_usrChgL   = ex_chgLib
     C                   Eval      o_usrChgF   = ex_chgFile
     C                   Eval      o_usrChgM   = ex_chgMbr
     C                   Eval      o_usrUpdMd  = ex_updMod
     C                   Eval      o_usrUpdKy  = ex_updKey
     C                   Eval      o_usrChgSqlW= ex_chgSqlW
     C                   Eval      o_usrChgSqlO= ex_chgSqlO
     C                   Eval      o_usrAccAt  = ex_accAut
     C                   Else
     C                   Eval      isFound     = bFalse
     C                   Eval      o_usrChgL   = bNotDef
     C                   Eval      o_usrChgF   = bNotDef
     C                   Eval      o_usrChgM   = bNotDef
     C                   Eval      o_usrUpdMd  = bNotDef
     C                   Eval      o_usrUpdKy  = bNotDef
     C                   Eval      o_usrChgSqlW= bNotDef
     C                   Eval      o_usrChgSqlO= bNotDef
     C                   Eval      o_usrAccAt  = bNotDef
     C                   Endif
      *
     C                   Return    isFound
      *
     P f_usrAut        E
      *
      *===============================================================*
      *    Funktion:                                                  *
      *    f_objAut      Ermitteln Objektberechtigung                 *
      *===============================================================*
      *
     P f_objAut        B
      *
     D f_objAut        PI                         like(r§bool    )
     D  o_objChgL                                 like(r§bool    )
     D  o_objChgF                                 like(r§bool    )
     D  o_objChgM                                 like(r§bool    )
     D  o_objUpdMd                                like(r§bool    )
     D  o_objUpdKy                                like(r§bool    )
     D  o_objChgSqlW                              like(r§bool    )
     D  o_objChgSqlO                              like(r§bool    )
     D  o_objAccAt                                like(r§bool    )
     D  i_file                             const  like(r§file    )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *
      *  Funktionswert
     D  isFound        S                   like(r§bool    )
     D                                     inz(bFalse)
      *
      *  Hilfsfelder für optionale Parameter
     D  i7_lib         S                   like(i_lib     )
     D                                     inz
      *
      *  Parameterpositionen
     D p_lib           C                   10
      *
      *  lokale Arbeitsfelder
      *---------------------------------------------------------------*
      *
      *  Öffnen Datei
     C                   Callp     p_openFile
      *
      *  Prüfen optionale Parameter
     C                   If        %parms >= p_lib
     C                   Eval      i7_lib = i_lib
     C                   Else
     C                   Eval      i7_lib = '*ALLLIB'
     C                   Endif
      *
     C                   Eval      ex_user = '*OBJ'
     C                   Eval      ex_file = i_file
     C                   Eval      ex_lib  = i7_lib
     C     ex_key3       chain     FEXIT01                            01
     C                   If        *IN01 = *OFF
     C                   Eval      isFound     = bTrue
     C                   Eval      o_objChgL   = ex_chgLib
     C                   Eval      o_objChgF   = ex_chgFile
     C                   Eval      o_objChgM   = ex_chgMbr
     C                   Eval      o_objUpdMd  = ex_updMod
     C                   Eval      o_objUpdKy  = ex_updKey
     C                   Eval      o_objChgSqlW= ex_chgSqlW
     C                   Eval      o_objChgSqlO= ex_chgSqlO
     C                   Eval      o_objAccAt  = ex_accAut
     C                   Else
     C                   Eval      isFound     = bFalse
     C                   Eval      o_objChgL   = bNotDef
     C                   Eval      o_objChgF   = bNotDef
     C                   Eval      o_objChgM   = bNotDef
     C                   Eval      o_objUpdMd  = bNotDef
     C                   Eval      o_objUpdKy  = bNotDef
     C                   Eval      o_objChgSqlW= bNotDef
     C                   Eval      o_objChgSqlO= bNotDef
     C                   Eval      o_objAccAt  = bNotDef
     C                   Endif
      *
     C                   Return    isFound
      *
     P f_objAut        E
      *
      *===============================================================*
      *    Funktion:                                                  *
      *    f_secAut      Ermitteln Sicherheitsstandardwerte           *
      *===============================================================*
      *
     P f_secAut        B
      *
     D f_secAut        PI                         like(r§bool    )
     D  o_secChgL                                 like(r§bool    )
     D  o_secChgF                                 like(r§bool    )
     D  o_secChgM                                 like(r§bool    )
     D  o_secUpdMd                                like(r§bool    )
     D  o_secUpdKy                                like(r§bool    )
     D  o_secChgSqlW                              like(r§bool    )
     D  o_secChgSqlO                              like(r§bool    )
     D  o_secAccAt                                like(r§bool    )
     D  i_user                             const  like(r§user    )
     D                                     options(*NOPASS:
     D                                             *OMIT  )
     D  i_lib                              const  like(r§lib     )
     D                                     options(*NOPASS)
      *
      *  Funktionswert
     D  isFound        S                   like(r§bool    )
     D                                     inz(bFalse)
      *
      *  Hilfsfelder für optionale Parameter
     D  i6_user        S                   like(i_user    )
     D                                     inz
     D  i7_lib         S                   like(i_lib     )
     D                                     inz
     D  isPresent      S                   like(r§int4    )
     D                                     inz
      *
      *  Parameterpositionen
     D p_user          C                   9
     D p_lib           C                   10
      *
      *  lokale Arbeitsfelder
      *---------------------------------------------------------------*
      *
      *  Öffnen Datei
     C                   Callp     p_openFile
      *
      *  Prüfen optionale Parameter ...
      *  ... user
     C                   If        %parms >= p_user
     C                   Callp     p_testOmit(isPresent: p_user: *omit)
     C                   If        isPresent = 1
     C                   Eval      i6_user = i_user
     C                   Else
     C                   Eval      i6_user = '*ALLUSR'
     C                   Endif
     C                   Else
     C                   Eval      i6_user = '*ALLUSR'
     C                   Endif
      *  ... user
     C                   If        %parms >= p_lib
     C                   Eval      i7_lib = i_lib
     C                   Else
     C                   Eval      i7_lib = '*ALLLIB'
     C                   Endif
      *
     C                   Eval      ex_user = i6_user
     C                   Eval      ex_file = '*SECATR'
     C                   Eval      ex_lib  = i7_lib
     C     ex_key3       chain     FEXIT01                            01
     C                   If        *IN01 = *OFF
     C                   Eval      isFound     = bTrue
     C                   Eval      o_secChgL   = ex_chgLib
     C                   Eval      o_secChgF   = ex_chgFile
     C                   Eval      o_secChgM   = ex_chgMbr
     C                   Eval      o_secUpdMd  = ex_updMod
     C                   Eval      o_secUpdKy  = ex_updKey
     C                   Eval      o_secChgSqlW= ex_chgSqlW
     C                   Eval      o_secChgSqlO= ex_chgSqlO
     C                   Eval      o_secAccAt  = ex_accAut
     C                   Else
     C                   Eval      isFound     = bFalse
     C                   Eval      o_secChgL   = bNotDef
     C                   Eval      o_secChgF   = bNotDef
     C                   Eval      o_secChgM   = bNotDef
     C                   Eval      o_secUpdMd  = bNotDef
     C                   Eval      o_secUpdKy  = bNotDef
     C                   Eval      o_secChgSqlW= bNotDef
     C                   Eval      o_secChgSqlO= bNotDef
     C                   Eval      o_secAccAt  = bNotDef
     C                   Endif
      *
     C                   Return    isFound
      *
     P f_secAut        E
      *
      *===============================================================*
      *    Funktion:                                                  *
      *    f_mrgAut     Verknüpfen Benutzer-/Objektrechte             *
      *===============================================================*
      *
     P f_mrgAut        B
      *
     D f_mrgAut        PI                         like(r§bool    )
     D  usrAut                             const  like(r§bool    )
     D  objAut                             const  like(r§bool    )
     D  secAut                             const  like(r§bool    )
     D  dftAut                             const  like(r§bool    )
      *
      *  Funktionswert
     D aut             S                   like(r§bool    )
      *
      *  Arbeitsfelder
     D tmpAut          S                   like(r§bool    )
      *---------------------------------------------------------------*
      *
      *  Wenn die Benutzerberechtigung definiert worden ist, ...
     C                   If        usrAut <> bNotDef
      *  ... dann
      *      benutzen Benutzerberechtigung   (Priorität 1, 2)
     C                   Eval      tmpAut = usrAut
     C                   Else
      *  ... sonst
      *      Wenn die Objektberechtigung definiert worden ist, dann ...
     C                   If        objAut <> bNotDef
      *      ... dann
      *          benutzen Objektberechtigung (Priorität 3, 4)
     C                   Eval      tmpAut = objAut
     C                   Else
      *      ... sonst
      *          Wenn die *SECATR Werte definiert worden sind, dann ...
     C                   If        secAut <> bNotDef
      *          ... dann
      *              benutzen *SECATR Werte (Priorität 5-8)
     C                   Eval      tmpAut = secAut
     C                   Else
      *          ... sonst
      *              erteilen Standardberechtigung (Priorität 9)
      *              (kommt aus Befehl PEEK oder aus der
      *              Benutzerdatei, Schlüssel *SECATRDFT)
     C                   Eval      tmpAut = dftAut
     C                   Endif
     C                   Endif
     C                   Endif
      *
     C                   eval      aut = tmpAut
      *
     C                   Return    aut
      *
     P f_mrgAut        E
      *
      *===============================================================*
      *    Prozedur:                                                  *
      *    p_openFile    Öffnen Datei                                 *
      *===============================================================*
      *
     P p_openFile      B
      *
     D p_openFile      PI
      *---------------------------------------------------------------*
      *
 B01R ***                If        not %open(EXIT01PF) nicht für V3R2 :-(
     C                   If        ex_open <> '1'
     C                   Open      EXIT01PF
     C                   Endif
      *
     P p_openFile      E
      *
