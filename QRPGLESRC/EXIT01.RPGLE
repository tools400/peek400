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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                              *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                 *
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
       //  ¯¯¯¯¯¯¯¯¯                                                    *
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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
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

      /define internal_prototype
      /include QCOPYLE,PEXIT01
      /undefine internal_prototype

       //  main prozedure
       dcl-pr p_main;
       end-pr;

       //  test omitted parameter (CEETSTA)
       dcl-pr p_testomit extproc('CEETSTA');
         ispresent       like(int4_t);
         argnumber       const  like(int4_t);
         fc              like(fc_t) options(*omit);
       end-pr;

       //  Programminformationsdatenstruktur
       dcl-ds sds qualified psds;
         // Programmname
         pgmname         char(10);
         // Programmfehlerstatus
         pgmstat         zoned(5);
         // vorheriger Programmfehlerstatus
         prevstat        zoned(5);
         // Letzte Anweisungsnummer
         lastseq         char(8);
         // Letzte Unterroutine
         lastsubr        char(8);
         // Anzahl übergebener Parameter
         nbrparm         zoned(3);
         // Fehler-Msg
         msgid           char(7);
         //  Fehler-Art
         msgprfx         char(3) overlay(msgid);
         //  Fehler-Nummer
         msgnbr          char(4) overlay(msgid:4);
         // MI-Instruktions-Nr.
         mi_instr        char(4);
         // Arbeitsbereich für Nachrichten
         workarea        char(30);
         // Programmbiblitohek
         pgmlib          char(10);
         // CPF-Fehlertext
         msgtext         char(80);
         // Kz der Ausnahmebedingung
         aube            char(4);
         // unbenutzt
         unused_1        char(16);
         // Datumsformat
         datfmt          char(8);
         // Ersten 2 stellen von *YEAR
         year            zoned(2);
         // Letzte Dateioperation: Dateiname
         fileopr         char(8);
         // Datei-Staus-Information
         filestat        char(35);
         // Jobname
         job             char(10);
         // Benutzer
         user            char(10);
         // Jobnummer
         jobnbr          zoned(6);
         // Jobdatum, Aufbau wie UDATE
         jobd            zoned(6);
         // Programm-Ausführungsdatum, Aufbau wie UDATE
         jobdate         zoned(6);
         // Job-Zeit (HHMMSS)
         jobtime         zoned(6);
         // Umwandlungsdatum
         crtdate         char(6);
         // Umwandlungszeit (HHMMSS)
         crttime         char(6);
         // Compiler Version
         compver         char(4);
         // Quellendatei
         srcfile         char(10);
         // Bibliothek mit Quellendatei
         srclib          char(10);
         // Quellenteildatei
         srcmbr          char(10);
         // Program containing procedure
         pgmproc         char(10);
         // Module containing procedure
         modproc         char(10);
         // unbenutzt
         unused_2        char(76);
       end-ds;

       //===============================================================*
       //    Program Entry Point                                        *
       //===============================================================*
       dcl-pi exit01;
         gi_qFile        const likeds(qObj_t);
         gi_mbr          const like(mbr_t);
         gi_access       const like(accmode_t);
         gio_chgl              like(bool_t);
         gio_chgf              like(bool_t);
         gio_chgm              like(bool_t);
         gio_updmd             like(bool_t);
         gio_updky             like(bool_t);
         gio_chgsqlw           like(bool_t);
         gio_chgsqlo           like(bool_t);
         gio_accat             like(bool_t);
         go_msgid              like(msgid_t);
         go_msgdta             like(msgdta_t);
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
       //  ... ändern Bibliothek erlaubt
       dcl-s usrchgl         like(bool_t) inz(bfalse);
       dcl-s objchgl         like(bool_t) inz(bfalse);
       dcl-s secchgl         like(bool_t) inz(bfalse);
       dcl-s chgl            like(bool_t) inz(bfalse);
       //  ... ändern Datei erlaubt
       dcl-s usrchgf         like(bool_t) inz(bfalse);
       dcl-s objchgf         like(bool_t) inz(bfalse);
       dcl-s secchgf         like(bool_t) inz(bfalse);
       dcl-s chgf            like(bool_t) inz(bfalse);
       //  ... ändern Teildatei erlaubt
       dcl-s usrchgm         like(bool_t) inz(bfalse);
       dcl-s objchgm         like(bool_t) inz(bfalse);
       dcl-s secchgm         like(bool_t) inz(bfalse);
       dcl-s chgm            like(bool_t) inz(bfalse);
       //  ... Datensatzänderungen erlaubt
       dcl-s usrupdmd        like(bool_t) inz(bfalse);
       dcl-s objupdmd        like(bool_t) inz(bfalse);
       dcl-s secupdmd        like(bool_t) inz(bfalse);
       dcl-s updmd           like(bool_t) inz(bfalse);
       //  ... Schlüsseländerung erlaubt
       dcl-s usrupdky        like(bool_t) inz(bfalse);
       dcl-s objupdky        like(bool_t) inz(bfalse);
       dcl-s secupdky        like(bool_t) inz(bfalse);
       dcl-s updky           like(bool_t) inz(bfalse);
       //  ... ändern SQL WHERE erlaubt
       dcl-s usrchgsqlw      like(bool_t) inz(bfalse);
       dcl-s objchgsqlw      like(bool_t) inz(bfalse);
       dcl-s secchgsqlw      like(bool_t) inz(bfalse);
       dcl-s chgsqlw         like(bool_t) inz(bfalse);
       //  ... ändern SQL ORDERR BY erlaubt
       dcl-s usrchgsqlo      like(bool_t) inz(bfalse);
       dcl-s objchgsqlo      like(bool_t) inz(bfalse);
       dcl-s secchgsqlo      like(bool_t) inz(bfalse);
       dcl-s chgsqlo         like(bool_t) inz(bfalse);
       //  ... Zugriffsberechtigung
       dcl-s usraccat        like(bool_t) inz(bfalse);
       dcl-s objaccat        like(bool_t) inz(bfalse);
       dcl-s secaccat        like(bool_t) inz(bfalse);
       dcl-s accat           like(bool_t) inz(bfalse);

       //  ermitteln Benutzerberechtigung ...
       //  ... genau diese Datei (Priorität 1)
       if f_usraut(usrchgl
                   : usrchgf
                   : usrchgm
                   : usrupdmd
                   : usrupdky
                   : usrchgsqlw
                   : usrchgsqlo
                   : usraccat
                   : sds.user
                   : gi_qFile.name
                   : gi_qFile.lib) = bfalse;
          //      ... alle Dateien diesen Typs (Priorität 2)
          f_usraut(usrchgl
                   : usrchgf
                   : usrchgm
                   : usrupdmd
                   : usrupdky
                   : usrchgsqlw
                   : usrchgsqlo
                   : usraccat
                   : sds.user
                   : gi_qFile.name);
       endif;

       //  ermitteln Objektberechtigung ...
       //  ... genau diese Datei (Priorität 3)
       if f_objaut(objchgl
                   : objchgf
                   : objchgm
                   : objupdmd
                   : objupdky
                   : objchgsqlw
                   : objchgsqlo
                   : objaccat
                   : gi_qFile.name
                   : gi_qFile.lib) = bfalse;
          //      ... alle Dateien diesen Typs (Priorität 4)
          f_objaut(objchgl
                   : objchgf
                   : objchgm
                   : objupdmd
                   : objupdky
                   : objchgsqlw
                   : objchgsqlo
                   : objaccat
                   : gi_qFile.name);
       endif;

       //  ermitteln *SECATR ...
       //  ... für diesen Benutzer, diese Bibliothek (Priorität 5)
       if f_secaut(secchgl
                   : secchgf
                   : secchgm
                   : secupdmd
                   : secupdky
                   : secchgsqlw
                   : secchgsqlo
                   : secaccat
                   : sds.user
                   : gi_qFile.lib) = bfalse;
          //      ... für diesen Benutzer (Priorität 6)
          if f_secaut(secchgl
                      : secchgf
                      : secchgm
                      : secupdmd
                      : secupdky
                      : secchgsqlw
                      : secchgsqlo
                      : secaccat
                      : sds.user)  = bfalse;
             //          ... für alle Benutzer, diese Bibliothek (Priorität 7)
             if f_secaut(secchgl
                         : secchgf
                         : secchgm
                         : secupdmd
                         : secupdky
                         : secchgsqlw
                         : secchgsqlo
                         : secaccat
                         : *omit
                         : gi_qFile.lib) = bfalse;
                //              ... für alle Benutzer (Priorität 8)
                if f_secaut(secchgl
                            : secchgf
                            : secchgm
                            : secupdmd
                            : secupdky
                            : secchgsqlw
                            : secchgsqlo
                            : secaccat  ) = bfalse;
                endif;
             endif;
          endif;
       endif;

       //  Verknüpfen Änderung der Bibliothek erlaubt aus
       //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
       chgl   = f_mrgaut(usrchgl   :
                        objchgl   :
                        secchgl   :
                        gio_chgl  );

       //  Verknüpfen Änderung der Datei erlaubt aus
       //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
       chgf   = f_mrgaut(usrchgf    :
                        objchgf    :
                        secchgf   :
                        gio_chgf   );

       //  Verknüpfen Änderung der Teildatei erlaubt aus
       //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
       chgm   = f_mrgaut(usrchgm   :
                        objchgm   :
                        secchgm   :
                        gio_chgm  );

       //  verknüpfen Objekt- und Benutzerberechtigung
       //  zur Datensatzänderungen (Prioritäten 1-9)
       updmd  = f_mrgaut(usrupdmd  :
                        objupdmd  :
                        secupdmd  :
                        gio_updmd );

       //  verknüpfen Objekt- und Benutzerberechtigung
       //  zur Schlüsseländerung (Prioritäten 1-9)
       updky  = f_mrgaut(usrupdky  :
                        objupdky  :
                        secupdky  :
                        gio_updky );

       //  Verknüpfen Änderung SQL WHERE erlaubt aus
       //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
       chgsqlw= f_mrgaut(usrchgsqlw:
                        objchgsqlw:
                        secchgsqlw:
                        gio_chgsqlw);

       //  Verknüpfen Änderung SQL ORDER BY erlaubt aus
       //  Objekt- und Benutzerberechtigung (Prioritäten 1-9)
       chgsqlo= f_mrgaut(usrchgsqlo:
                        objchgsqlo:
                        secchgsqlo:
                        gio_chgsqlo);

       //  verknüpfen Objekt- und Benutzerberechtigung
       //  zur Zugriffsberechtigung (Prioritäten 1-9)
       accat  = f_mrgaut(usraccat  :
                        objaccat  :
                        secaccat  :
                        gio_accat );

       //  Füllen Output-Parameter
       gio_chgl    = chgl;
       gio_chgf    = chgf;
       gio_chgm    = chgm;
       gio_updmd   = updmd;
       gio_updky   = updky;
       gio_chgsqlw = chgsqlw;
       gio_chgsqlo = chgsqlo;

       if accat  = btrue;
          gio_accat = btrue;
          go_msgid  = ' ';
          go_msgdta = ' ';
       else;
          gio_accat = bfalse;
          clear usr1000;
          usr1000.var1  = gi_qFile.name;
          usr1000.var2  = gi_qFile.lib;
          usr1000.var3  = gi_mbr;
          go_msgid  = 'USR1000';
          go_msgdta = usr1000;
       endif;

       return;

       end-proc;

       //===============================================================*
       //    Funktion:                                                  *
       //    f_usrAut      Ermitteln Benutzerrechte                     *
       //===============================================================*

       dcl-proc f_usraut;
       dcl-pi *n like(bool_t);
         o_usrchgl       like(bool_t);
         o_usrchgf       like(bool_t);
         o_usrchgm       like(bool_t);
         o_usrupdmd      like(bool_t);
         o_usrupdky      like(bool_t);
         o_usrchgsqlw    like(bool_t);
         o_usrchgsqlo    like(bool_t);
         o_usraccat      like(bool_t);
         i_user          const  like(user_t);
         i_file          const  like(file_t);
         i_lib           const  like(lib_t) options(*nopass);
       end-pi;

       //  Funktionswert
       dcl-s isfound         like(bool_t) inz(bfalse);

       //  Hilfsfelder für optionale Parameter
       dcl-s i5_lib          like(i_lib     ) inz;

       //  Parameterpositionen
       dcl-c p_lib 11;

       //  lokale Arbeitsfelder
       dcl-ds ex_key3 likerec(FEXIT01: *KEY);

       //  Öffnen Datei
       p_openfile();

       //  Prüfen optionale Parameter
       if %parms >= p_lib;
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
       if *in01 = *off;
          isfound     = btrue;
          o_usrchgl   = ex_chglib;
          o_usrchgf   = ex_chgfile;
          o_usrchgm   = ex_chgmbr;
          o_usrupdmd  = ex_updmod;
          o_usrupdky  = ex_updkey;
          o_usrchgsqlw= ex_chgsqlw;
          o_usrchgsqlo= ex_chgsqlo;
          o_usraccat  = ex_accaut;
       else;
          isfound     = bfalse;
          o_usrchgl   = bnotdef;
          o_usrchgf   = bnotdef;
          o_usrchgm   = bnotdef;
          o_usrupdmd  = bnotdef;
          o_usrupdky  = bnotdef;
          o_usrchgsqlw= bnotdef;
          o_usrchgsqlo= bnotdef;
          o_usraccat  = bnotdef;
       endif;

       return isfound;

       end-proc;

       //===============================================================*
       //    Funktion:                                                  *
       //    f_objAut      Ermitteln Objektberechtigung                 *
       //===============================================================*

       dcl-proc f_objaut;

       dcl-pi *n like(bool_t);
         o_objchgl       like(bool_t);
         o_objchgf       like(bool_t);
         o_objchgm       like(bool_t);
         o_objupdmd      like(bool_t);
         o_objupdky      like(bool_t);
         o_objchgsqlw    like(bool_t);
         o_objchgsqlo    like(bool_t);
         o_objaccat      like(bool_t);
         i_file          const like(file_t);
         i_lib           const like(lib_t) options(*nopass);
       end-pi;

       //  Funktionswert
       dcl-s isfound         like(bool_t) inz(bfalse);

       //  Hilfsfelder für optionale Parameter
       dcl-s i7_lib          like(i_lib     ) inz;

       //  Parameterpositionen
       dcl-c p_lib 10;

       //  lokale Arbeitsfelder
       dcl-ds ex_key3 likerec(FEXIT01: *KEY);

       //  Öffnen Datei
       p_openfile();

       //  Prüfen optionale Parameter
       if %parms >= p_lib;
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
       if *in01 = *off;
          isfound     = btrue;
          o_objchgl   = ex_chglib;
          o_objchgf   = ex_chgfile;
          o_objchgm   = ex_chgmbr;
          o_objupdmd  = ex_updmod;
          o_objupdky  = ex_updkey;
          o_objchgsqlw= ex_chgsqlw;
          o_objchgsqlo= ex_chgsqlo;
          o_objaccat  = ex_accaut;
       else;
          isfound     = bfalse;
          o_objchgl   = bnotdef;
          o_objchgf   = bnotdef;
          o_objchgm   = bnotdef;
          o_objupdmd  = bnotdef;
          o_objupdky  = bnotdef;
          o_objchgsqlw= bnotdef;
          o_objchgsqlo= bnotdef;
          o_objaccat  = bnotdef;
       endif;

       return isfound;

       end-proc;

       //===============================================================*
       //    Funktion:                                                  *
       //    f_secAut      Ermitteln Sicherheitsstandardwerte           *
       //===============================================================*

       dcl-proc f_secaut;
       dcl-pi *n like(bool_t);
         o_secchgl       like(bool_t);
         o_secchgf       like(bool_t);
         o_secchgm       like(bool_t);
         o_secupdmd      like(bool_t);
         o_secupdky      like(bool_t);
         o_secchgsqlw    like(bool_t);
         o_secchgsqlo    like(bool_t);
         o_secaccat      like(bool_t);
         i_user          const like(user_t) options(*nopass:*omit);
         i_lib           const like(lib_t) options(*nopass);
       end-pi;

       //  Funktionswert
       dcl-s isfound         like(bool_t) inz(bfalse);

       //  Hilfsfelder für optionale Parameter
       dcl-s i6_user         like(i_user    ) inz;
       dcl-s i7_lib          like(i_lib     ) inz;
       dcl-s ispresent       like(int4_t) inz;

       //  Parameterpositionen
       dcl-c p_user 9;
       dcl-c p_lib 10;

       //  lokale Arbeitsfelder
       dcl-ds ex_key3 likerec(FEXIT01: *KEY);

       //  Öffnen Datei
       p_openfile();

       //  Prüfen optionale Parameter ...
       //  ... user
       if %parms >= p_user;
          p_testomit(ispresent: p_user: *omit);
          if ispresent = 1;
             i6_user = i_user;
          else;
             i6_user = '*ALLUSR';
          endif;
       else;
          i6_user = '*ALLUSR';
       endif;
       //  ... user
       if %parms >= p_lib;
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
       if *in01 = *off;
          isfound     = btrue;
          o_secchgl   = ex_chglib;
          o_secchgf   = ex_chgfile;
          o_secchgm   = ex_chgmbr;
          o_secupdmd  = ex_updmod;
          o_secupdky  = ex_updkey;
          o_secchgsqlw= ex_chgsqlw;
          o_secchgsqlo= ex_chgsqlo;
          o_secaccat  = ex_accaut;
       else;
          isfound     = bfalse;
          o_secchgl   = bnotdef;
          o_secchgf   = bnotdef;
          o_secchgm   = bnotdef;
          o_secupdmd  = bnotdef;
          o_secupdky  = bnotdef;
          o_secchgsqlw= bnotdef;
          o_secchgsqlo= bnotdef;
          o_secaccat  = bnotdef;
       endif;

       return isfound;

       end-proc;

       //===============================================================*
       //    Funktion:                                                  *
       //    f_mrgAut     Verknüpfen Benutzer-/Objektrechte             *
       //===============================================================*

       dcl-proc f_mrgaut;
       dcl-pi *n like(bool_t);
         usraut          const  like(bool_t);
         objaut          const  like(bool_t);
         secaut          const  like(bool_t);
         dftaut          const  like(bool_t);
       end-pi;

       //  Funktionswert
       dcl-s aut             like(bool_t);

       //  Arbeitsfelder
       dcl-s tmpaut          like(bool_t);
       //---------------------------------------------------------------*

       //  Wenn die Benutzerberechtigung definiert worden ist, ...
       if usraut <> bnotdef;
          //  ... dann
          //      benutzen Benutzerberechtigung   (Priorität 1, 2)
          tmpaut = usraut;
       else;
          //  ... sonst
          //      Wenn die Objektberechtigung definiert worden ist, dann ...
          if objaut <> bnotdef;
             //      ... dann
             //          benutzen Objektberechtigung (Priorität 3, 4)
             tmpaut = objaut;
          else;
             //      ... sonst
             //          Wenn die *SECATR Werte definiert worden sind, dann ...
             if secaut <> bnotdef;
                //          ... dann
                //              benutzen *SECATR Werte (Priorität 5-8)
                tmpaut = secaut;
             else;
                //          ... sonst
                //              erteilen Standardberechtigung (Priorität 9)
                //              (kommt aus Befehl PEEK oder aus der
                //              Benutzerdatei, Schlüssel *SECATRDFT)
                tmpaut = dftaut;
             endif;
          endif;
       endif;

       aut = tmpaut;

       return aut;

       end-proc;

       //===============================================================*
       //    Prozedur:                                                  *
       //    p_openFile    Öffnen Datei                                 *
       //===============================================================*

       dcl-proc p_openfile;
       dcl-pi *n;
       end-pi;

       if (not %open(exit01pf));
          open exit01pf;
       endif;

       end-proc;

