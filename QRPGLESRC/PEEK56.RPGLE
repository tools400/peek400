       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.1.0                               *
       //  Programm : PEEK56                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 05.04.1999  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Auswählen "Arbeitsumgebung"                       *
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

       dcl-f peek56fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn) sfile(pbsfl:sflrec);

       dcl-f peekenv keyed usropn extfile(g_envfile) extmbr(g_envmbr)
             prefix(en_);

       dcl-ds workstn likeds(workstn_t);

       dcl-s g_envfile       char(21);
       dcl-s g_envmbr        char(10);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,MBRL0200
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,SET0015

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8180
      /COPY QCOPYLE,USR8181
      /COPY QCOPYLE,USR8182
      /COPY QCOPYLE,USR8184
      /COPY QCOPYLE,USR8209
      /COPY QCOPYLE,USR8233

      /define internal_prototype
      /COPY QCOPYLE,PPEEK56
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK27
      /COPY QCOPYLE,PPEEK46

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

       dcl-s yfkeys          char(18) dim(32)       inz(*blanks);
       dcl-s ynbrofkeys      like(int4_t) inz;
       dcl-s yexclkeys       like(pgmcmd_t) dim(25);
       dcl-s ymsgid          char(7) inz(*blanks);
       dcl-s ymsgdta         char(512) inz(*blanks);

       //  Peek46:
       dcl-ds yqfile;
         yfile           char(10) inz;
         ylib            char(10) inz;
       end-ds;
       dcl-s numMbr          like(int4_t) inz;

       dcl-s ypgmcmd         char(10) inz(*blanks);
       dcl-s ycmddta         like(pgmcmddt_t) inz(*blanks);

       dcl-s ychoice         char(75) dim(32);
       dcl-s ynbrofch        like(int4_t) inz;

       dcl-s isNewPos        char(1) inz(bFalse);
       dcl-s isfound         char(1) inz(bFalse);
       dcl-s isSflError      char(1) inz(bFalse);
       dcl-s isCtlError      char(1) inz(bFalse);
       dcl-s isDirty         char(1) inz(bFalse);

       dcl-s sftop           like(int4_t) inz;
       dcl-s sflpage         like(int4_t) inz;
       dcl-s sflpagedds      like(sflpage   ) inz;
       dcl-s sflrec          like(sflpage   ) inz;
       dcl-s sflnbrrcd       like(sflpage   ) inz;
       dcl-s sfbot           like(int4_t) inz;
       dcl-s sfl_cmd         char(10) inz(*blanks);
       dcl-s ctl_cmd         char(10) inz(*blanks);
       dcl-c nbrfkeys const(3);

       dcl-s peek21_name     like(pgmcalln_t) inz;
       dcl-s peek23_name     like(pgmcalln_t) inz;
       dcl-s peek27_name     like(pgmcalln_t) inz;
       dcl-s peek46_name     like(pgmcalln_t) inz;

       dcl-s r_mbr           inz(*blanks) like(##mbr  );
       dcl-s lstmbr          inz(*blanks) like(##mbr  );
       dcl-s lstnbrrcd       inz(0) like(sflpage);

       dcl-s wrk_sfsanr      inz(*zeros ) like(sfsanr );

       dcl-s lastfile        like(##file    ) inz;
       dcl-s lastlib         like(##lib     ) inz;
       dcl-s isprdlib        like(bool_t) inz(bFalse);

       dcl-s rcdfmtid        like(fmtid_t);
       dcl-ds mbrl0200 likeds(mbrl0200_t) inz;

       dcl-pr f_isvldopt        like(bool_t);
         i_option        like(sfpau);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pr;

       dcl-pr f_loadrcdfmtid
              like(fmtid_t);
       end-pr;

       dcl-ds set0015 likeds(set0015_t) inz;

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek56;
         i_dsp80         const like(dsp80_t);
         i_copyright     const like(copyrght_t);
         i_mode          const like(mode_t);
         i_envfile       const like(file_t);
         i_envlib        const like(lib_t);
         i_envmbr        const like(mbr_t);
         i_rcdfmtid      const like(fmtid_t);
         o_qfile         likeds(qobj_t);
         o_mbr           like(mbr_t);
         o_text          like(text_t);
         o_option        like(option_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-s do_x2           packed(7);
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       dow ('1');

          //  Prüfen Positionierung der Subfile
          if (sfsanr <= 0);
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
          if (sftop > 32 or sftop > ynbrofch);
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
          other;
             write pbbot#1;
             sfbot = 1;
          endsl;

          //  Anzeige der Subfile
          exfmt pbctl;
          *in70 = '0';

          //  Nachrichten löschen
          p_rmvpgmmg(sds.pgmname);

          //  Bezugszahlen löschen
          exsr clrindctl;

          //  Aktuelle Satz-Nr.
          if (sflcsr > 0);
             sfsanr = sflcsr;
          endif;

          //  Mappen der gedrückten Taste
          //  in Programmbefehl
          peek21(workstn.aid: sds.pgmname
                : ypgmcmd: ycmddta: ymsgid: ymsgdta);
          if (ymsgid <> '');
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
             if isCtlError = bFalse;
                exsr setusrsetg;
             endif;
             if o_mbr = *blanks
                or isCtlError = bTrue
                or isSflError = bTrue;
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

       if (workstn.isOpen = '1');
          close peek56fm;
       endif;

       return;

       //============================================================*
       //    C_Enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          isCtlError = bFalse;
          isDirty = bFalse;

          //  Prüfen der Eingaben im Kontrollsatz
          exsr vctl;

          //  Wenn alles OK ist und die Subfile weiterhin gültig ist, ...
          if (isCtlError = bFalse and isDirty = bFalse);
             // ... dann
             //     Wenn der Teildateiname gefüllt ist, ...
             if (##mnme <> '');
                // ... dann
                //     füllen der Rückgabeparameter
                o_qfile.name = ##file;
                o_qfile.lib = ##lib;
                o_mbr    = ##mnme;
                o_text   = ##mtxt;
                o_option = ctl_cmd;
             else;
                // ... sonst
                //     prüfen der Subfile
                exsr vreadc;

             endif;
          endif;

          // Wenn die Subfile ungültig ist, ...
          if (isDirty = bTrue);
             // ... dann
             //     aktualisieren der Subfile
             exsr c_refresh;
          else;
             // ... sonst
             //     Wenn die Teildatei ausgefüllt ist, ...
             if (##mbr <> '');
                // ... dann
                //     ausführen Suchfunktion
                exsr c_search;
             else;
                // ... sonst
                //     prüfen der Dateiangaben
                exsr chkfile;
             endif;
          endif;

       endsr;

       //============================================================*
       //    C_Search      F16 - Suchen                              *
       //============================================================*

       begsr c_search;

          if (##mbr <> '');
             lstmbr = ##mbr;
             ##mbr = *blanks;
          endif;

          if (lstmbr = '');
             *in70 = '1';
             clear usr8209;
             p_sndpgmmg('USR8209': usr8209: sds.pgmname);
          else;
             exsr postombr;
             if (isNewPos = bTrue);
                sfsanr = wrk_sfsanr;
             endif;
          endif;

       endsr;

       //============================================================*
       //    PosToMbr      Subfile neu positionieren                 *
       //============================================================*

       begsr postombr;

          if (lstmbr <> r_mbr);
             lstnbrrcd = 0;
          endif;

          if (lstmbr = '');
             isNewPos = bFalse;
             lstnbrrcd = 0;
          else;

             exsr srchmbr;
             if (isfound = bFalse);
                isNewPos = bFalse;
                clear usr8180;
                usr8180.var1 = lstmbr;
                p_sndpgmmg('USR8180': usr8180: sds.pgmname);
             else;
                isNewPos = bTrue;
             endif;
          endif;

          r_mbr = lstmbr;

       endsr;

       //============================================================*
       //    SrchMbr       Suchen Member in Subfile                  *
       //============================================================*

       begsr srchmbr;

          if (*in80 = *off);
             isfound = bFalse;
          else;

             isfound = bFalse;
             lstnbrrcd = lstnbrrcd + 1;

             for sflrec = lstnbrrcd to sflnbrrcd;
                chain(e) sflrec pbsfl;
                if (%error() or not %found());
                   isfound = bFalse;
                   leave;
                endif;

                if (lstmbr = %subst($$mnme: 1:(f_scan(' ': lstmbr) - 1)));
                   isfound = bTrue;
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

             if (isfound = bTrue);
                wrk_sfsanr = sflrec;
                lstnbrrcd = sflrec;
             else;
                wrk_sfsanr = 0;
                lstnbrrcd = 0;
             endif;

          endif;

       endsr;

       //============================================================*
       //    SrchInit      Initialisieren Suchfunktion               *
       //============================================================*

       begsr srchinit;

          lstmbr = '';
          lstnbrrcd = 0;
          r_mbr = lstmbr;

       endsr;

       //============================================================*
       //    VCtl          Verarbeiten der Eingaben Kontrollsatz     *
       //============================================================*

       begsr vctl;

          // - Funktion nicht freigeschaltet
          if (##file = '' or ##lib  = '' or set0015.set_envena = bFalse);
             clear usr8184;
             p_sndpgmmg('USR8184': usr8184: sds.pgmname);
             isCtlError = bTrue;
             exsr poscsr;
             leavesr;
          endif;

          //  ##Lib
          exsr prf41;
          if (isCtlError = bTrue);
             leavesr;
          endif;

          //  ##File
          exsr prf40;
          if (isCtlError = bTrue);
             leavesr;
          endif;

          if (isDirty = bFalse);
             //  ##CTLAU
             exsr prf20;
             if isCtlError = bTrue;
                leavesr;
             endif;

             if (##ctlau <> '' or ##mnme  <> '' or ##mtxt  <> '');
                //  ##MNME
                exsr prf21;
                if (isCtlError = bTrue);
                   leavesr;
                endif;

                //  ##MTXT
                exsr prf22;
                if (isCtlError = bTrue);
                   leavesr;
                endif;

             endif;
          endif;

       endsr;

       //============================================================*
       //    Prf40         Prüfen ##File                             *
       //============================================================*

       begsr prf40;

          dou ('1');

             //  gültiger Name ?
             if (f_vldname(##file: ymsgid: ymsgdta) = bTrue);
                isCtlError = bFalse;
             else;
                isCtlError = bTrue;
                if (ymsgid <> '');
                   p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                   ymsgid = '';
                   ymsgdta = '';
                endif;
                leave;
             endif;

             //  Prüfen Datei
             //  ------------
             f_execute('CHKOBJ'      +
                      ' OBJ('       +
                      %trim(##lib)  +
                      '/'           +
                      %trim(##file) +
                      ')'           +
                      ' OBJTYPE('   +
                      '*FILE'       +
                      ')'           +
                      ' MBR('       +
                       '*NONE'      +
                      ')'           +
                      ' AUT('       +
                      '*NONE'       +
                      ')'           :
                      ymsgid        :
                      ymsgdta       );

             if (ymsgid <> '');
                isCtlError = bTrue;
                p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                ymsgid = '';
                ymsgdta = '';
                leave;
             else;
                isCtlError = bFalse;
             endif;

             //  Datei geändert ?
             if (##file <> lastfile);
                isDirty = bTrue;
                leave;
             endif;


          enddo;

          if (isCtlError = bTrue);
             *in40 = *on;
             *in50 = *on;
          endif;

       endsr;

       //============================================================*
       //    Prf41         Prüfen ##Lib                              *
       //============================================================*

       begsr prf41;

          dou ('1');

             //  gültiger Name ?
             if (f_vldname(##lib: ymsgid: ymsgdta) = bTrue);
                isCtlError = bFalse;
             else;
                isCtlError = bTrue;
                if (ymsgid <> '');
                   p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                   ymsgid = '';
                   ymsgdta = '';
                endif;
                leave;
             endif;

             //  Prüfen Bibliothek
             //  -----------------
             f_execute('CHKOBJ'      +
                      ' OBJ('       +
                      %trim(##lib)  +
                      ')'           +
                      ' OBJTYPE('   +
                      '*LIB'        +
                      ')'           +
                      ' MBR('       +
                       '*NONE'      +
                      ')'           +
                      ' AUT('       +
                      '*NONE'       +
                      ')'           :
                      ymsgid        :
                      ymsgdta       );

             if (ymsgid <> '');
                isCtlError = bTrue;
                p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                ymsgid = '';
                ymsgdta = '';
                leave;
             else;
                isCtlError = bFalse;
             endif;

             //  Bibliothek geändert ?
             if (##lib <> lastlib);
                isDirty = bTrue;
                leave;
             endif;

          enddo;

          if (isCtlError = bTrue);
             *in41 = *on;
             *in51 = *on;
          endif;

       endsr;

       //============================================================*
       //    Prf20         Prüfen ##CTLAU                            *
       //============================================================*

       begsr prf20;

          dou ('1');

             //  Zuordnung AUSWAHL => Befehl ...
             isCtlError =
              f_isvldopt(##ctlau: ymsgid: ymsgdta);
             if (isCtlError = bTrue);
                ctl_cmd = ' ';
                if (ymsgid <> '');
                   p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                   ymsgid = '';
                   ymsgdta = '';
                endif;
                leave;
             endif;

             ctl_cmd = ypgmcmd;

             if ((##mnme  <> '' or ##mtxt  <> '') and ##ctlau = ' ');
                clear usr8110;
                usr8110.var1   = ##ctlau;
                p_sndpgmmg('USR8110': usr8110: sds.pgmname);
                isCtlError = bTrue;
                leave;
             endif;

          enddo;

          if (isCtlError = bTrue);
             *in20 = *on;
             *in30 = *on;
          endif;

       endsr;

       //============================================================*
       //    Prf21         Prüfen ##MNME                             *
       //============================================================*

       begsr prf21;

          //  gültiger Name ?
          if (f_vldname(##mnme: ymsgid: ymsgdta) = bTrue);
             isCtlError = bFalse;
          else;
             isCtlError = bTrue;
             if (ymsgid <> '');
                p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                ymsgid = '';
                ymsgdta = '';
             endif;
          endif;


          if (ymsgid = 'CPD0078');
             p_sndpgmmg('CPD0078': ymsgdta: sds.pgmname);
             isCtlError = bTrue;
          endif;

          if (isCtlError = bTrue);
             *in21 = *on;
             *in31 = *on;
          endif;

       endsr;

       //============================================================*
       //    Prf22         Prüfen ##MTXT                             *
       //============================================================*

       begsr prf22;

          if (isCtlError = bTrue);
             *in22 = *on;
             *in32 = *on;
          endif;

       endsr;

       //============================================================*
       //    ChkFile       Prüfen/Anlegen Env.Datei                  *
       //============================================================*

       begsr chkfile;

          if (o_qfile.name = '' and o_qfile.lib  = '' and o_mbr  = '');
             exsr clrfilep;
             leavesr;
          endif;

          //  Prüfen Datei
          //  ------------
          f_execute('CHKOBJ'           +
                   ' OBJ('            +
                   %trim(o_qfile.lib ) +
                   '/'                +
                   %trim(o_qfile.name) +
                   ')'                +
                   ' OBJTYPE('        +
                   '*FILE'            +
                   ')'                +
                   ' MBR('            +
                    '*NONE'           +
                   ')'                +
                   ' AUT('            +
                   '*NONE'            +
                   ')'                :
                   ymsgid             :
                   ymsgdta            );

          //  Wenn die Datei nicht gefunden werden konnte, ...
          if (ymsgid = 'CPF9801');
             //  ... dann
             //      anlegen Datei
             f_execute('CRTDUPOBJ'        +
                      ' OBJ('            +
                       'PEEKENV'         +
                      ')'                +
                      ' FROMLIB('        +
                      %trim(sds.pgmlib) +
                      ')'                +
                      ' OBJTYPE('        +
                      '*FILE'            +
                      ')'                +
                      ' TOLIB('          +
                      %trim(o_qfile.lib ) +
                      ')'                +
                      ' NEWOBJ('         +
                      %trim(o_qfile.name) +
                      ')'                :
                      ymsgid             :
                      ymsgdta            );

             if (ymsgid = '');
                f_execute('RMVM'             +
                         ' FILE('           +
                         %trim(o_qfile.lib ) +
                         '/'                +
                         %trim(o_qfile.name) +
                         ')'                +
                         ' MBR('            +
                          '*ALL'            +
                         ')'                :
                         ymsgid             :
                         ymsgdta            );

                ymsgid  = '';
                ymsgdta = '';
             endif;
          endif;

          if (ymsgid <> '');
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             exsr clrfilep;
             leavesr;
          endif;

          //  Prüfen Teildatei
          //  ----------------
          f_execute('CHKOBJ'           +
                   ' OBJ('            +
                   %trim(o_qfile.lib ) +
                   '/'                +
                   %trim(o_qfile.name) +
                   ')'                +
                   ' OBJTYPE('        +
                   '*FILE'            +
                   ')'                +
                   ' MBR('            +
                   %trim(o_mbr  )      +
                   ')'                +
                   ' AUT('            +
                   '*NONE'            +
                   ')'                :
                   ymsgid             :
                   ymsgdta            );

          //  Wenn die Teildatei nicht gefunden werden konnte, ...
          if (ymsgid = 'CPF9815');
             //  ... dann
             //      anlegen Teildatei
             f_execute('ADDPFM'           +
                      ' FILE('           +
                      %trim(o_qfile.lib ) +
                      '/'                +
                      %trim(o_qfile.name) +
                      ')'                +
                      ' MBR('            +
                      %trim(o_mbr )       +
                      ')'                :
                      ymsgid             :
                      ymsgdta            );
          endif;

          if (ymsgid <> '');
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             exsr clrfilep;
             leavesr;
          endif;

          //  Ändern Teildateitext
          //  --------------------
          if (o_text <> '');
             f_execute('CHGPFM'           +
                      ' FILE('           +
                      %trim(o_qfile.lib ) +
                      '/'                +
                      %trim(o_qfile.name) +
                      ')'                +
                      ' MBR('            +
                      %trim(o_mbr )       +
                      ')'                +
                      ' TEXT('''         +
                      %trim(o_text)       +
                      ''')'              :
                      ymsgid             :
                      ymsgdta            );

             if (ymsgid <> '');
                p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                ymsgid = '';
                ymsgdta = '';
                exsr clrfilep;
                leavesr;
             endif;
          endif;

       endsr;

       //============================================================*
       //    VReadC        Verarbeiten der Subfileauswahlen          *
       //============================================================*

       begsr vreadc;

          isSflError = bFalse;

          if (*in80 = *off);
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
                if isSflError = bFalse;
                   sflcsr = sflrec;
                else;
                   //  Subfile nicht neu positionieren
                endif;

                //  Linksbündig setzen ...
                sfpau = %triml(sfpau);

                //  Zuordnung AUSWAHL => Befehl ...
                isSflError = f_isvldopt(sfpau  :
                                       ymsgid :
                                       ymsgdta);
                if (isSflError = bTrue);
                   p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                   ymsgid = '';
                   ymsgdta = '';
                   exsr vsfpauerr;
                   update pbsfl;
                   iter;
                endif;

                //----------------------------*
                //  Ausführen SFL-Befehl ...  *
                //----------------------------*
                sfl_cmd = ypgmcmd;

                select;
                when sfl_cmd = '*NONE';
                when sfl_cmd = '*SLCENV';
                   exsr vpos;
                when sfl_cmd = '*SLCLAYOUT';
                   exsr vpos;
                other;
                   //  Unbekannter Programmbefehl
                   clear usr8110;
                   usr8110.var1 = ypgmcmd;
                   p_sndpgmmg('USR8110': usr8110: sds.pgmname);
                   exsr vsfpauerr;
                   update pbsfl;
                   isSflError = bTrue;
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

          // - Kontrollsatz füllen
          exsr ctfill;

          // - Subfile neu aufbauen
          exsr pbinitkey;
          exsr pbinit;
          exsr pbsetll;
          exsr pbreadup;

          exsr srchinit;

          exsr poscsr;

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

          if (i_mode = '*LOAD' and sfl_cmd = '*SLCLAYOUT');
             rcdfmtid = f_loadrcdfmtid();
             if (rcdfmtid <> '' and i_rcdfmtid <> rcdfmtid);
                isSflError = bTrue;
                clear usr8233;
                p_sndpgmmg('USR8233': usr8233: sds.pgmname);
                leavesr;
             endif;
          endif;

          o_qfile.name = ##file;
          o_qfile.lib = ##lib;
          o_mbr = $$mnme;
          o_text = $$mtxt;
          o_option = sfl_cmd;

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
       //    clrIndCtl     Löschen Bezugszahlen Kontrollsatz         *
       //============================================================*

       begsr clrindctl;

          *in20 = '0'; // ##CTLAU.PC
          *in30 = '0'; // ##CTLAU.RI

          *in21 = '0'; // ##MNME.PC
          *in31 = '0'; // ##MNME.RI

          *in22 = '0'; // ##MTXT.PC
          *in32 = '0'; // ##MTXT.RI

          *in40 = '0'; // ##FILE.PC
          *in50 = '0'; // ##FILE.RI

          *in41 = '0'; // ##LIB.PC
          *in51 = '0'; // ##LIB.RI

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

          if (##file <> ' ' and ##lib  <> ' ');

             lastfile = ##file;
             lastlib  = ##lib;

             yfile = ##file;
             ylib = ##lib;
             peek46(yqfile: '*ALL':  '*CREATE'
                   : numMbr: mbrl0200);

             set0015.set_envfil = ##file;
             set0015.set_envlib = ##lib;

          else;
             clear usr8181;
             p_sndpgmmg('USR8181': usr8181: sds.pgmname);
          endif;

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

          dow (numMbr > 0);
             peek46(yqfile: '*ALL':  '*READ'
                   : numMbr: mbrl0200);

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

          //  ... Membername
          $$mnme = mbrl0200.m2mnme;
          //  ... Memberbezeichnung
          $$mtxt = mbrl0200.m2mtxt;

          //  ... anzeigen Subfile
          *in80 = '1'; // SFLDSP

          //  ... Löschen Subfileauswahl
          exsr vsfpauclr;

       endsr;

       //============================================================*
       //    PBSetLL       Setzen Dateizeiger                        *
       //============================================================*

       begsr pbsetll;

       endsr;

       //============================================================*
       //    CTFill        Füllen Kontrollsatz                       *
       //============================================================*

       begsr ctfill;

          ##ctlau = '';
          ##mnme  = '';
          ##mtxt  = '';

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if (i_dsp80 = '0');
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 2;
             pos = 26;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 2;
             pos = 5;
          endif;

          sflpage = 9999;
          sflpagedds = 6;

       endsr;

       //============================================================*
       //    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
       //============================================================*

       begsr getusrsetg;

          //  *ENVFILE
          set0015 = f_getusrsg('*ENVFILE'  );

       endsr;

       //============================================================*
       //    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
       //============================================================*

       begsr setusrsetg;

          //  *ENVFILE
          if (isprdlib = bTrue);
             set0015.set_envlib = '*PRDLIB';
          endif;
          p_updusrsg('*ENVFILE': set0015);

       endsr;

       //============================================================*
       //    clrFileP      Löschen Dateiangaben (Rückkehrwerte)      *
       //============================================================*

       begsr clrfilep;

          o_qfile.name = '';
          o_qfile.lib = '';
          o_mbr = '';
          o_text = '';
          o_option = '';

       endsr;

       //============================================================*
       //    posCrs        Positionieren Cursor                      *
       //============================================================*

       begsr poscsr;

          if (*in72 = '0'); // Eingeblendet
             *in20 = *on;
          else;
             *in20 = *off;
          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Einlesen Subfileauswahlen
          select;
          when i_mode = '*SAVE';
             yexclkeys(1) = '*SLCLAYOUT';
          when i_mode = '*DELETE';
             yexclkeys(1) = '*SLCLAYOUT';
          other;
             //           keine Ausschlüsse
             yexclkeys(*) = '';
          endsl;

          peek27(sds.pgmname: ychoice: ynbrofch);

          // - Öffnen Bildschirmdatei
          if (workstn.isOpen = '0');
             open peek56fm;
          endif;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          exsr getusrsetg;

          select;
          when i_envfile = '*NONE';
             ##file = ' ';
          other;
             ##file = i_envfile;
          endsl;

          select;
          when i_envlib = '*NONE';
             ##lib = '';
             isprdlib = bFalse;
          when i_envlib = '*PRDLIB';
             ##lib = sds.pgmlib;
             isprdlib = bTrue;
          other;
             ##lib = i_envlib;
             isprdlib = bFalse;
          endsl;

          if (set0015.set_envchg =  bFalse or set0015.set_envena =  bFalse );
             *in71 = *on;
          else;
             *in71 = *off;
          endif;

          if (i_mode = '*SAVE');
             *in72 = '0'; // Einblenden
          else;
             *in72 = '1'; // Ausblenden
          endif;

          // - Rückkehrcode
          o_msgid = *blanks;
          o_msgdta = *blanks;
          exsr clrfilep;

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
          peek46_name = f_pgmcalln('PEEK46');

          peek23(sds.pgmname: '*ALL': nbrfkeys
                : yfkeys: ynbrofkeys);
          scrnfkeys = %subarr(yfkeys: 1);

       endsr;

       //===================================================================*
       //  Prozedur:  f_isVldOpt                                 (Body)     *
       //===================================================================*

       dcl-proc f_isvldopt;
       dcl-pi *N        like(bool_t);
         i_option        like(sfpau     );
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //  Funktionswert ...
       dcl-s iserror         like(bool_t) inz(bfalse);
       //---------------------------------------------------*

       peek21('#' + i_option: sds.pgmname
             : ypgmcmd: ycmddta: ymsgid: ymsgdta);
       if (ymsgid <> ' ');
          //  Fehlermeldung ...
          clear usr8110;
          usr8110.var1 = i_option;
          o_msgid  = 'USR8110';
          o_msgdta = usr8110;
          iserror  = btrue;
       else;
          o_msgid  = ' ';
          o_msgdta = ' ';
          iserror  = bfalse;
       endif;

       return iserror;

       end-proc;

       //===================================================================*
       //  Prozedur:  f_loadRcdFmtID                             (Body)     *
       //===================================================================*
       dcl-proc f_loadrcdfmtid;
       dcl-pi *N like(fmtid_t);
       end-pi;

       //  definieren Arbeitsfelder ...
       dcl-s rcdfmtid        like(fmtid_t);

       dcl-ds en_key2 likerec(fpeekenv: *key);
       //---------------------------------------------------*

       g_envfile = %trim(i_envlib) + '/' +
                  %trim(i_envfile);
       g_envmbr = $$mnme;
       open(e) peekenv;
       if (%error());
          return '';
       endif;

       clear en_key2;
       en_key2.en_user = '*ALL';
       en_key2.en_section = '*RCDFMTID';
       chain %kds(en_key2: 2) fpeekenv;
       if (not %found(peekenv));
          return '';
       endif;

       rcdfmtid = en_data;

       close peekenv;

       return rcdfmtid;
       end-proc;

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

