       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.5.0                               *
       //  Programm : PEEK68                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 11.08.2008  Thomas Raddatz                        *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Matchcode Subfile-Auswahl                         *
       //                                                               *
       //===============================================================*
       // >>PRE-COMPILER<<                                              *
       //   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
       //                           OBJLIB(&LI) DEVLIB(&LI) +           *
       //                           SBMJOB(*NO) BNDDIR(PEEK) +          *
       //                           INSTALL(*NO);                       *
       //   >>EXECUTE<<                                                 *
       // >>END-PRE-COMPILER<<                                          *
       //===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

       dcl-f peek68fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn) sfile(pbsfl:sflrec);

       dcl-ds workstn likeds(workstn_t);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK68
      /undefine internal_prototype

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8209

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK27

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-s yfkeys          char(18) dim(32);
       dcl-s ynbrofkeys      like(int4_t);
       dcl-s ymsgid          char(7);
       dcl-s ymsgdta         char(512);

       dcl-s ypgmcmd         char(10);
       dcl-s ycmddta         like(pgmcmddt_t);

       dcl-s ychoice         char(75) dim(32);
       dcl-s ynbrofch        like(int4_t);

       dcl-s issflerror      char(1) inz(bFalse);

       dcl-s sftop           like(int4_t);
       dcl-s sflpage         like(int4_t);
       dcl-s sflpagedds      like(sflpage);
       dcl-s sflrec          like(sflpage);
       dcl-s sflnbrrcd       like(sflpage);
       dcl-s sfbot           like(int4_t);
       dcl-c nbrfkeys const(2);
       dcl-s sfl_cmd         char(10);

       dcl-s peek21_name     like(pgmcalln_t);
       dcl-s peek23_name     like(pgmcalln_t);
       dcl-s peek27_name     like(pgmcalln_t);

       dcl-s iseof           like(bool_t) inz(bFalse);
       dcl-s key             like(key_t);
       dcl-s data            like(set0000_t);

       dcl-s wrk_msgid       like(msgid_t);
       dcl-s wrk_msgtxt      like(msgdta_t);

       dcl-ds usrkey qualified inz;
         section         like(section_t);
         key             like(key_t);
       end-ds;

       dcl-ds sflline qualified inz;
         opt             char(2);
         text            char(28) pos(6);
       end-ds;

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek68;
         i_dsp80         const like(dsp80_t);
         i_pgm           const like(pgm_t);
         i_copyright     const like(copyrght_t);
         o_sflopt              like(sfpau_t);
         o_msgid               like(msgid_t);
         o_msgdta              like(msgdta_t);
       end-pi;

       dcl-s do_x2 packed(7);
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       //---------------------------------------------------*
       //  Schleife für Programmbearbeitung

       dow ('1');

          //  Prüfen Positionierung der Subfile
          if (sfsanr <= *zeros);
             sfsanr = 1;
          endif;

          //  Modus: DROP/FOLD
          *in86 = sflmde;

          //  Nachrichten anzeigen
          *in89 = '0';
          write msgctl;

          //  "Keine Sätze ..."
          if (*in80 = *off);
             write pbleer;
          endif;

          //  Anzeigen der Einzelauswahlen
          if sftop > 32
             or sftop > ynbrofch;
             sftop = 1;
          endif;
          $$choice = ychoice(sftop);

          //  Trennlinie
          write pbbot#0;
          //  Anzeigen der Befehlstasten
          select;
          when (sfbot = 2) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#2;
          when (sfbot = 3) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#3;
          when (sfbot = 4) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#4;
          when (sfbot = 5) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#5;
          when (sfbot = 6) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#6;
          when (sfbot = 7) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#7;
          when (sfbot = 8) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#8;
          when (sfbot = 9) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#9;
          when (sfbot = 10) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#10;
          when (sfbot = 11) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#11;
          when (sfbot = 12) and
             (ynbrofkeys > nbrfkeys * (sfbot - 1));
             write pbbot#12;
          other;
             write pbbot#1;
             sfbot = 1;
          endsl;

          //  Anzeige der Subfile
          exfmt pbctl;
          *in70 = '0';

          //  Nachrichten löschen
          p_rmvpgmmg(sds.pgmname);

          //  Aktuelle Satz-Nr.
          if (sflcsr > *zeros);
             sfsanr = sflcsr;
          endif;

          //  Mappen der gedrückten Taste
          //  in Programmbefehl
          peek21(workstn.aid: sds.pgmname
                : ypgmcmd: ycmddta: ymsgid: ymsgdta);
          if (ymsgid <> *blanks);
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             iter;
          endif;

          //  Abfragen der Befehlstasten
          select;
          when (ypgmcmd = '*EXIT');
             exsr c_endpgm;
             leave;
          when (ypgmcmd = '*REFRESH');
             exsr c_refresh;
             iter;
          when (ypgmcmd = '*CANCEL');
             exsr c_endpgm;
             leave;
          when (ypgmcmd = '*TOP');
             exsr c_top;
             iter;
          when (ypgmcmd = '*BOT');
             exsr c_bot;
             iter;
          when (ypgmcmd = '*MOREOPT');
             exsr c_moreopt;
          when (ypgmcmd = '*MOREKEYS');
             exsr c_morekeys;
          when (ypgmcmd = '*ENTER');
             exsr c_enter;
             if (o_sflopt = *blanks);
                //  ... keine Auswahl getroffen, weiter machen
             else;
                leave;
             endif;
          when (ypgmcmd = '*PAGEUP');
          when (ypgmcmd = '*PAGEDOWN');

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: sds.pgmname);
             iter;
          endsl;

       enddo;

       //  Ende der Hauptschleife
       //---------------------------------------------------*

       //  Programm verlassen
     C     ende          tag

       close peek68fm;

       return;

       //============================================================*
       //    C_Enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          exsr vreadc;

       endsr;

       //============================================================*
       //    VReadC        Verarbeiten der Subfileauswahlen          *
       //============================================================*

       begsr vreadc;

          issflerror = bFalse;

          if (*in80 = *off);
             //   keine Einträge in Subfile vorhanden ...
          else;

             for do_x2 = 1 to sflnbrrcd;
                readc pbsfl;
                *in11 = %eof;
                if (*in11 = *on);
                   leave;
                endif;

                chain sflrec pbsfl;
                *in11 = not %found;

                //  Cursorpositionierung ...
                if (issflerror = bFalse);
                   sflcsr = sflrec;
                else;
                   //  Subfile nicht neu positionieren
                endif;

                //  Linksbündig setzen ...
                sfpau = %triml(sfpau);

                //  Zuordnung AUSWAHL => Befehl ...
                peek21('#' + sfpau: sds.pgmname
                      : ypgmcmd: ycmddta: ymsgid: ymsgdta);
                if (ymsgid <> *blanks);
                   //  Fehlermeldung ...
                   p_sndpgmmg('USR8110': sfpau: sds.pgmname);
                   exsr vsfpauerr;
                   update pbsfl;
                   issflerror = bTrue;
                   iter;
                endif;

                //----------------------------*
                //  Ausführen SFL-Befehl ...  *
                //----------------------------*
                sfl_cmd = ypgmcmd;

                select;
                when (sfl_cmd = '*NONE');
                when (sfl_cmd = '*SELECT');
                   exsr vpos;
                   leave;
                other;
                   //  Unbekannter Programmbefehl
                   clear usr8110;
                   usr8110.var1 = ypgmcmd;
                   p_sndpgmmg('USR8110': usr8110: sds.pgmname);
                   exsr vsfpauerr;
                   update pbsfl;
                   issflerror = bTrue;
                   iter;
                endsl;

                update pbsfl;
             endfor;

          endif;

       endsr;

       //============================================================*
       //    C_EndPgm      F3/F12 - Programm beenden                 *
       //============================================================*

       begsr c_endpgm;

          p_rmvpgmmg(sds.pgmname);

          o_msgid = 'USR8100';
          usr8100.var1 = ypgmcmd;
          o_msgdta = usr8100;

       endsr;

       //============================================================*
       //    C_Refresh     F5  - Aktualisieren der Subfile           *
       //============================================================*

       begsr c_refresh;

          // - Subfile neu aufbauen
          exsr pbinit;
          //   Einlesen Subfileauswahlen
          exsr pbinitkey;
          exsr pbsetll;
          exsr pbreadup;
          //   Einlesen Kurzbefehle
          if (i_pgm = 'PEEK05');
             exsr pbseperator;
             exsr pbinitkeycmd;
             exsr pbsetll;
             exsr pbreadup;
          endif;

       endsr;

       //============================================================*
       //    C_Top         F17 - Anfang der Subfile                  *
       //============================================================*

       begsr c_top;

          sfsanr = 1;

       endsr;

       //============================================================*
       //    C_Bot         F18 - Ende der Subfile                    *
       //============================================================*

       begsr c_bot;

          sfsanr = sflnbrrcd;

       endsr;

       //============================================================*
       //    C_MoreOpt     F23 - Weitere Auswahlen                   *
       //============================================================*

       begsr c_moreopt;

          sftop = sftop + 1;

       endsr;

       //============================================================*
       //    C_MoreKeys    F24 - Weitere Tasten                      *
       //============================================================*

       begsr c_morekeys;

          sfbot = sfbot + 1;

       endsr;

       //============================================================*
       //    VPos          Verarbeiten der Eingaben                  *
       //============================================================*

       begsr vpos;

          sflline = $$line;
          o_sflopt = sflline.opt;

       endsr;

       //============================================================*
       //    VSfpauClr     Löschen Subfileauswahl                    *
       //============================================================*

       begsr vsfpauclr;

          sfpau = *blanks;
          *in85 = '0'; // DSPATR(RI)
          *in84 = '0'; // SFLNXTCHG

       endsr;

       //============================================================*
       //    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
       //============================================================*

       begsr vsfpauerr;

          *in85 = '1'; // DSPATR(RI)
          exsr vsfpauchg;

       endsr;

       //============================================================*
       //    VSfpauChg     Datensatz in Subfile als geändert         *
       //                  markieren                                 *
       //============================================================*

       begsr vsfpauchg;

          *in84 = '1'; // SFLNXTCHG

       endsr;

       //============================================================*
       //    PBInitKey     Initialisieren der Schlüsselfelder        *
       //                  zum Füllen der Subfile                    *
       //============================================================*

       begsr pbinitkey;

          usrkey.section = '*' + i_pgm;
          usrkey.key     = '';

       endsr;

       //============================================================*
       //    PBInitKeyCmd  Initialisieren der Schlüsselfelder        *
       //                  zum Füllen der Subfile (Kurzbefehle)      *
       //============================================================*

       begsr pbinitkeycmd;

          usrkey.section = '*CMD';
          usrkey.key     = '';

       endsr;

       //============================================================*
       //    PBInit        Initialisieren der Subfile zur Anzeige    *
       //                  der nächsten Seite                        *
       //============================================================*

       begsr pbinit;

          *in89 = '0';
          write msgctl;

          *in80 = '0'; // SFLDSP
          *in81 = '1'; // SFLDSPCTL
          *in82 = '1'; // SFLCLR
          *in83 = '1'; // SFLEND
          write pbctl;

          *in82 = '0'; // SFLCLR

          sflrec = *zeros;
          sflnbrrcd = *zeros;

       endsr;

       //============================================================*
       //    PBReadUP      Vorwärts füllen der Subfile               *
       //============================================================*

       begsr pbreadup;

          dow ('1');
             iseof = f_readeusr(usrkey.section: key: data);
             if (iseof = bTrue);
                leave;
             endif;

             if (key = '' or %subst(key: 1: 1) = '*');
                iter;
             endif;

             exsr pbfill;

             sflrec = sflrec + 1;
             write pbsfl;
             sflnbrrcd = sflrec;

             if (sflrec >= sflpage);
                leave;
             endif;

          enddo;

       endsr;

       //============================================================*
       //    PBSeperator   Einfügen Trennlinie für Kurzbefehle       *
       //============================================================*

       begsr pbseperator;

          if (sflrec >= sflpage);
             leavesr;
          endif;

          clear sflline;
          sflline = f_msgtext('TXT0141': '');
          $$line = sflline;

          //  ... anzeigen Subfile
          *in80 = '1'; // SFLDSP

          //  ... Löschen Subfileauswahl
          exsr vsfpauclr;

          //  ... Sperren Eingabefeld
          *in90 = '1'; // SFPAU(PR)

          sflrec = sflnbrrcd + 1;
          write pbsfl;
          sflnbrrcd = sflrec;

       endsr;

       //============================================================*
       //    PBFill        Füllen Subfilesatz                        *
       //============================================================*

       begsr pbfill;

          wrk_msgid = f_mapcmdtomsg(data);
          if (wrk_msgid <> '');
             wrk_msgid  = 'KEY' + wrk_msgid;
             wrk_msgtxt = f_msgtext(wrk_msgid: ' ');
          endif;

          clear sflline;
          sflline.opt  = key;
          sflline.text = wrk_msgtxt;
          $$line = sflline;

          //  ... anzeigen Subfile
          *in80 = '1'; // SFLDSP

          //  ... Freigeben Eingabefeld
          *in90 = '0'; // SFPAU(PR)

          //  ... Löschen Subfileauswahl
          exsr vsfpauclr;

       endsr;

       //============================================================*
       //    PBSetLL       Setzen Dateizeiger                        *
       //============================================================*

       begsr pbsetll;

          p_setllusr(usrkey.section: usrkey.key);

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if (i_dsp80 = '0');
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 5;
             pos = 35;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 3;
             pos = 23;
          endif;

          sflpage = *hival;
          sflpagedds = 6;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peek68fm;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          // - Rückkehrcode
          o_sflopt = *blanks;
          o_msgid = *blanks;
          o_msgdta = *blanks;

          // - Darstellung der Subfile
          sflmde = '1';

          // - Darstellung der Befehlstasten
          sftop = 1;
          sfbot = 1;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

          // - Anzuzeigender Subfilesatz
          sfsanr = 1;

          // - Subfile füllen
          exsr c_refresh;

          // - Copyright
          p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isInzSr = bTrue);
             leavesr;
          endif;

          isInzSr = bTrue;

          PGMQ = '*';

          peek21_name = f_pgmcalln('PEEK21');
          peek23_name = f_pgmcalln('PEEK23');
          peek27_name = f_pgmcalln('PEEK27');

          peek23(sds.pgmname: '*ALL': 0
                : yfkeys: ynbrofkeys);
          scrnfkeys = %subarr(yfkeys: 1);

          peek27(sds.pgmname: ychoice: ynbrofch);

       endsr;

       //============================================================*
       //  Program error handler                                     *
       //============================================================*

       dcl-proc errorhandler;
       dcl-pi *n;
         i_condtoken     value likeds(cee_fc_t);
         i_pcommarea     int(10) value;
         o_action        int(10);
         o_newcondtoken  likeds(cee_fc_t);
       end-pi;

       dump;
       o_action = cee_percolate;

       end-proc;

