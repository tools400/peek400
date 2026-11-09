**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - EXIT-Programm: Berechtigungsprüfung          *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : EXIT01                                            *
//  Typ      : RPGLE                                             *
//                                                               *
//  erstellt : 28.04.1999  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//  ===================                                          *
//  EXIT-Programm zur Prüfung der Sicherheitswerte:              *
//                                                               *
//     - Änderung der Bibliothek erlaubt                         *
//     - Änderung der Datei erlaubt                              *
//     - Änderung der Teildatei erlaubt                          *
//     - Datensatzänderungen erlaubt                             *
//     - Ändern SQL WHERE erlaubt                                *
//     - Ändern SQL ORDER BY erlaubt                             *
//     - Zugriff auf Datei erlaubt                               *
//                                                               *
//  Das Exit-Programm muss in der Peek/400 Produktbibliothek     *
//  vorhanden sein.                                              *
//                                                               *
//  Parameterliste:                                              *
//  ===============                                              *
//     Inp:  gi_qFile    - qualifizierter Dateiname              *
//     Inp:  gi_mbr      - Teildatei                             *
//     Inp:  gi_access   - Zugriffsmodus                         *
//     I/O:  gio_chgL    - Änderung Bibliothek erlaubt           *
//     I/O:  gio_chgF    - Änderung Datei erlaubt                *
//     I/O:  gio_chgM    - Änderung Teildatei erlaubt            *
//     I/O:  gio_updMd   - Datensatzänderung erlaubt             *
//     I/O:  gio_updKy   - Schlüsseländerung erlaubt             *
//     I/O:  gio_chgSqlW - Änderung SQL WHERE erlaubt            *
//     I/O:  gio_chgSqlO - Änderung SQL ORDER BY erlaubt         *
//     I/O:  gio_accAt   - allg. Zugriffsberechtigung            *
//     Out:  go_msgID    - Nachrichten-ID                        *
//     Out:  go_msgDta   - Nachrichtendaten                      *
//                                                               *
//  Herkunft der Eingangsparameter:                              *
//  ===============================                              *
//     I/O:  gio_chgL    - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_chgF    - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_chgM    - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_updMd   - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_updKy   - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_chgSqlW - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_chgSqlO - Befehl PEEK oder *SECATRDFT wenn *DFT *
//     I/O:  gio_accAt   - *SECATRDFT                            *
//                                                               *
//  Bis hierher gibt es keine Prioritäten bei der Ermittlung     *
//  der Werte. Sofern im Befehl für einen der Parameter          *
//  *YES oder *NO angegeben worden ist, so werden diese          *
//  Werte verwendet. Bei *DFT werden die Werte aus *SECATRDFT    *
//  benutzt.                                                     *
//                                                               *
//  Berechnen der Rückgabewerte:                                 *
//  ============================                                 *
//  Die Ermittlung der Rückgabewerte erfolgt in folgender        *
//  Reihenfolge:                                                 *
//                                                               *
//     (1) spez. Benutzerberechtigung für qualifiziertes Objekt  *
//     (2) spez. Benutzerberechtigung für Objekt in *ALLLIB      *
//     (3) allg. Objektberechtigung für qualifiziertes Objekt    *
//     (4) allg. Objektberechtigung für Objekt in *ALLLIB        *
//     (5) spez. *SECATR für einen Benutzer, Bibliothek          *
//     (6) allg. *SECATR für einen Benutzer, *ALLLIB             *
//     (7) spez. *SECATR für alle Benutzer, Bibliothek           *
//     (8) allg. *SECATR für alle Benutzer, *ALLUSR              *
//     (9) bisher ermittelte Berechtigung (Eing.Wert)            *
//                                                               *
//  Hinweise:                                                    *
//  =========                                                    *
//  Im Systemwert *SECATRDFT werden die Standardwerte für        *
//  die Benutzer definiert.                                      *
//                                                               *
//  Ohne Datensätze in der Datei EXIT01PF können diese Standard- *
//  werte über die Parameterwerte des Befehls PEEK überschrieben *
//  werden.                                                      *
//                                                               *
//  Mit Datensätzen in der Datei PEEK können diese Standardwerte *
//  gezielt abgeändert werden. Hierbei haben die Werte aus       *
//  der Datei EXIT01PF Vorrang vor den Standardwerten aus        *
//  *SECATRDFT.                                                  *
//                                                               *
//  AUSNAHME:                                                    *
//  Wenn in der EXIT01PF der Wert '-' (not defined) gefunden     *
//  wird, wird der entsprechnde Wert aus *SECATRDFT genommen.    *
//                                                               *
//  Erstellen des Programms:                                     *
//  ========================                                     *
//  CRTRPGMOD MODULE(PEEK/EXIT01) DBGVIEW(*ALL) TRUNCNBR(*NO)    *
//  SRCFILE(PEEK/QRPGLESRC) SRCMBR(EXIT01)                       *
//  REPLACE(*YES) LANGID(*JOBRUN) TGTRLS(V4R5M0)                 *
//                                                               *
//  CRTPGM PGM(PEEK/EXIT01) MODULE(PEEK/EXIT01*)                 *
//  BNDDIR( QC2LE PEEK) REPLACE(*YES)                            *
//  TEXT('Peek/400 - EXIT-Programm: Berechtigungsprüfung')       *
//  TGTRLS(V4R5M0) DETAIL(*BASIC) ACTGRP(PEEK)                   *
//                                                               *
// ============================================================= *
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/include QCOPYLE,H_SPEC
/include QCOPYLE,COPYRIGHT

