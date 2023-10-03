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
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                          *
       //  EXIT-Programm zur Ermittlung der Datei mit den               *
       //  Benutzereinstellungen (PEEKUSR).                             *
       //                                                               *
       //  Parameterliste:                                              *
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                              *
       //     I/O:  gio_user   - Name Benutzerprofil                    *
       //     I/O:  gio_file   - Name der Settings-Datei                *
       //     I/O:  gio_lib    - Bibliothek mit Settings-Datei          *
       //     Out:  go_msgID   - Nachrichten-ID                         *
       //     Out:  go_msgDta  - Nachrichtendaten                       *
       //                                                               *
       //  Berechnen der Rückgabewerte:                                 *
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                 *
       //  In diesem Beispielprogramm wird der Name der Settings-Datei  *
       //  gleich einem im Benutzerprofil hinterlegten Gruppenprofil    *
       //  gesetzt.                                                     *
       //                                                               *
       //  Natürlich könnte der Name der Settings-Datei auch über eine  *
       //  andere Logik, bspw. einer Mapping-Datei ermittelt werden.    *
       //                                                               *
       //  Erstellen des Programms:                                     *
       //  ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯                                     *
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

      /include QCOPYLE,D_VARDEF

      /define internal_prototype
      /include QCOPYLE,PEXIT02
      /undefine internal_prototype

       //  main procedure
       dcl-pr p_main;
         io_user         like(gio_user  );
         io_file         like(gio_file  );
         io_lib          like(gio_lib   );
         o_msgid         like(go_msgid  );
         o_msgdta        like(go_msgdta );
       end-pr;

       //  retrieve user profile information
       dcl-pr f_rtvusrprfinf  char(256);
         i_user          char(10) const;
         i_format        char(8) const;
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pr;

       //  Programminformationsdatenstruktur                            *
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
       dcl-pi exit02;
         gio_user        like(user_t);
         gio_file        like(file_t);
         gio_lib         like(lib_t);
         go_msgid        like(msgid_t);
         go_msgdta       like(msgdta_t);
       end-pi;

       p_main(gio_user  :
             gio_file  :
             gio_lib   :
             go_msgid  :
             go_msgdta );

       *inlr = *on;

       //===============================================================*
       //    Main Procedure (local fields)                              *
       //===============================================================*

       dcl-proc p_main;
       dcl-pi *n;
         io_user         like(gio_user  );
         io_file         like(gio_file  );
         io_lib          like(gio_lib   );
         o_msgid         like(go_msgid  );
         o_msgdta        like(go_msgdta );
       end-pi;

       //  lokale Arbeitsfelder
       dcl-ds usri0200 len(256);
         ui2_bytret      int(10);
         ui2_bytavl      int(10);
         ui2_usrprf      char(10);
         ui2_usrcls      char(10);
         ui2_spcaut      char(15);
         ui2_grpprf      char(10);
         ui2_owner       char(10);
         ui2_grpaut      char(10);
         ui2_lmtcpb      char(10);
         ui2_grpauttyp   char(10);
         ui2_reserved1   char(3);
         ui2_ofssplgrp   int(10);
         ui2_numsplgrp   int(10);
       end-ds;
       //---------------------------------------------------------------*

       //  Use default settings: Name of settings file = user profile
       if (io_user = '*DFT');
          io_user = sds.user;
       endif;

       if (io_file = '*DFT');
          io_file = sds.user;
          io_lib  = sds.pgmlib;
       endif;

       if (io_lib = '*PRDLIB');
          io_lib  = sds.pgmlib;
       endif;

       //  Remove "Return" statement to override settings file and
       //  user name to group profile.
       return;

       //  Use group profile as name of settings file
       usri0200 = f_rtvusrprfinf(io_user    :
                                'USRI0200' :
                                o_msgid    :
                                o_msgdta   );

       if o_msgid = ' ';
          io_user = ui2_grpprf;
          io_file = ui2_grpprf;
       endif;

       return;

       end-proc;

       //===============================================================*
       //    Funktion:                                                  *
       //    Abrufen Informationen über Benutzerprofil                  *
       //===============================================================*

       dcl-proc f_rtvusrprfinf;
       dcl-pi *n char(256);
         i_user          char(10) const;
         i_format        char(8) const;
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-ds rcvvar len(256) inz;
         rcv_bytret      int(10) inz;
         rcv_bytavl      int(10) inz;
       end-ds;

       dcl-ds errcode;
         err_bytprv      int(10) inz(%size(errcode));
         err_bytavl      int(10) inz;
         err_excid       char(7) inz;
         err_reserved    char(1) inz;
         err_excdata     char(256) inz;
       end-ds;

       //  Retrieve User Information (QSYRUSRI) API
       dcl-pr qsyrusri extpgm('QSYRUSRI');
         o_rcvvar        char(65535) options(*varsize);
         i_rcvvarlen     int(10) const;
         i_format        char(8) const;
         i_usrprf        char(10) const;
         io_errcode      char(65535) options(*varsize);
       end-pr;
       //---------------------------------------------------------------*

       reset errcode;
       qsyrusri(rcvvar: %size(rcvvar): i_format:
               i_user: errcode);

       if err_bytavl <> 0;
          o_msgid  = err_excid;
          o_msgdta = err_excdata;
       else;
          o_msgid  = ' ';
          o_msgdta = ' ';
       endif;

       return %subst(rcvvar: 1: rcv_bytret);

       end-proc;

