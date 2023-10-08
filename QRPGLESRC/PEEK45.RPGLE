       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.1.0                               *
       //  Programm : PEEK45                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 15.08.98  Raddatz                                 *
       //  geändert : 27.04.99  2.1.0                                   *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Hexadezimale Feldeditierung                                  *
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

       dcl-f peek45fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

       dcl-f peekfld keyed usropn prefix(f_) infds(peek_01_ds);

       dcl-ds workstn likeds(workstn_t);

       dcl-ds peek_01_ds likeds(infds_t);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK45
      /undefine internal_prototype

      /COPY QCOPYLE,SET0006

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8136

       dcl-ds fldl0100 likeds(fldl0100_t) inz;
       dcl-ds set0006  likeds(set0006_t) inz;

       //  Peek21
       dcl-s ypgmcmd         like(pgmcmd_t) inz;
       dcl-s ycmddta         like(pgmcmddt_t) inz;
       dcl-s ymsgid          like(msgid_t) inz;
       dcl-s ymsgdta         like(msgdta_t) inz;

       //  Peek23:
       dcl-s yfkeys          like(fkeydsp_t) inz dim(32);
       dcl-s ynbrofkeys      like(int4_t) inz;

       //  Peek32
       dcl-s ybuffer         like(rcdbuf_t) inz;
       dcl-s ybufflen        like(int4_t) inz;

       dcl-s sfbot           like(int4_t) inz;
       dcl-c §nbrfkeys const(3);

       dcl-s x               like(int4_t) inz;
       dcl-s i               like(int4_t) inz;

       dcl-s isstringinp     like(bool_t) inz(bFalse);
       dcl-s isPgmError      like(bool_t) inz(bFalse);
       dcl-s isdatachg       like(bool_t) inz(bFalse);

       dcl-c HEX_DIGITS const('0123456789ABCDEF');

       dcl-s peek21_name     like(pgmcalln_t) inz;
       dcl-s peek23_name     like(pgmcalln_t) inz;
       dcl-s peek32_name     like(pgmcalln_t) inz;


       // Arbeitsfelder
       dcl-s pstartpos       like(#startpos) inz;
       dcl-ds *N;
         pfldinhaltsbcs  like(rcdbuf_t) inz;
         pfldinhaltucs2  like(rcdbufucs2_t) inz
              overlay(pfldinhaltsbcs);
       end-ds;
       dcl-s plength         like(int4_t) inz;
       dcl-s ptmpnewlen      like(int4_t) inz;
       dcl-s ptmphexlen      like(int4_t) inz;
       dcl-s ptmphexbin      like(#hexstring) inz;

       dcl-s warning_1       like(bool_t) inz(bFalse);
       dcl-s warning_2       like(bool_t) inz(bFalse);

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK32

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71

       dcl-s $ofsval         zoned(4) dim( 8)   inz;

       dcl-ds #hexstring;
         #hexval         char(8) dim(32)   inz;
       end-ds;

       dcl-ds $expstring;
         $strval         char(16) dim( 8)   inz;
       end-ds;

       dcl-s idx             int(10) inz;
       dcl-s ofs             int(10) inz;
       dcl-s htranscoder     like(htranscoder_t ) inz;

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek45;
         i_dsp80         const like(dsp80_t);
         i_headtype      const like(headtyp_t);
         i_copyright     const like(copyrght_t);
         i_fldname       const like(fieldnme_t);
         io_fldinhalt    likeds(fldinhalt_t);
         io_length       like(int4_t);
         i_protect       const like(bool_t);
         i_isucs2        const like(int4_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-ds f_key likerec(fpeekfld: *key);
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       //---------------------------------------------------*
       //  Schleife für Programmbearbeitung

       dow ('1');

          //  Nachrichten anzeigen
          *in89 = *off;
          write msgctl;

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
          when (sfbot = 7) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#7;
          when (sfbot = 8) and
             (ynbrofkeys > §nbrfkeys * (sfbot - 1));
             write pbbot#8;
          other;
             write pbbot#1;
             sfbot = 1;
          endsl;

          //  Füllen "Offset" Angaben
          idx = 0;
          ofs = pstartpos - 1;
          for idx = 1 to %elem($ofsval);
             $ofsval(idx) = ofs;
             ofs = ofs + %len($strval(1));
          endfor;

          //  Anzeigen Bildschirm
          exsr toscreen;
          exfmt bild01;
          exsr fromscreen;

          //  Daten geändert
          isdatachg = *in93;

          //  Nachrichten löschen
          p_rmvpgmmg(sds.pgmname);

          //  Bezugszahlen löschen
          exsr bzoff1;

          //  Mappen der gedrückten Taste
          //  in Programmbefehl
          peek21(workstn.aid: sds.pgmname
                : ypgmcmd: ycmddta: ymsgid: ymsgdta);
          if ymsgid <> ' ';
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             iter;
          endif;

          //  Abfragen der Programmbefehle
          select;
             //  F3  - Ende
          when ypgmcmd = '*EXIT';
             exsr c_endpgm;
             leave;

             //  F5  - Aktualisieren
          when ypgmcmd = '*REFRESH';
             exsr c_refresh;
             iter;

             //  F7  - Umschalten der Eingabe
          when ypgmcmd = '*TGLINPUT';
             exsr c_enter;
             exsr c_tginput;
             iter;

             //  F12 - Ende
          when ypgmcmd = '*CANCEL';
             exsr c_endpgm;
             leave;

             //  F17 - an den Afang gehen
          when ypgmcmd = '*FIRSTPOS';
             exsr c_firstpos;

             //  F18 - ans Ende gehen
          when ypgmcmd = '*LASTPOS';
             exsr c_lastpos;

             //  F19 - nach rechts verschieben (ein Feld)
          when ypgmcmd = '*LEFT';
             exsr c_movel;

             //  F20 - nach links verschieben  (ein Feld)
          when ypgmcmd = '*RIGHT';
             exsr c_mover;

             //  F24 - Weitere Tasten
          when ypgmcmd = '*MOREKEYS';
             exsr c_morekeys;

             //  Page up
          when ypgmcmd = '*PAGEUP';
             exsr c_pageup;

             //  Page down
          when ypgmcmd = '*PAGEDOWN';
             exsr c_pagedown;

             //  Datenfreigabe
          when ypgmcmd = '*ENTER';
             exsr c_enter;
             if isPgmError = bFalse;
                o_msgid  = 'USR8112';
                o_msgdta = ' ';

                if (i_isucs2 = 0);
                   io_fldinhalt.sbcs = pfldinhaltsbcs;
                else;
                   io_fldinhalt.ucs2 = pfldinhaltucs2;
                endif;

                io_length = plength;
                leave;
             endif;

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: sds.pgmname);
             iter;
          endsl;

       enddo;

       if %open(peekfld);
          close peekfld;
       endif;

       if %open(peekfld);
          close peekfld;
       endif;

       close peek45fm;

       return;

       //============================================================*
       //    c_enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          if isPgmError = bTrue;

             //    ---------------------------------
             //    *** Genereller Programmfehler ***
             //    ***    keine Verarbeitung     ***
             //    ***          möglich          ***
             //    ---------------------------------

          else;

             //  Prüfen der Eingaben
             exsr prfb1;

             if isPgmError = bFalse;


                if isdatachg = bTrue;

                   if isstringinp = bFalse;
                      //  Einsetzen geänderten Hex-String ...
                      //  ... umwandeln HexString (Bildschirmanzeige) nach HexWert (Pufferinhalt)
                      ptmphexbin = ' ';
                      p_chrtohex(ptmphexbin               :
                                #hexstring               :
                                %len(%trimr(#hexstring)));
                      //      (Länge_Hex_Nibble / 2 = Länge_Hex_Bin)
                      x = %len(%trimr(#hexstring)) / 2;
                   else;
                      ptmphexbin = %subst(pfldinhaltsbcs:pstartpos);
                      for x = 1 to %len($expstring);
                         if %subst($expstring: x: 1) <> set0006.set_cvtc;
                            %subst(ptmphexbin: x: 1) =
                                 %subst($expstring: x: 1);
                         endif;
                      endfor;
                      //      (Länge = Feldlänge)
                      x = %len($expstring);
                   endif;

                   //  ... einsetzen in Zwischenfeld für Rückgabewert
                   %subst(pfldinhaltsbcs: pstartpos: x) =
                     %subst(ptmphexbin: 1: x);

                   if (i_isucs2 = 0);
                      plength = %len(%trimr(pfldinhaltsbcs));
                   else;
                      plength = %len(%trimr(pfldinhaltucs2));
                   endif;

                   //  Füllen #HexString und $ExpString
                   exsr fill##2;

                   //  Merken der neuen Startposition
                   pstartpos = #startpos;

                   isPgmError = bTrue;
                endif;
             endif;

          endif;

       endsr;

       //============================================================*
       //    c_pageUp      "Page Up"                                 *
       //============================================================*

       begsr c_pageup;

          #startpos = #startpos + 128;
          if #startpos > $buflaenge;
             #startpos = $buflaenge - 128 + 1;
          endif;

          *in93 = *on;
          isdatachg = *in93;

          exsr c_enter;

       endsr;

       //============================================================*
       //    c_pageDown    "Page Down"                               *
       //============================================================*

       begsr c_pagedown;

          #startpos = #startpos - 128;
          if #startpos < 1;
             #startpos = 1;
          endif;

          *in93 = *on;
          isdatachg = *in93;

          exsr c_enter;

       endsr;

       //============================================================*
       //    bzoff1        Ausschalten aller Fehlerbezugszahlen      *
       //============================================================*

       begsr bzoff1;

          //  DSPATR(PC)
          *in20 = *off; // ##FIELD
          *in21 = *off; // ##FIELD

          //  DSPATR(RI)
          *in30 = *off; // ##FIELD
          *in31 = *off; // ##FIELD

          //  Fehler
          isPgmError = bFalse;

          //  Warnungen
          if isdatachg = bTrue;
             warning_1 = bFalse;
             warning_2 = bFalse;
          endif;

       endsr;

       //============================================================*
       //    prfb1         Prüfen der Eingaben                       *
       //============================================================*

       begsr prfb1;

          //  Länge und Zeichen des Hex-Strings
          exsr prf20;
          if isPgmError = bTrue;
             leavesr;
          endif;

          //  Startposition
          exsr prf21;
          if isPgmError = bTrue;
             leavesr;
          endif;

          endsr;

       //============================================================*
       //    prf20         Prüfen:  Hex-String                       *
       //============================================================*

       begsr prf20;

          dou ('1');

             //  prüfen auf unzulässige Zeichen
             x = %check(HEX_DIGITS: #hexstring);
             if (x > 0  and x <= %len(%trimr(#hexstring)));
                p_sndpgmmg('USR8174'
                          : %subst(#hexstring: x: 1)
                          : sds.pgmname);
                isPgmError = bTrue;
                leave;
             endif;

             //  Zeichenkette zu lang
             if %len(%trimr(#hexstring))/2 + pstartpos - 1 >
                f_buffln(fldl0100);
                if warning_2 = bTrue;
                   #hexstring = %subst(#hexstring :
                                      1          :
                                      f_buffln(fldl0100) * 2);
                   isdatachg = bTrue;
                else;
                   p_sndpgmmg('USR8176': '': sds.pgmname);
                   warning_2 = bTrue;
                   isPgmError = bTrue;
                   leave;
                endif;
             endif;

             //  Ungerade Anzahl Zeichen
             x = %len(%trimr(#hexstring));
             x = %rem(x: 2);
             if (x <> 0);
                p_sndpgmmg('USR8175': '': sds.pgmname);
                isPgmError = bTrue;
                leave;
             endif;

             //  Zeichenkette zu kurz
             if %len(%trimr(#hexstring))/2 + pstartpos -1 <
                f_buffln(fldl0100)
                and
                (%len(%trimr(#hexstring)) < %len(#hexstring));
                if warning_1 = bTrue;
                   dow (%len(%trimr(#hexstring))/2 + pstartpos -1 <
                       f_buffln(fldl0100))
                      and
                      (%len(%trimr(#hexstring)) < %len(#hexstring));

                      if (i_isucs2 = 0);
                         #hexstring = %trimr(#hexstring) + '40';
                      else;
                         #hexstring = %trimr(#hexstring) + '0020';
                      endif;

                      pfldinhaltsbcs = %subst(pfldinhaltsbcs: 1:
                      pstartpos - 1 + %len(%trimr(#hexstring)));
                      isdatachg = bTrue;
                   enddo;
                else;
                   p_sndpgmmg('USR8186': '': sds.pgmname);
                   warning_1  = bTrue;
                   isPgmError = bTrue;
                   leave;
                endif;
             endif;

          enddo;

          if (isPgmError = bTrue);
             *in20 = *on;
             *in30 = *on;
             #startpos = pstartpos;
          endif;

       endsr;

       //============================================================*
       //    prf21         Prüfen:  Startposition                    *
       //============================================================*

       begsr prf21;

          dou ('1');

             if #startpos <= *zeros;
                p_sndpgmmg('USR8178': '': sds.pgmname);
                isPgmError = bTrue;
                leave;
             endif;

             if #startpos > $buflaenge;
                p_sndpgmmg('USR8177': '': sds.pgmname);
                isPgmError = bTrue;
                leave;
             endif;

          enddo;

          if (isPgmError = bTrue);
             *in21 = *on;
             *in31 = *on;
          endif;

       endsr;

       //============================================================*
       //    c_endPgm      F3/F12 - Programm beenden                 *
       //============================================================*

       begsr c_endpgm;

          p_rmvpgmmg(sds.pgmname);

          o_msgid = 'USR8100';

          select;
          when workstn.aid = k_f3;
             usr8100.var1 = 'F3';
          when workstn.aid = k_f12;
             usr8100.var1 = 'F12';
          other;
             usr8100.var1 = 'Fxx';
          endsl;

          o_msgdta = usr8100;

       endsr;

       //============================================================*
       //    c_firstPos    Erste Position anzeigen                   *
       //============================================================*

       begsr c_firstpos;

          #startpos = 1;

          isdatachg = bTrue;
          exsr c_enter;

       endsr;

       //============================================================*
       //    c_lastPos     Letzte Position anzeigen                  *
       //============================================================*

       begsr c_lastpos;

          #startpos = $buflaenge            -
                     %len(#hexstring) / 2 +
                     1;
          if #startpos < 0;
             #startpos = 1;
          endif;

          isdatachg = bTrue;
          exsr c_enter;

       endsr;

       //============================================================*
       //    c_moveL       Nach links verschieben                    *
       //============================================================*

       begsr c_movel;

          if #startpos - %len(#hexstring)/2 > 0;
             #startpos = #startpos - %len(#hexstring)/2;
          else;
             #startpos = 1;
          endif;

          isdatachg = bTrue;
          exsr c_enter;

       endsr;

       //============================================================*
       //    c_moveR       Nach rechts verschieben                   *
       //============================================================*

       begsr c_mover;

          if #startpos + %len(#hexstring)/2 < $buflaenge;
             #startpos = #startpos + %len(#hexstring)/2;
          else;
             #startpos = $buflaenge - %len(#hexstring)/2
                        + 1;
             if #startpos < 0;
                #startpos = 1;
             endif;
          endif;

          isdatachg = bTrue;
          exsr c_enter;

       endsr;

       //============================================================*
       //    c_refresh     F5  - Aktualisieren der Subfile           *
       //============================================================*

       begsr c_refresh;

          pstartpos  = 1;
          exsr getparameters;

          exsr bzoff1;
          exsr fill##;

       endsr;

       //============================================================*
       //    c_tgInput     F7  - Umschalten Eingabe                  *
       //============================================================*

       begsr c_tginput;

          if isstringinp = bTrue;
             isstringinp = bFalse;
          else;
             isstringinp = bTrue;
          endif;

          *in51 = isstringinp;

       endsr;

       //============================================================*
       //    c_moreKeys    F24 - Weitere Tasten                      *
       //============================================================*

       begsr c_morekeys;

          sfbot = sfbot + 1;

       endsr;

       //============================================================*
       //    fill##        Füllen Bildschirm                         *
       //============================================================*

       begsr fill##;

          //  anzeigen Feldüberschrift
          $fldname = f_headline(i_headtype: fldl0100);

          //  anzeigen alphanumerisches oder numerisches Feld
          if (f_isnumfld(fldl0100) = bTrue) and
             (f_isfloatfld(fldl0100) = bFalse);
             *in60 = *on;
             $fldlaenge = fldl0100.f1digt;
             $flddezst  = fldl0100.f1decp;
          else;
             *in60 = *off;
             $fldlaenge = f_buffln(fldl0100);
             $flddezst  = 0;
          endif;

          //  anzeigen Pufferlänge
          if f_isvarlen(fldl0100) = bTrue;
             *in61 = *on;
          else;
             *in61 = *off;
          endif;

          $buflaenge = f_buffln(fldl0100);

          #startpos = pstartpos;

          exsr fill##2;

       endsr;

       //=========================================================*
       //    fill##2    - füllen Felder:  #HexString             *
       //                                 $ExpString             *
       //                 aus pFldInhalt                         *
       //=========================================================*

       begsr fill##2;

          //  berechnen der Länge der aus dem Puffer zu
          //  entnehmenden Binärzeichenkette
          ptmphexlen = $buflaenge - #startpos + 1;

          if ptmphexlen > %len(#hexstring) / 2;
             ptmphexlen = %len(#hexstring) / 2;
          endif;

          //  entnehmen der Binärzeichenkette aus dem Puffer
          %subst(ptmphexbin: 1) =
          %subst(pfldinhaltsbcs: #startpos: ptmphexlen);

          //  umwandeln einer Binärzeichenkette in eine
          //  lesbare Hex-Zeichenkette zur Editierung
          //  durch den Benutzer
          #hexstring = ' ';
          p_hextochr(#hexstring    :
                    ptmphexbin    :
                    ptmphexlen * 2);

          //  Umsetzen Zeichensatz
          if (f_hasccsid(fldl0100) = bTrue);
             htranscoder =
              transcoder_tojobccsid(fldl0100.f1fdcc);
             ptmpnewlen =
              transcoder_xlatebuffer(htranscoder
                                     : %addr(ptmphexbin)
                                     : ptmphexlen
                                     : %size(ptmphexbin));
             if ptmphexlen = ptmpnewlen * 2;
                for i = ptmpnewlen downto 1;
                   %subst(ptmphexbin: (2*i)-1: 1) =
                   %subst(ptmphexbin: i: 1);
                   %subst(ptmphexbin: (2*i)  : 1) = ' ';
                endfor;
             endif;
          endif;

          //  anzeigen expandierte Zeichenkette aus dem Puffer ...
          //  ... konvertieren nicht darstellbarer Zeichen
          ybuffer    = ptmphexbin;
          ybufflen   = ptmphexlen;
          peek32(ybuffer: ybufflen: 0: ymsgid: ymsgdta);
          $expstring = ybuffer;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = *off;
             //   132-Zeichen Anzeige
             *in88 = *off;
             zei = 4;
             pos = 43;
          else;
             //    80-Zeichen Anzeige
             *in88 = *on;
             zei = 3;
             pos = 4;
          endif;

       endsr;

       //============================================================*
       //    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
       //============================================================*

       begsr getusrsetg;

          //  *CVTCHR
          set0006 = f_getusrsg('*CVTCHR');

       endsr;

       //============================================================*
       //    GetParameters Laden der Programmparameter               *
       //============================================================*

       begsr getparameters;

          if (i_isucs2 = 0);
             clear pfldinhaltsbcs;
             %subst(pfldinhaltsbcs: 1: io_length) =
                   io_fldinhalt.sbcs;
          else;
             clear pfldinhaltucs2;
             %subst(pfldinhaltucs2: 1: io_length) =
                   io_fldinhalt.ucs2;
          endif;

          plength = io_length;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peekfld;

          open peek45fm;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          // - Genereller Programmfehler
          isPgmError = bFalse;

          // - Ermitteln der Feldeigenschaften
          clear f_key;
          f_key.f_field = i_fldname;
          chain %kds(f_key) fpeekfld;
          if (not %found(peekfld));
             isPgmError = bTrue;
             clear fldl0100;
             clear usr8136;
             usr8136.var1   = i_fldname;
             p_sndpgmmg('USR8136': usr8136: sds.pgmname);
          else;
             isPgmError = bFalse;
             fldl0100   = f_ffd;
          endif;

          // - Übernehmen der Programmparameter
          pstartpos  = 1;
          exsr getparameters;

          if (isPgmError = bTrue);
             *in70 = '1';
          else;
             *in70 = i_protect;
          endif;

          o_msgid  = '';
          o_msgdta = '';

          // - Benutzervoreinstellungen
          exsr getusrsetg;

          // - Sperren Felder für Offset-Anzeige
          *in50 = '0';

          // - Sperren Felder für String-Eingabe
          isstringinp = bFalse;
          *in51 = isstringinp;

          // - Füllen der Bildschirmfelder
          exsr bzoff1;
          exsr fill##;

          // - Darstellung der Befehlstasten
          sfbot = 1;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

          // - Copyright
          p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

       endsr;

       //====================================================*
       //  Copy program fields to screen.                    *
       //====================================================*

       begsr toscreen;

          $ofs1 = $ofsval( 1);
          $ofs2 = $ofsval( 2);
          $ofs3 = $ofsval( 3);
          $ofs4 = $ofsval( 4);
          $ofs5 = $ofsval( 5);
          $ofs6 = $ofsval( 6);
          $ofs7 = $ofsval( 7);
          $ofs8 = $ofsval( 8);

          #hex11 = #hexval( 1);
          #hex12 = #hexval( 2);
          #hex13 = #hexval( 3);
          #hex14 = #hexval( 4);

          #hex21 = #hexval( 5);
          #hex22 = #hexval( 6);
          #hex23 = #hexval( 7);
          #hex24 = #hexval( 8);

          #hex31 = #hexval( 9);
          #hex32 = #hexval(10);
          #hex33 = #hexval(11);
          #hex34 = #hexval(12);

          #hex41 = #hexval(13);
          #hex42 = #hexval(14);
          #hex43 = #hexval(15);
          #hex44 = #hexval(16);

          #hex51 = #hexval(17);
          #hex52 = #hexval(18);
          #hex53 = #hexval(19);
          #hex54 = #hexval(20);

          #hex61 = #hexval(21);
          #hex62 = #hexval(22);
          #hex63 = #hexval(23);
          #hex64 = #hexval(24);

          #hex71 = #hexval(25);
          #hex72 = #hexval(26);
          #hex73 = #hexval(27);
          #hex74 = #hexval(28);

          #hex81 = #hexval(29);
          #hex82 = #hexval(30);
          #hex83 = #hexval(31);
          #hex84 = #hexval(32);

          $str1 = $strval( 1);
          $str2 = $strval( 2);
          $str3 = $strval( 3);
          $str4 = $strval( 4);
          $str5 = $strval( 5);
          $str6 = $strval( 6);
          $str7 = $strval( 7);
          $str8 = $strval( 8);

       endsr;

       //====================================================*
       //  Copy screen to program fields.                    *
       //====================================================*

       begsr fromscreen;

          $ofsval( 1) = $ofs1;
          $ofsval( 2) = $ofs2;
          $ofsval( 3) = $ofs3;
          $ofsval( 4) = $ofs4;
          $ofsval( 5) = $ofs5;
          $ofsval( 6) = $ofs6;
          $ofsval( 7) = $ofs7;
          $ofsval( 8) = $ofs8;

          #hexval( 1) = #hex11;
          #hexval( 2) = #hex12;
          #hexval( 3) = #hex13;
          #hexval( 4) = #hex14;

          #hexval( 5) = #hex21;
          #hexval( 6) = #hex22;
          #hexval( 7) = #hex23;
          #hexval( 8) = #hex24;

          #hexval( 9) = #hex31;
          #hexval(10) = #hex32;
          #hexval(11) = #hex33;
          #hexval(12) = #hex34;

          #hexval(13) = #hex41;
          #hexval(14) = #hex42;
          #hexval(15) = #hex43;
          #hexval(16) = #hex44;

          #hexval(17) = #hex51;
          #hexval(18) = #hex52;
          #hexval(19) = #hex53;
          #hexval(20) = #hex54;

          #hexval(21) = #hex61;
          #hexval(22) = #hex62;
          #hexval(23) = #hex63;
          #hexval(24) = #hex64;

          #hexval(25) = #hex71;
          #hexval(26) = #hex72;
          #hexval(27) = #hex73;
          #hexval(28) = #hex74;

          #hexval(29) = #hex81;
          #hexval(30) = #hex82;
          #hexval(31) = #hex83;
          #hexval(32) = #hex84;

          $strval( 1) = $str1;
          $strval( 2) = $str2;
          $strval( 3) = $str3;
          $strval( 4) = $str4;
          $strval( 5) = $str5;
          $strval( 6) = $str6;
          $strval( 7) = $str7;
          $strval( 8) = $str8;

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
          peek32_name = f_pgmcalln('PEEK32');

          peek23(sds.pgmname: '*ALL': 0
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