dcl-f exit01pf keyed usropn prefix(ex_);

/include QCOPYLE,D_VARDEF
/include QCOPYLE,USR1000
/include QCOPYLE,CEERTX
/include QCOPYLE,SDS

/define internal_prototype
/include QCOPYLE,PEXIT01
/undefine internal_prototype

//  main prozedure
dcl-pr p_main;
end-pr;

//===============================================================*
//    Program Entry Point                                        *
//===============================================================*
dcl-pi exit01;
  gi_qFile    likeds(qObj_t) const;
  gi_mbr      like(mbr_t) const;
  gi_access   like(accMode_t) const;
  gio_chgL    like(bool_t);
  gio_chgF    like(bool_t);
  gio_chgM    like(bool_t);
  gio_updMd   like(bool_t);
  gio_updKy   like(bool_t);
  gio_chgSqlW like(bool_t);
  gio_chgSqlO like(bool_t);
  gio_accAt   like(bool_t);
  go_msgID    like(msgId_t);
  go_msgDta   like(msgDta_t);
end-pi;

p_main();

*inlr = *on;

//===============================================================*
//    Main Procedure (local fields)                              *
//===============================================================*

dcl-proc p_main;
  dcl-pi *n;
  end-pi;

  //  lokale Arbeitsfelder
  //  ... Ändern Bibliothek erlaubt
  dcl-s usrChgL like(bool_t) inz(bFalse);
  dcl-s objChgL like(bool_t) inz(bFalse);
  dcl-s secChgL like(bool_t) inz(bFalse);
  dcl-s chgL like(bool_t) inz(bFalse);
  //  ... Ändern Datei erlaubt
  dcl-s usrChgF like(bool_t) inz(bFalse);
  dcl-s objChgF like(bool_t) inz(bFalse);
  dcl-s secChgF like(bool_t) inz(bFalse);
  dcl-s chgF like(bool_t) inz(bFalse);
  //  ... Ändern Teildatei erlaubt
  dcl-s usrChgM like(bool_t) inz(bFalse);
  dcl-s objChgM like(bool_t) inz(bFalse);
  dcl-s secChgM like(bool_t) inz(bFalse);
  dcl-s chgM like(bool_t) inz(bFalse);
  //  ... Datensatzänderungen erlaubt
  dcl-s usrUpdMd like(bool_t) inz(bFalse);
  dcl-s objUpdMd like(bool_t) inz(bFalse);
  dcl-s secUpdMd like(bool_t) inz(bFalse);
  dcl-s updMd like(bool_t) inz(bFalse);
  //  ... Schlüsseländerung erlaubt
  dcl-s usrUpdKy like(bool_t) inz(bFalse);
  dcl-s objUpdKy like(bool_t) inz(bFalse);
  dcl-s secUpdKy like(bool_t) inz(bFalse);
  dcl-s updKy like(bool_t) inz(bFalse);
  //  ... Ändern SQL WHERE erlaubt
  dcl-s usrChgSqlW like(bool_t) inz(bFalse);
  dcl-s objChgSqlW like(bool_t) inz(bFalse);
  dcl-s secChgSqlW like(bool_t) inz(bFalse);
  dcl-s chgSqlW like(bool_t) inz(bFalse);
  //  ... Ändern SQL ORDERR BY erlaubt
  dcl-s usrChgSqlO like(bool_t) inz(bFalse);
  dcl-s objChgSqlO like(bool_t) inz(bFalse);
  dcl-s secChgSqlO like(bool_t) inz(bFalse);
  dcl-s chgSqlO like(bool_t) inz(bFalse);
  //  ... Zugriffsberechtigung
  dcl-s usrAccAt like(bool_t) inz(bFalse);
  dcl-s objAccAt like(bool_t) inz(bFalse);
  dcl-s secAccAt like(bool_t) inz(bFalse);
  dcl-s accAt like(bool_t) inz(bFalse);

  //  ermitteln Benutzerberechtigung ...
  //  ... genau diese Datei (  Priorität 1)
  if (f_usrAut(usrChgL
               : usrChgF
               : usrChgM
               : usrUpdMd
               : usrUpdKy
               : usrChgSqlW
               : usrChgSqlO
               : usrAccAt
               : sds.user
               : gi_qFile.name
               : gi_qFile.lib) = bFalse);
    //      ... alle Dateien diesen Typs (Priorität 2)
    f_usrAut(usrChgL
             : usrChgF
             : usrChgM
             : usrUpdMd
             : usrUpdKy
             : usrChgSqlW
             : usrChgSqlO
             : usrAccAt
             : sds.user
             : gi_qFile.name);
  endif;

  //  ermitteln Objektberechtigung ...
  //  ... genau diese Datei (Priorität 3)
  if (f_objAut(objChgL
               : objChgF
               : objChgM
               : objUpdMd
               : objUpdKy
               : objChgSqlW
               : objChgSqlO
               : objAccAt
               : gi_qFile.name
               : gi_qFile.lib) = bFalse);
    //      ... alle Dateien diesen Typs (Priorität 4)
    f_objAut(objChgL
             : objChgF
             : objChgM
             : objUpdMd
             : objUpdKy
             : objChgSqlW
             : objChgSqlO
             : objAccAt
             : gi_qFile.name);
  endif;

  //  ermitteln *SECATR ...
  //  ... für diesen Benutzer, diese Bibliothek (Priorität 5)
  if (f_secAut(secChgL
               : secChgF
               : secChgM
               : secUpdMd
               : secUpdKy
               : secChgSqlW
               : secChgSqlO
               : secAccAt
               : sds.user
               : gi_qFile.lib) = bFalse);
    //      ... für diesen Benutzer (Priorität 6)
    if (f_secAut(secChgL
                 : secChgF
                 : secChgM
                 : secUpdMd
                 : secUpdKy
                 : secChgSqlW
                 : secChgSqlO
                 : secAccAt
                 : sds.user)  = bFalse);
      //          ... für alle Benutzer, diese Bibliothek (Priorität 7)
      if (f_secAut(secChgL
                   : secChgF
                   : secChgM
                   : secUpdMd
                   : secUpdKy
                   : secChgSqlW
                   : secChgSqlO
                   : secAccAt
                   : *omit
                   : gi_qFile.lib) = bFalse);
        //              ... für alle Benutzer (Priorität 8)
        if (f_secAut(secChgL
                     : secChgF
                     : secChgM
                     : secUpdMd
                     : secUpdKy
                     : secChgSqlW
                     : secChgSqlO
                     : secAccAt  ) = bFalse);
        endif;
      endif;
    endif;
  endif;

  //  Verknüpfen Änderung der Bibliothek erlaubt aus
  //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
  chgL   = f_mrgAut(usrChgL   :
                   objChgL   :
                   secChgL   :
                   gio_chgL  );

  //  Verknüpfen Änderung der Datei erlaubt aus
  //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
  chgF   = f_mrgAut(usrChgF    :
                   objChgF    :
                   secChgF   :
                   gio_chgF   );

  //  Verknüpfen Änderung der Teildatei erlaubt aus
  //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
  chgM   = f_mrgAut(usrChgM   :
                   objChgM   :
                   secChgM   :
                   gio_chgM  );

  //  verknüpfen Objekt- und Benutzerberechtigung
  //  zur Datensatzänderungen (Prioritäten 1-9)
  updMd  = f_mrgAut(usrUpdMd  :
                   objUpdMd  :
                   secUpdMd  :
                   gio_updMd );

  //  verknüpfen Objekt- und Benutzerberechtigung
  //  zur Schlüsseländerung (Prioritäten 1-9)
  updKy  = f_mrgAut(usrUpdKy  :
                   objUpdKy  :
                   secUpdKy  :
                   gio_updKy );

  //  Verknüpfen Änderung SQL WHERE erlaubt aus
  //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
  chgSqlW= f_mrgAut(usrChgSqlW:
                   objChgSqlW:
                   secChgSqlW:
                   gio_chgSqlW);

  //  Verknüpfen Änderung SQL ORDER BY erlaubt aus
  //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
  chgSqlO= f_mrgAut(usrChgSqlO:
                   objChgSqlO:
                   secChgSqlO:
                   gio_chgSqlO);

  //  verknüpfen Objekt- und Benutzerberechtigung
  //  zur Zugriffsberechtigung (Prioritäten 1-9)
  accAt  = f_mrgAut(usrAccAt  :
                   objAccAt  :
                   secAccAt  :
                   gio_accAt );

  //  Füllen Output-Parameter
  gio_chgL    = chgL;
  gio_chgF    = chgF;
  gio_chgM    = chgM;
  gio_updMd   = updMd;
  gio_updKy   = updKy;
  gio_chgSqlW = chgSqlW;
  gio_chgSqlO = chgSqlO;

  if (accAt  = bTrue);
    gio_accAt = bTrue;
    go_msgID  = ' ';
    go_msgDta = ' ';
  else;
    gio_accAt = bFalse;
    clear usr1000;
    usr1000.var1  = gi_qFile.name;
    usr1000.var2  = gi_qFile.lib;
    usr1000.var3  = gi_mbr;
    go_msgID  = 'USR1000';
    go_msgDta = usr1000;
  endif;

  return;

