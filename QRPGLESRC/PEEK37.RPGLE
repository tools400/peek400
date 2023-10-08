       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.5.0                               *
       //  Programm : PEEK37                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 12.02.1998  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Feldauswahl                                       *
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

       dcl-f peek37fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn) sfile(pbsfl:sflrec);
       dcl-f peekfld usage(*update:*delete) keyed usropn prefix(f_);

       dcl-ds workstn likeds(workstn_t);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8209

      /define internal_prototype
      /COPY QCOPYLE,PPEEK37
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK27

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s yfkeys          char(18) dim(32) inz;
       dcl-s ynbrofkeys      like(int4_t) inz;
       dcl-s ymsgid          char(7) inz(*blanks);
       dcl-s ymsgdta         char(512) inz(*blanks);

       dcl-s ypgmcmd         char(10) inz(*blanks);
       dcl-s ycmddta         like(pgmcmddt_t) inz(*blanks);

       dcl-s ychoice         char(75) dim(32);
       dcl-s ynbrofch        like(int4_t) inz;

       dcl-s isnewpos        char(1) inz(bfalse);
       dcl-s isfound         char(1) inz(bfalse);
       dcl-s issflerror      char(1) inz(bfalse);

       dcl-s sftop           like(int4_t) inz;
       dcl-s sflpage         like(int4_t) inz;
       dcl-s sflpagedds      like(sflpage) inz;
       dcl-s sflrec          like(sflpage) inz;
       dcl-s sflnbrrcd       like(sflpage) inz;
       dcl-s sfbot           like(int4_t) inz;
       dcl-c nbrfkeys const(2);
       dcl-s sfl_cmd         char(10) inz(*blanks);

       dcl-s peek21_name     like(pgmcalln_t) inz;
       dcl-s peek23_name     like(pgmcalln_t) inz;
       dcl-s peek27_name     like(pgmcalln_t) inz;

       dcl-s r_field         inz(*blanks) like(##field);
       dcl-s lstfield        inz(*blanks) like(##field);
       dcl-s lstnbrrcd       inz(0) like(sflpage);

       dcl-s wrk_sfsanr      inz(*zeros ) like(sfsanr );

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek37;
         i_dsp80         const like(dsp80_t);
         i_copyright     const like(copyrght_t);
         o_feld          like(fieldnme_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-s do_x2           packed(7);

       dcl-ds f_key likerec(fpeekfld: *key);
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       dow ('1');

          //  Prüfen Positionierung der Subfile
          if sfsanr <= *zeros;
             sfsanr = 1;
          endif;

          //  Modus: DROP/FOLD
          *in86 = sflmde;

          //  Nachrichten anzeigen
          *in89 = '0';
          write msgctl;

          //  "Keine Sätze ..."
          if *in80 = *off;
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
          if sflcsr > *zeros;
             sfsanr = sflcsr;
          endif;

          //  Mappen der gedrückten Taste
          //  in Programmbefehl
          peek21(workstn.aid: sds.pgmname
                : ypgmcmd: ycmddta: ymsgid: ymsgdta);
          if ymsgid <> *blanks;
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             iter;
          endif;

          //  Abfragen der Befehlstasten
          select;
             //  F3  - Ende
          when ypgmcmd = '*EXIT';
             exsr c_endpgm;
             leave;

             //  F5  - Aktualisieren
          when ypgmcmd = '*REFRESH';
             exsr c_refresh;
             iter;

             //  F12 - Ende
          when ypgmcmd = '*CANCEL';
             exsr c_endpgm;
             leave;

             //  F16 - Suchen
          when ypgmcmd = '*SEARCH';
             exsr c_search;
             iter;

             //   F17 - Anfang Datensatz
          when ypgmcmd = '*TOP';
             exsr c_top;
             iter;
             //   F18 - Ende Datensatz
          when ypgmcmd = '*BOT';
             exsr c_bot;
             iter;

             //  F23 - Weitere Auswahlen
          when ypgmcmd = '*MOREOPT';
             exsr c_moreopt;

             //  F24 - Weitere Tasten
          when ypgmcmd = '*MOREKEYS';
             exsr c_morekeys;

             //  Datenfreigabe
          when ypgmcmd = '*ENTER';
             exsr c_enter;
             if o_feld = *blanks;
                //  ... keine Auswahl getroffen, weiter machen
             else;
                leave;
             endif;
             //  Page up
          when ypgmcmd = '*PAGEUP';
             //  Page down
          when ypgmcmd = '*PAGEDOWN';

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: sds.pgmname);
             iter;
          endsl;

       enddo;

       //  Ende der Hauptschleife
       //---------------------------------------------------*

       //  Programm verlassen
     C**   ende          tag

       close peek37fm;
       close peekfld;

       return;

       //============================================================*
       //    C_Enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          exsr vreadc;

          if ##field <> *blanks;
             exsr c_search;
          endif;

       endsr;

       //============================================================*
       //    C_Search      F16 - Suchen                              *
       //============================================================*

       begsr c_search;

          if ##field <> *blanks;
             lstfield = ##field;
             ##field = *blanks;
          endif;

          if lstfield = *blanks;
             *in70 = '1';
             clear usr8209;
             p_sndpgmmg('USR8209': usr8209: sds.pgmname);
          else;
             exsr postofield;
             if isnewpos = btrue;
                sfsanr = wrk_sfsanr;
             endif;
          endif;

       endsr;

       //============================================================*
       //    PosToField    Subfile neu positionieren                 *
       //============================================================*

       begsr postofield;

          if lstfield <> r_field;
             lstnbrrcd = 0;
          endif;

          if lstfield = *blanks;
             isnewpos = bfalse;
             lstnbrrcd = 0;
          else;

             exsr srchfield;
             if isfound = bfalse;
                isnewpos = bfalse;
                clear usr8136;
                usr8136.var1 = lstfield;
                p_sndpgmmg('USR8136': usr8136: sds.pgmname);
             else;
                isnewpos = btrue;
             endif;
          endif;

          r_field = lstfield;

       endsr;

       //============================================================*
       //    SrchField     Suchen Feld in Subfile                    *
       //============================================================*

       begsr srchfield;

          if *in80 = *off;
             isfound = bfalse;
          else;

             isfound = bfalse;
             lstnbrrcd = lstnbrrcd + 1;

             for sflrec = lstnbrrcd to sflnbrrcd;
                chain(e) sflrec pbsfl;
                *in11 = %error or not %found;
                if *in11 = *on;
                   isfound = bfalse;
                   leave;
                endif;

                if lstfield =
                   %subst($$fnme: 1:(f_scan(' ':
                                         lstfield) - 1));
                   isfound = btrue;
                   leave;
                else;
                   if sfpau <> *blanks;
                      //  ... Satz geändert
                      exsr vsfpauchg;
                   else;
                      //  ... Satz nicht geändert
                      exsr vsfpauclr;
                   endif;
                   update pbsfl;
                   iter;
                endif;

             endfor;

             if isfound = btrue;
                wrk_sfsanr = sflrec;
                lstnbrrcd = sflrec;
             else;
                wrk_sfsanr = *zeros;
                lstnbrrcd = 0;
             endif;

          endif;

       endsr;

       //============================================================*
       //    SrchInit      Initialisieren Suchfunktion               *
       //============================================================*

       begsr srchinit;

          lstfield  = ' ';
          lstnbrrcd = 0;
          r_field   = lstfield;

       endsr;

       //============================================================*
       //    VReadC        Verarbeiten der Subfileauswahlen          *
       //============================================================*

       begsr vreadc;

          issflerror = bfalse;

          if *in80 = *off;
             //   keine Einträge in Subfile vorhanden ...
          else;

             for do_x2 = 1 to sflnbrrcd;
                readc pbsfl;
                *in11 = %eof;
                if *in11 = *on;
                   leave;
                endif;

                chain sflrec pbsfl;
                *in11 = not %found;

                //  Cursorpositionierung ...
                if issflerror = bfalse;
                   sflcsr = sflrec;
                else;
                   //  Subfile nicht neu positionieren
                endif;

                //  Linksbündig setzen ...
                sfpau = %triml(sfpau);

                //  Zuordnung AUSWAHL => Befehl ...
                peek21('#' + sfpau: sds.pgmname
                      : ypgmcmd: ycmddta: ymsgid: ymsgdta);
                if ymsgid <> *blanks;
                   //  Fehlermeldung ...
                   p_sndpgmmg('USR8110': sfpau: sds.pgmname);
                   exsr vsfpauerr;
                   update pbsfl;
                   issflerror = btrue;
                   iter;
                endif;

                //----------------------------*
                //  Ausführen SFL-Befehl ...  *
                //----------------------------*
                sfl_cmd = ypgmcmd;

                select;
                when sfl_cmd = '*NONE';
                when sfl_cmd = '*SELECT';
                   exsr vpos;
                   leave;
                other;
                   //  Unbekannter Programmbefehl
                   clear usr8110;
                   usr8110.var1 = ypgmcmd;
                   p_sndpgmmg('USR8110': usr8110: sds.pgmname);
                   exsr vsfpauerr;
                   update pbsfl;
                   issflerror = btrue;
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
          exsr pbinitkey;
          exsr pbinit;
          exsr pbsetll;
          exsr pbreadup;

          exsr srchinit;

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

          o_feld = $$fnme;

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

          f_field = *blanks;

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

          sflrec = 0;
          sflnbrrcd = 0;

       endsr;

       //============================================================*
       //    PBReadUP      Vorwärts füllen der Subfile               *
       //============================================================*

       begsr pbreadup;

          dow ('1');
             read(n) fpeekfld;
             if (%eof(peekfld));
                *in83 = bTrue;
                leave;
             endif;

             exsr pbfill;

             sflrec = sflrec + 1;
             write pbsfl;
             sflnbrrcd = sflrec;

             if sflrec >= sflpage;
                leave;
             endif;

          enddo;

       endsr;

       //============================================================*
       //    PBFill        Füllen Subfilesatz                        *
       //============================================================*

       begsr pbfill;

          fldl0100 = f_ffd;
          //  ... Feldname
          $$fnme = fldl0100.f1fnme;
          //  ... Feldbezeichnung
          $$ftxt = fldl0100.f1ftxt;

          //  ... anzeigen Subfile
          *in80 = '1'; // SFLDSP

          //  ... Löschen Subfileauswahl
          exsr vsfpauclr;

       endsr;

       //============================================================*
       //    PBSetLL       Setzen Dateizeiger                        *
       //============================================================*

       begsr pbsetll;

          setll %kds(f_key) fpeekfld;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = '0';
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
          open peek37fm;
          open peekfld;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          ##field = *blanks;

          // - Rückkehrcode
          o_feld = *blanks;
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

          if (isInzSr = btrue);
             leavesr;
          endif;

          isInzSr = btrue;

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
       dcl-pi *N;
         i_condtoken     value likeds(cee_fc_t);
         i_pcommarea     int(10) value;
         o_action        int(10);
         o_newcondtoken  likeds(cee_fc_t);
       end-pi;

       dump;
       o_action = cee_percolate;

       end-proc;

