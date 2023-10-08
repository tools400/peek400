       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 3.0.0                               *
       //  Programm : PEEK64                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 26.04.2007                                        *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Feldeditor                                        *
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

       dcl-f peek64fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

       dcl-f peekfld keyed usropn prefix(f_) infds(peek_01_ds);

       dcl-ds workstn likeds(workstn_t);

       dcl-ds peek_01_ds likeds(infds_t);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,D_COLORATR
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8123
      /COPY QCOPYLE,USR8136

      /define internal_prototype
      /COPY QCOPYLE,PPEEK64
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s ypgmcmd         like(pgmcmd_t);
       dcl-s ycmddta         like(pgmcmddt_t);
       dcl-s ymsgid          like(msgid_t);
       dcl-s ymsgdta         like(msgdta_t);

       dcl-s yfkeys          like(fkeydsp_t) dim(32);
       dcl-s ynbrofkeys      like(int4_t) inz;

       dcl-s sfbot           like(int4_t);
       dcl-c §nbrfkeys const(3);

       dcl-s peek21_name     like(pgmcalln_t);
       dcl-s peek23_name     like(pgmcalln_t);

       // Arbeitsfelder
       dcl-s isPgmError      like(bool_t) inz(bfalse);
       dcl-s isdatachg       like(bool_t) inz(bfalse);
       dcl-ds *N;
         pfldinhaltsbcs  like(rcdbuf_t) inz;
         pfldinhaltucs2  like(rcdbufucs2_t) inz
              overlay(pfldinhaltsbcs);
       end-ds;
       dcl-s plength         like(int4_t);
       dcl-s len             like(int4_t);
       dcl-s isfieldtoolarge
             ind;
       dcl-s maxfieldlength  int(10);

       dcl-ds *N;
         #ucs2str        ucs2(2048) pos(1);
         #ucs2           ucs2(128) ccsid(13488) dim(16) pos(1);
       end-ds;

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek64;
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
       if (isPgmError = bFalse);

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

             //  Anzeigen Bildschirm
             exfmt bild01;

             //  Übernehmen Bildschirmfelder in Programmfelder
             exsr fillpgmflds;

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
             when ypgmcmd = '*EXIT' or ypgmcmd = '*NO';
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

                //  F24 - Weitere Tasten
             when ypgmcmd = '*MOREKEYS';
                exsr c_morekeys;

                //  Datenfreigabe
             when ypgmcmd = '*ENTER' or ypgmcmd = '*OK';
                exsr c_enter;
                if isPgmError = bfalse;
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

       endif;

       if %open(peekfld);
          close peekfld;
       endif;

       close peek64fm;

       return;

       //============================================================*
       //    c_enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          if isPgmError = btrue;

             //    ---------------------------------
             //    *** Genereller Programmfehler ***
             //    ***    keine Verarbeitung     ***
             //    ***          möglich          ***
             //    ---------------------------------

          else;

             //  Prüfen der Eingaben
             exsr prfb1;

             if isPgmError = bfalse;
                if isdatachg = btrue;

                   //  ... einsetzen in Zwischenfeld für Rückgabewert
                   if (i_isucs2 = 0);

                      if (isfieldtoolarge);
                         plength = io_length;
                      else;
                         plength = %len(%trimr(#string));
                      endif;

                      %subst(pfldinhaltsbcs: 1: %len(#string)) =
                       #string;

                   else;

                      if (isfieldtoolarge);
                         plength = io_length;
                      else;
                         plength = %len(%trimr(#ucs2str));
                      endif;

                      %subst(pfldinhaltucs2: 1: %len(#ucs2str)) =
                       #ucs2str;

                   endif;

    R              //**                Eval      isPgmError = bTrue
                endif;
             endif;

          endif;

       endsr;

       //============================================================*
       //    bzoff1        Ausschalten aller Fehlerbezugszahlen      *
       //============================================================*

       begsr bzoff1;

          //  DSPATR(PC)
          *in20 = *off; // #STRING/#UCS2

          //  DSPATR(RI)
          *in30 = *off; // #STRING/#UCS2

          //  Fehler
          isPgmError = bfalse;

       endsr;

       //============================================================*
       //    prfb1         Prüfen der Eingaben                       *
       //============================================================*

       begsr prfb1;

          //  Länge und der Zeichenkette
          exsr prf20;
          if isPgmError = btrue;
             leavesr;
          endif;

          endsr;

       //============================================================*
       //    prf20         Prüfen:  Hex-String                       *
       //============================================================*

       begsr prf20;

          if (i_isucs2 = 0);
             len = %len(%trimr(#string));
          else;
             len = %len(%trimr(#ucs2str));
          endif;

          //  Zeichenkette zu lang
          if (len > f_dsplyln(fldl0100));
             p_sndpgmmg('USR8176': '': sds.pgmname);
             isPgmError = btrue;
          endif;

          if isPgmError = btrue;
             *in20 = *on;
             *in30 = *on;
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
       //    c_refresh     F5  - Aktualisieren der Subfile           *
       //============================================================*

       begsr c_refresh;

          exsr getparameters;

          exsr bzoff1;
          exsr fill##;

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

          //  anzeigen Feldinhalt
          if (i_isucs2 = 0);

             #string = pfldinhaltsbcs;
             *in71 = '0';

          else;

             #ucs2str = pfldinhaltucs2;

             #ucs2_1 = #ucs2(1);
             #ucs2_2 = #ucs2(2);
             #ucs2_3 = #ucs2(3);
             #ucs2_4 = #ucs2(4);
             #ucs2_5 = #ucs2(5);
             #ucs2_6 = #ucs2(6);
             #ucs2_7 = #ucs2(7);
             #ucs2_8 = #ucs2(8);
             #ucs2_9 = #ucs2(9);
             #ucs2_10 = #ucs2(10);
             #ucs2_11 = #ucs2(11);
             #ucs2_12 = #ucs2(12);
             #ucs2_13 = #ucs2(13);
             #ucs2_14 = #ucs2(14);
             #ucs2_15 = #ucs2(15);
             #ucs2_16 = #ucs2(16);

             *in71 = '1';

          endif;

       endsr;

       //============================================================*
       //    fillPgmFlds   Füllen Programmfelder                     *
       //============================================================*

       begsr fillpgmflds;

          if (i_isucs2 = 0);

             //    Nothing to do here

          else;

             #ucs2(1) = #ucs2_1;
             #ucs2(2) = #ucs2_2;
             #ucs2(3) = #ucs2_3;
             #ucs2(4) = #ucs2_4;
             #ucs2(5) = #ucs2_5;
             #ucs2(6) = #ucs2_6;
             #ucs2(7) = #ucs2_7;
             #ucs2(8) = #ucs2_8;
             #ucs2(9) = #ucs2_9;
             #ucs2(10) = #ucs2_10;
             #ucs2(11) = #ucs2_11;
             #ucs2(12) = #ucs2_12;
             #ucs2(13) = #ucs2_13;
             #ucs2(14) = #ucs2_14;
             #ucs2(15) = #ucs2_15;
             #ucs2(16) = #ucs2_16;

          endif;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if (i_dsp80 = *off);
             //   132-Zeichen Anzeige
             *in88 = *off;
             zei = 4;
             pos = 43;
          else;
             //    80-Zeichen Anzeige
             *in88 = *on;
             zei = 2;
             pos = 4;
          endif;

       endsr;

       //============================================================*
       //    GetParameters Laden der Programmparameter               *
       //============================================================*

       begsr getparameters;

          if (i_isucs2 = 0);
             clear pfldinhaltsbcs;
             %subst(pfldinhaltsbcs: 1: io_length) =
                   io_fldinhalt.sbcs;
             maxfieldlength = %len(#string);
          else;
             clear pfldinhaltucs2;
             %subst(pfldinhaltucs2: 1: io_length) =
                   io_fldinhalt.ucs2;
             maxfieldlength = %len(#ucs2str);
          endif;

          plength = io_length;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peekfld;

          open peek64fm;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          //  ermitteln der Feldeigenschaften
          clear f_key;
          f_key.f_field = i_fldname;
          chain %kds(f_key) fpeekfld;
          if (not %found(peekfld));
             isPgmError = btrue;
             clear fldl0100;
             clear usr8136;
             usr8136.var1   = i_fldname;
             p_sndpgmmg('USR8136': usr8136: sds.pgmname);
          else;
             isPgmError = bfalse;
             fldl0100   = f_ffd;
          endif;

          if (isPgmError = btrue);
             leavesr;
          endif;

          // - Übernehmen der Programmparameter
          exsr getparameters;

          o_msgid  = ' ';
          o_msgdta = ' ';

          if (plength > maxfieldlength);
             isfieldtoolarge = btrue;
             *in70 = btrue;
          else;
             isfieldtoolarge = bfalse;
             *in70 = i_protect;
          endif;

          // - Feld zu groß Hinweis ausgeben
          clear usr8123;
          usr8123.var1 = COLOR_white_u;
          usr8123.var2 = COLOR_white;
          p_sndpgmmg('USR8123': usr8123: sds.pgmname);

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
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isInzSr = btrue);
             leavesr;
          endif;

          isInzSr = btrue;

          §pgmq = '*';

          peek21_name = f_pgmcalln('PEEK21');
          peek23_name = f_pgmcalln('PEEK23');

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