end-proc;

//===============================================================*
//    Funktion:                                                  *
//    f_usrAut      Ermitteln Benutzerrechte                     *
//===============================================================*

dcl-proc f_usrAut;
  dcl-pi *n like(bool_t);
    o_usrChgL    char(1);
    o_usrChgF    char(1);
    o_usrChgM    char(1);
    o_usrUpdMd   char(1);
    o_usrUpdKy   char(1);
    o_usrChgSqlW char(1);
    o_usrChgSqlO char(1);
    o_usrAccAt   char(1);
    i_user       like(user_t) const;
    i_file       like(file_t) const;
    i_lib        like(lib_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s isFound like(bool_t) inz(bFalse);

  //  Hilfsfelder für optionale Parameter
  dcl-s i5_lib like(i_lib) inz;

  //  lokale Arbeitsfelder
  dcl-ds ex_key3 likerec(FEXIT01: *KEY);

  //  Öffnen Datei
  p_openFile();

  //  Prüfen optionale Parameter
  if (%parms() >= %parmnum(i_lib));
    i5_lib = i_lib;
  else;
    i5_lib = '*ALLLIB';
  endif;

  clear ex_key3;
  ex_key3.ex_user = i_user;
  ex_key3.ex_file = i_file;
  ex_key3.ex_lib  = i5_lib;
  chain %kds(ex_key3: 3) fexit01;
  *in01 = not %found;
  if (*in01 = *off);
    isFound     = bTrue;
    o_usrChgL   = ex_chgLib;
    o_usrChgF   = ex_chgFile;
    o_usrChgM   = ex_chgMbr;
    o_usrUpdMd  = ex_updMod;
    o_usrUpdKy  = ex_updKey;
    o_usrChgSqlW= ex_chgSqlW;
    o_usrChgSqlO= ex_chgSqlO;
    o_usrAccAt  = ex_accAut;
  else;
    isFound     = bFalse;
    o_usrChgL   = bNotDef;
    o_usrChgF   = bNotDef;
    o_usrChgM   = bNotDef;
    o_usrUpdMd  = bNotDef;
    o_usrUpdKy  = bNotDef;
    o_usrChgSqlW= bNotDef;
    o_usrChgSqlO= bNotDef;
    o_usrAccAt  = bNotDef;
  endif;

  return isFound;

end-proc;

//===============================================================*
//    Funktion:                                                  *
//    f_objAut      Ermitteln Objektberechtigung                 *
//===============================================================*

dcl-proc f_objAut;
  dcl-pi *n like(bool_t);
    o_objChgL    char(1);
    o_objChgF    char(1);
    o_objChgM    char(1);
    o_objUpdMd   char(1);
    o_objUpdKy   char(1);
    o_objChgSqlW char(1);
    o_objChgSqlO char(1);
    o_objAccAt   char(1);
    i_file       like(file_t) const;
    i_lib        like(lib_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s isFound like(bool_t) inz(bFalse);

  //  Hilfsfelder für optionale Parameter
  dcl-s i7_lib like(i_lib);

  //  lokale Arbeitsfelder
  dcl-ds ex_key3 likerec(FEXIT01: *KEY);

  //  Öffnen Datei
  p_openFile();

  //  Prüfen optionale Parameter
  if (%parms() >= %parmnum(i_lib));
    i7_lib = i_lib;
  else;
    i7_lib = '*ALLLIB';
  endif;

  clear ex_key3;
  ex_key3.ex_user = '*OBJ';
  ex_key3.ex_file = i_file;
  ex_key3.ex_lib  = i7_lib;
  chain %kds(ex_key3: 3) fexit01;
  *in01 = not %found;
  if (*in01 = *off);
    isFound     = bTrue;
    o_objChgL   = ex_chgLib;
    o_objChgF   = ex_chgFile;
    o_objChgM   = ex_chgMbr;
    o_objUpdMd  = ex_updMod;
    o_objUpdKy  = ex_updKey;
    o_objChgSqlW= ex_chgSqlW;
    o_objChgSqlO= ex_chgSqlO;
    o_objAccAt  = ex_accAut;
  else;
    isFound     = bFalse;
    o_objChgL   = bNotDef;
    o_objChgF   = bNotDef;
    o_objChgM   = bNotDef;
    o_objUpdMd  = bNotDef;
    o_objUpdKy  = bNotDef;
    o_objChgSqlW= bNotDef;
    o_objChgSqlO= bNotDef;
    o_objAccAt  = bNotDef;
  endif;

  return isFound;

end-proc;

//===============================================================*
//    Funktion:                                                  *
//    f_secAut      Ermitteln Sicherheitsstandardwerte           *
//===============================================================*

dcl-proc f_secAut;
  dcl-pi *n like(bool_t);
    o_secChgL    char(1);
    o_secChgF    char(1);
    o_secChgM    char(1);
    o_secUpdMd   char(1);
    o_secUpdKy   char(1);
    o_secChgSqlW char(1);
    o_secChgSqlO char(1);
    o_secAccAt   char(1);
    i_user       like(user_t) options(*nopass: *omit) const;
    i_lib        like(lib_t) options(*nopass) const;
  end-pi;

  //  Funktionswert
  dcl-s isFound like(bool_t) inz(bFalse);

  //  Hilfsfelder für optionale Parameter
  dcl-s i6_user like(i_user);
  dcl-s i7_lib like(i_lib);

  //  lokale Arbeitsfelder
  dcl-ds ex_key3 likerec(FEXIT01: *KEY);

  //  Öffnen Datei
  p_openFile();

  //  Prüfen optionale Parameter ...
  //  ... user
  if (%parms() >= %parmnum(i_user));
    if (%addr(i_user) <> *null);
      i6_user = i_user;
    else;
      i6_user = '*ALLUSR';
    endif;
  else;
    i6_user = '*ALLUSR';
  endif;
  //  ... library
  if (%parms() >= %parmnum(i_lib));
    i7_lib = i_lib;
  else;
    i7_lib = '*ALLLIB';
  endif;

  clear ex_key3;
  ex_key3.ex_user = i6_user;
  ex_key3.ex_file = '*SECATR';
  ex_key3.ex_lib  = i7_lib;
  chain %kds(ex_key3: 3) fexit01;
  *in01 = not %found;
  if (*in01 = *off);
    isFound     = bTrue;
    o_secChgL   = ex_chgLib;
    o_secChgF   = ex_chgFile;
    o_secChgM   = ex_chgMbr;
    o_secUpdMd  = ex_updMod;
    o_secUpdKy  = ex_updKey;
    o_secChgSqlW= ex_chgSqlW;
    o_secChgSqlO= ex_chgSqlO;
    o_secAccAt  = ex_accAut;
  else;
    isFound     = bFalse;
    o_secChgL   = bNotDef;
    o_secChgF   = bNotDef;
    o_secChgM   = bNotDef;
    o_secUpdMd  = bNotDef;
    o_secUpdKy  = bNotDef;
    o_secChgSqlW= bNotDef;
    o_secChgSqlO= bNotDef;
    o_secAccAt  = bNotDef;
  endif;

  return isFound;

end-proc;

//===============================================================*
//    Funktion:                                                  *
//    f_mrgAut     Verknüpfen Benutzer-/Objektrechte             *
//===============================================================*

dcl-proc f_mrgAut;
  dcl-pi *n like(bool_t);
    usrAut like(bool_t) const;
    objAut like(bool_t) const;
    secAut like(bool_t) const;
    dftAut like(bool_t) const;
  end-pi;

  //  Funktionswert
  dcl-s aut like(bool_t);

  //  Arbeitsfelder
  dcl-s tmpAut like(bool_t);
  //---------------------------------------------------------------*

  //  Wenn die Benutzerberechtigung definiert worden ist, ...
  if (usrAut <> bNotDef);
    //  ... dann
    //      benutzen Benutzerberechtigung   (Priorität 1, 2)
    tmpAut = usrAut;
  else;
    //  ... sonst
    //      Wenn die Objektberechtigung definiert worden ist, dann ...
    if (objAut <> bNotDef);
      //      ... dann
      //          benutzen Objektberechtigung (Priorität 3, 4)
      tmpAut = objAut;
    else;
      //      ... sonst
      //          Wenn die *SECATR Werte definiert worden sind, dann ...
      if (secAut <> bNotDef);
        //          ... dann
        //              benutzen *SECATR Werte (Priorität 5-8)
        tmpAut = secAut;
      else;
        //          ... sonst
        //              erteilen Standardberechtigung (Priorität 9)
        //              (kommt aus Befehl PEEK oder aus der
        //              Benutzerdatei, Schlüssel *SECATRDFT)
        tmpAut = dftAut;
      endif;
    endif;
  endif;

  aut = tmpAut;

  return aut;

end-proc;

//===============================================================*
//    Prozedur:                                                  *
//    p_openFile    Öffnen Datei                                 *
//===============================================================*

dcl-proc p_openFile;
  dcl-pi *n;
  end-pi;

  if (not %open(exit01pf));
    open exit01pf;
  endif;

end-proc;

