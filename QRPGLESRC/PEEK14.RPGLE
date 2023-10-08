       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.2.0                               *
       //  Programm : PEEK14                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 08.10.97  Raddatz                                 *
       //  geändert : 21.07.99  Raddatz für Version 2.2                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Anzeigen Datensatz                                           *
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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

       dcl-f peek14fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn) sfile(pbsfl:sflrec);
       dcl-f peekfldl0 keyed usropn rename(fpeekfld:fpeekfldl0)
             infds(peek#00) prefix(f_);
       dcl-f peekfld keyed usropn infds(peek#  ) prefix(f_);

       dcl-ds workstn likeds(workstn_t);
       dcl-ds cursorPosition likeds(cursorPosition_t) inz;

       dcl-ds peek#00 likeds(infds_t);
       dcl-ds peek# likeds(infds_t);

       dcl-ds hfile04  likeds(hfile_t);

       dcl-ds cursorPos qualified;
         row    int(10) inz;
         column int(10) inz;
       end-ds;

       dcl-ds io_buff;
         io_bufffld like(rcdbuf_t);
       end-ds;

       dcl-s io_nullmap like(nullmap_t) dim(null_map_size);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK14
      /undefine internal_prototype

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8206
      /COPY QCOPYLE,USR8220
      /COPY QCOPYLE,USR8221
      /COPY QCOPYLE,USR8222

      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK32
      /COPY QCOPYLE,PPEEK45
      /COPY QCOPYLE,PPEEK64
      /COPY QCOPYLE,PPEEK65

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s yfkeys          char(18) dim(32);
       dcl-s ynbrofkeys      like(int4_t);
       dcl-s ymsgid          char(7);
       dcl-s ymsgdta         char(512);

       dcl-s ypgmcmd         char(10);
       dcl-s ycmddta         like(pgmcmddt_t);

       dcl-s ystring         like(rcdbuf_t);
       dcl-s ystrlen         like(int4_t);

       dcl-s ydsp80          char(1) inz(*blanks);
       dcl-s yheadertyp      char(10) inz(*blanks);
       dcl-s ycopyright      char(512) inz(*blanks);
       dcl-s yfldname        like(fieldnme_t) inz;
       dcl-s yfldinhalt      like(rcdbuf_t) inz(*blanks);
       dcl-s ylength         like(int4_t) inz;
       dcl-s yprotect        like(bool_t) inz(btrue);
       dcl-s yisucs2         like(int4_t) inz;

       dcl-s sflpage         like(int4_t) inz;
       dcl-s sflpagedds      like(sflpage   ) inz;
       dcl-s sflrec          like(sflpage   ) inz;
       dcl-s sfllastrcd      like(sflpage   ) inz;
       dcl-c §nbrfkeys const(3);

       dcl-s sfbot           like(int4_t) inz;

       dcl-s isrecord        like(bool_t) inz(bfalse);
       dcl-s iscvtchar       like(bool_t) inz(bfalse);

       dcl-s peek06_name     like(pgmcalln_t) inz;
       dcl-s peek21_name     like(pgmcalln_t) inz;
       dcl-s peek23_name     like(pgmcalln_t) inz;
       dcl-s peek32_name     like(pgmcalln_t) inz;
       dcl-s peek45_name     like(pgmcalln_t) inz;
       dcl-s peek64_name     like(pgmcalln_t) inz;
       dcl-s peek65_name     like(pgmcalln_t) inz;

       dcl-s dotline         char(40) inz(*all'.');

       dcl-s x               like(int4_t) inz;

       dcl-s totlin          like(int4_t) inz;
       dcl-s rowcnt          like(int4_t) inz;

       dcl-s editor          char(10) inz;

       dcl-s isinzsr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek14;
         i_dsp80         const like(dsp80_t);
         io_headertype   like(headertype_t);
         i_copyright     const like(copyrght_t);
         i_rcdnbr        const like(rcdnbr_t);
         i_file          const like(file_t);
         i_lib           const like(lib_t);
         i_mbr           const like(mbr_t);
         i_rcdfmt        const like(fmt_t);
         i_function      const like(function_t);
         i_commitlvl     const like(bool_t);
         io_screennbr    like(int4_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-s do_x3           packed(7);

       dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
       dcl-ds f1key    likerec(fpeekfld: *key);

       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       dow ('1');

          //  Prüfen Positionierung der Subfile
          if (sfsanr <= 0)  or
             (sfsanr > sfllastrcd);
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

          //  Anzeigen der Befehlstasten
          select;
          when (sfbot = 2) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#2;
          when (sfbot = 3) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#3;
          when (sfbot = 4) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#4;
          when (sfbot = 5) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#5;
          when (sfbot = 6) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#6;
          other;
             write pbbot#1;
             sfbot = 1;
          endsl;

          //  Anzeige der Subfile
          exfmt pbctl;

          // - Berechnen Zeile/Spalte
          cursorposition.row = workstn.csrpos / 256;
          cursorposition.column = %rem(workstn.csrpos: 256);

          // - Löschen der Cursorposition
          csrRow = *zeros;
          csrCol = *zeros;

          //  Seitennummer  berechnen
          io_screennbr = sflcsr / sflpagedds;
          if (sflcsr = (sflpagedds * io_screennbr));
             // keine Korrektur erforderlich
          else;
             io_screennbr = io_screennbr + 1;
          endif;

          //  Nachrichten löschen
          p_rmvpgmmg(sds.pgmname);

          //  Aktuelle Satz-Nr.
          sfsanr = sflcsr;

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
             exsr readrcd;
             exsr c_refresh;
             iter;

             //  F7  - Überschrift
          when ypgmcmd = '*HEADLINE';
             exsr c_chghead;
             iter;

             //  F9  - Hexeditor
          when ypgmcmd = '*HEXEDIT';
             exsr c_fldhexed;
             exsr keepcsrpos;
             iter;

             //  F10 - Feldeditor
          when ypgmcmd = '*STREDIT';
             exsr c_fldstred;
             exsr keepcsrpos;
             iter;

             //  F12 - Ende
          when ypgmcmd = '*CANCEL';
             exsr c_endpgm;
             leave;

             //   F17 - Anfang Datensatz
          when ypgmcmd = '*TOP';
             exsr c_top;
             iter;
             //   F18 - Ende Datensatz
          when ypgmcmd = '*BOT';
             exsr c_bot;
             iter;

             //   F21 - Drucken Datensatz
          when ypgmcmd = '*PRINT';
             exsr c_print;
             iter;

             //  F22 - Alle Datensätze verarbeiten
          when ypgmcmd = '*YESTOALL';                                           // ZURÜCK
             exsr c_allrcds;
             leave;

             //  F24 - Weitere Tasten
          when ypgmcmd = '*MOREKEYS';
             exsr c_morekeys;

             //  Datenfreigabe
          when ypgmcmd = '*ENTER';
             exsr c_enter;
             leave;
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

       close peek14fm;
       close peekfld;
       close peekfldl0;
       cio_close(hfile04);

       return;

       //============================================================*
       //    C_Enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          o_msgid = 'USR8112';
          o_msgdta = *blanks;

       endsr;

       //============================================================*
       //    C_FldHexEd    F9 - Hexeditor                            *
       //============================================================*

       begsr c_fldhexed;

          //  Error: No valid subfile record.
          if sflcsr = *zeros;
             p_sndpgmmg('USR8204': '': sds.pgmname);
             leavesr;
          endif;

          chain sflcsr pbsfl;
          *in01 = not %found;
          if *in01 = *on;
             //  Error: Unable to find record.
             p_sndpgmmg('USR8120': '': sds.pgmname);
             leavesr;
          endif;

          clear f1key;
          f1key.f_field = r$fnme;
          chain %kds(f1key) fpeekfld;
          *in11 = not %found;
          if *in11 = *on;
             //  Error: Unable to find record.
             p_sndpgmmg('USR8120': '': sds.pgmname);
             leavesr;
          endif;

          fldl0100 = f_ffd;

          //  Error: Editor not allowed. Field &1 is NULL.
          if fldl0100.f1nalw = '1' and
             io_nullmap(fldl0100.f1seq) = 1;
             clear usr8220;
             usr8220.var1 = fldl0100.f1fnme;
             p_sndpgmmg('USR8220': usr8220: sds.pgmname);
             leavesr;
          endif;

          ydsp80 = i_dsp80;
          yheadertyp = io_headertype;
          ycopyright = i_copyright;
          yfldname = r$fnme;
          yprotect = btrue;
          ymsgid = *blanks;
          ymsgdta = *blanks;

          editor = '*HEX';
          exsr frombuffer;

       endsr;

       //============================================================*
       //    C_FldStrEd    F10 - String-Editor                       *
       //============================================================*

       begsr c_fldstred;

          //  Error: No valid subfile record.
          if sflcsr = *zeros;
             p_sndpgmmg('USR8204': '': sds.pgmname);
             leavesr;
          endif;

          chain sflcsr pbsfl;
          *in01 = not %found;
          if *in01 = *on;
             //  Error: Unable to find record.
             p_sndpgmmg('USR8120': '': sds.pgmname);
             leavesr;
          endif;

          clear f1key;
          f1key.f_field = r$fnme;
          chain %kds(f1key) fpeekfld;
          *in11 = not %found;
          if *in11 = *on;
             //  Error: Unable to find record.
             p_sndpgmmg('USR8120': '': sds.pgmname);
             leavesr;
          endif;

          fldl0100 = f_ffd;

          //  Error: Editor does not support data type of field &1.
          if fldl0100.f1dtyp <> 'A' and
             fldl0100.f1dtyp <> 'G';
             clear usr8221;
             usr8221.var1 = fldl0100.f1fnme;
             p_sndpgmmg('USR8221': usr8221: sds.pgmname);
             leavesr;
          endif;

          //  Error: Field &1 exceeds maximum length allowed for editor.
          //*                 IF        f_buffLn(FLDL0100) > 1024
          //*                 CLEAR                   USR8222
          //*                 Eval      USR8222.var1 = FLDL0100.F1FNME
          //*                 CALLP     p_sndPgmMg('USR8222': USR8222: sds.pgmName)
          //*                 LEAVESR
          //*                 ENDIF

          //  Error: Editor not allowed. Field &1 is NULL.
          if fldl0100.f1nalw = '1' and
             io_nullmap(fldl0100.f1seq) = 1;
             clear usr8220;
             usr8220.var1 = fldl0100.f1fnme;
             p_sndpgmmg('USR8220': usr8220: sds.pgmname);
             leavesr;
          endif;

          ydsp80 = i_dsp80;
          yheadertyp = io_headertype;
          ycopyright = i_copyright;
          yfldname = r$fnme;
          yprotect = btrue;
          ymsgid = *blanks;
          ymsgdta = *blanks;

          editor = '*STRING';
          exsr frombuffer;

       endsr;

       //====================================================*
       //  FromBuffer - Übertragen Rohdaten aus IO-Puffer    *
       //====================================================*

       begsr frombuffer;

          if f_buffln(fldl0100) > rcd_buff_len;
             clear usr8206;
             usr8206.var1 = rcd_buff_len;
             p_sndpgmmg('USR8206': usr8206: sds.pgmname);
          else;
             f_rtvfld(yfldinhalt: io_buff:
                     fldl0100: bfalse);

             ylength = f_curfldln(io_buff: fldl0100);

             if (fldl0100.f1ucs2 = '1');
                yisucs2 = fldl0100.f1fdcc;
             else;
                yisucs2 = 0;
             endif;

             if editor = '*HEX';
                peek45(i_dsp80: io_headertype: i_copyright
                      : r$fnme: yfldinhalt: ylength
                      : btrue: yisucs2
                      : ymsgid: ymsgdta);
             else;
                peek64(i_dsp80: io_headertype: i_copyright
                      : r$fnme: yfldinhalt: ylength
                      : btrue: yisucs2
                      : ymsgid: ymsgdta);
             endif;
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

          clear f1key_l0;
          f1key_l0.f_fldseq = 0;

          exsr pbinit;
          exsr pbsetll;
          exsr pbreadup;

       endsr;

       //============================================================*
       //    C_ChgHead     F7  - Umschalten der Überschrift          *
       //============================================================*

       begsr c_chghead;

          io_headertype =
           f_nextheadertype(io_headertype);

          exsr c_refresh;

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

          sfsanr = sfllastrcd;

       endsr;

       //============================================================*
       //    C_Print       F21 - Drucken Datensatz                   *
       //============================================================*

       begsr c_print;

          monitor;
             peek65(i_rcdnbr
                   : i_file: i_lib: i_mbr: i_rcdfmt
                   : ymsgid: ymsgdta);
             *in99 = bfalse;
          on-error;
             *in99 = btrue;
          endmon;

          if ymsgid <> '';
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid  = '';
             ymsgdta = '';
          endif;

       endsr;

       //============================================================*
       //    C_AllRcds     F22 - Alle Datensätze verarbeiten         *
       //============================================================*

       begsr c_allrcds;

          o_msgid = 'USR8111';
          o_msgdta = *blanks;

       endsr;

       //============================================================*
       //    C_MoreKeys    F24 - Weitere Tasten                      *
       //============================================================*

       begsr c_morekeys;

          sfbot = sfbot + 1;

       endsr;

       //============================================================*
       //    PBInit        Initialisieren der Subfile zur Anzeige    *
       //                  der nächsten Seite                        *
       //============================================================*

       begsr pbinit;

          *in89 = '0';
          write msgctl;

          *in80 = '0';                                                          // SFLDSP
          *in81 = '1';                                                          // SFLDSPCTL
          *in82 = '1';                                                          // SFLCLR
          *in83 = '1';                                                          // SFLEND
          write pbctl;

          *in82 = '0';                                                          // SFLCLR

          sflrec = *zeros;

          sfllastrcd = *zeros;

          //  Konvertieren nicht darstellbarer Zeichen
          iscvtchar = bfalse;

       endsr;

       //============================================================*
       //    PBReadUP      Vorwärts füllen der Subfile               *
       //============================================================*

       begsr pbreadup;

          rowcnt  = 4;
          sfsanr  = 0;

          dow ('1');
             read fpeekfldl0;
             if (%eof());
                *in83 = *on;
                leave;
             endif;

             //  Feldattribute
             fldl0100 = f_ffd;

             //  nicht erlaubte Feldtypen
             if f_isnotalw(fldl0100) = btrue;
                iter;
             endif;

             //  Berechnen Anzahl Zeilen
             totlin = f_nbrdsprw(fldl0100);

             exsr syncline;

             //  Ausgeben Feld
             x = 1;
             exsr pbfill;
             *in60 = '0'; // DSPATR(ND)

             dow x <= ystrlen
                and x <= 512;

                sflrec = sflrec + 1;
                if sflrec > 9999;
                   *in83 = '1';
                   leave;
                endif;

                //*                 SUBST (P) YString:X     $$DATA
                $$data = %subst(ystring: x);
                exsr wrtpbsfl;
                x = x + 35;
             enddo;

             rowcnt = rowcnt + totlin;

             if sflrec >= sflpage;
                leave;
             endif;

          enddo;

       endsr;

       //============================================================*
       //    wrtPbSfl      Schreiben Subfilesatz                     *
       //============================================================*

       begsr wrtpbsfl;

          write pbsfl;
          sfllastrcd = sflrec;
          *in60 = '1';                                                          // DSPATR(ND)

          if sflrec = io_screennbr * sflpagedds +
                        1 - sflpagedds;
             sfsanr = sflrec;
          endif;

       endsr;

       //============================================================*
       //    synCline      Synchronisieren wie Änderungsbildschirm   *
       //============================================================*

       begsr syncline;

          if (rowcnt + totlin - 1) > 18;

             for do_x3 = rowcnt to 18;
                clear pbsfl;
                sflrec = sflrec + 1;
                if sflrec > 9999;
                   *in83 = '1';
                   leave;
                endif;

                exsr wrtpbsfl;
             endfor;

             rowcnt = 4;
          endif;

       endsr;

       //============================================================*
       //    PBFill        Füllen Subfilesatz                        *
       //============================================================*

       begsr pbfill;

          //      ... Feldname
          r$fnme = fldl0100.f1fnme;

          //      ... überschreiben EDTCDE
          if f_edtcde <> *blanks;
             fldl0100.f1edtc = f_edtcde;
          else;
             //       Original EDITCODE verwenden
          endif;

          //      ... eintragen Überschrift
          $$text =
           %trimr(f_headline(
             io_headertype: fldl0100)) + ' ' + dotline;

          //      ... Markieren Schlüsselfelder
          if (f_kseq <> 0);
             %subst($$text: %len($$text) - 1: 2) = ' >';
          else;
             %subst($$text: %len($$text) - 1: 2) = ' :';
          endif;

          //  ... NULL erlaubt?
          if fldl0100.f1nalw = '1' and
             io_nullmap(fldl0100.f1seq) = 1;
             ystring = f_msgtext('TXT0127': '');
             ystrlen = %len(%trimr(ystring));
          else;

             monitor;
                //  ... aufbereiten des Feldinhaltes
                peek06(fldl0100: 'FLDL0100': io_buff
                      : bfalse: btrue
                      : ystring: ystrlen: ymsgid: ymsgdta);

                //  ... Konvertieren nicht darstellbarer Zeichen
                peek32(ystring: ystrlen: 0
                      : ymsgid: ymsgdta);
                *in99 = bfalse;
             on-error;
                *in99 = btrue;
             endmon;

             if *in99 = *off;
                if iscvtchar = bfalse;
                   if ymsgid <> *blanks;
                      iscvtchar = btrue;
                      p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
                   else;
                      //         keine Nachricht anstehend
                   endif;
                else;
                   //         Nachricht bereits gesendet
                endif;
             else;
                //         Fehler bei Programmaufruf
             endif;

             //  Ende: F1NALW
             ymsgid  = '';
             ymsgdta = '';
          endif;

          //  ... anzeigen Subfile
          *in80 = '1'; // SFLDSP

       endsr;

       //============================================================*
       //    PBSetLL       Setzen Dateizeiger                        *
       //============================================================*

       begsr pbsetll;

          setll %kds(f1key_l0) fpeekfldl0;

       endsr;

       //============================================================*
       //    KeepCsrPos    Beibehalten der Cursorposition            *
       //============================================================*

       begsr keepcsrpos;

          //  Beibehalten der Cursorosition
          csrRow = cursorPos.row;
          csrCol = cursorPos.column;

          csrCol = csrCol - pos;
          csrCol = csrCol - 1;
          csrRow = csrRow - zei;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = '0';
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 1;
             pos = 40;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 1;
             pos = 7;
          endif;

          sflpage = *hival;
          sflpagedds = 15;

          %subarr(*in: 70: 10) = '0';

          select;
          when i_function = '*DELETE';
             *in70 = '1';
          when i_function = '*DISPLAY';
             *in75 = '1';
          when i_function = '*COPYEXT';
             *in79 = '1';
          other;
             //              ????????????
          endsl;

       endsr;

       //============================================================*
       //    ReadRcd       Einlesen des anzuzeigenden Satzes         *
       //============================================================*

       begsr readrcd;

          if cio_chainwithrrn(hfile04
                           : i_rcdnbr
                           : bfalse
                           : io_buff
                           : io_nullmap) = bfalse;
             isrecord = bfalse;
          else;
             isrecord = btrue;
          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peek14fm;
          open peekfld;
          open peekfldl0;
          cio_open(hfile04
                  : i_file
                  : i_lib
                  : i_mbr
                  : i_rcdfmt
                  : 'rr, arrseq=Y, commit=N, +
                     nullcap=Y, riofb=Y, secure=N, +
                     ccsid=65535');
          //**                                      nullcap=Y, riofb=Y, secure=N')
          //**                                   : 'rr,arrseq=Y,nullcap=Y,riofb=Y')

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          o_msgid = *blanks;
          o_msgdta = *blanks;

          // - Kopffelder
          $$rcdn = i_rcdnbr;

          // - Darstellung der Subfile
          sflmde = '1';

          // - Darstellung der Befehlstasten
          sfbot = 1;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

          // - Einlesen des anzuzeigenden Satzes
          exsr readrcd;

          // - Subfile füllen
          clear f1key_l0;
          f1key_l0.f_fldseq = 0;

          exsr pbinit;
          exsr pbsetll;
          exsr pbreadup;

          // - Copyright
          p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isinzsr = btrue);
             leavesr;
          endif;

          isinzsr = btrue;

          §pgmq = '*';

          peek06_name = f_pgmcalln('PEEK06');
          peek21_name = f_pgmcalln('PEEK21');
          peek23_name = f_pgmcalln('PEEK23');
          peek32_name = f_pgmcalln('PEEK32');
          peek45_name = f_pgmcalln('PEEK45');
          peek64_name = f_pgmcalln('PEEK64');
          peek65_name = f_pgmcalln('PEEK65');

          peek23(sds.pgmname: '*ALL': §nbrfkeys
                : yfkeys: ynbrofkeys);
          scrnfkeys = %subarr(yfkeys: 1);

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

