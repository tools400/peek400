       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.2.0                               *
       //  Programm : PEEK59                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 06.08.1999  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Generische Nachrichtenabfrage                     *
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

       dcl-f peek59fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

       dcl-ds workstn likeds(workstn_t);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8190

      /define internal_prototype
      /COPY QCOPYLE,PPEEK59
      /undefine internal_prototype

       //  Peek21
       dcl-s ypgmcmd         like(pgmcmd_t);
       dcl-s ycmddta         like(pgmcmddt_t);
       dcl-s ymsgid          like(msgid_t);
       dcl-s ymsgdta         like(msgdta_t);

       //  Peek23:
       dcl-s ykey            char(10);
       dcl-s yfkeys          like(fkeydsp_t) dim(32);
       dcl-s ynbrofkeys      like(int4_t);

       dcl-s sfbot           like(int4_t);
       dcl-c nbrfkeys const(2);
       dcl-s msgtext         char(200);
       dcl-s strpos          like(uint4_t);
       dcl-s nbrofkeys       like(int4_t);

       dcl-s peek21_name     like(pgmcalln_t);
       dcl-s peek23_name     like(pgmcalln_t);

       dcl-s x               like(int4_t) inz;
       dcl-s tmpfkey         like($$fkey01);
       dcl-s int1            like(int4_t);
       dcl-s int2            like(int4_t);
       dcl-s ischanged       like(bool_t) inz(bfalse);


       dcl-pr atoi            int(10) extproc('atoi');
         i_string        pointer value;
       end-pr;

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-s $$fkey          like($$fkey01) dim(24);

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek59;
         i_dsp80         const like(dsp80_t);
         i_type          const like(type_t);
         i_msgid         const like(msgid_t);
         i_msgdta        const like(msgdta_t);
         i_keys          char(3) const;
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       dow ('1');

          exsr toscreen;

          //  Nachrichten anzeigen
          *in89 = *off;
          write msgctl;

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

          //  Anzeigen Bildschirm
          exfmt bild01;

          exsr fromscreen;

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
             //  F5  - Aktualisieren
          when ypgmcmd = '*REFRESH';
             exsr c_refresh;
             iter;
             //  F9  - Yes
          when (ypgmcmd = '*YES'   )  and
             (f_scan('Y': i_keys  ) <> 0);
             exsr c_yes;
             leave;

             //  F21 - No
          when (ypgmcmd = '*NO'    ) and
             (f_scan('N': i_keys  ) <> 0);
             exsr c_no;
             leave;

             //  F12 - Cancel
          when (ypgmcmd = '*CANCEL') and
             (f_scan('C': i_keys  ) <> 0);
             exsr c_cancel;
             leave;

             //  F24 - Weitere Tasten
          when ypgmcmd = '*MOREKEYS';
             exsr c_morekeys;
             iter;

             //  Datenfreigabe = OK
          when (ypgmcmd = '*ENTER' ) and
             (f_scan('E': i_keys  ) <> 0);
             exsr c_enter;
             leave;

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: sds.pgmname);
             iter;
          endsl;

       enddo;

       close peek59fm;

       *inlr = *on;

       //============================================================*
       //    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
       //============================================================*

       begsr bzoff1;

          //  DSPATR(PC)

          //  DSPATR(RI)

          //  Fehler
          *in99 = '0';

       endsr;

       //============================================================*
       //    c_yes         F9 = Yes                                  *
       //============================================================*

       begsr c_yes;

          clear usr8190;
          usr8190.var1 = ypgmcmd;
          o_msgid  = 'USR8190';
          o_msgdta = usr8190;

       endsr;

       //============================================================*
       //    c_no          F3 = No                                   *
       //============================================================*

       begsr c_no;

          clear usr8190;
          usr8190.var1 = ypgmcmd;
          o_msgid  = 'USR8190';
          o_msgdta = usr8190;

       endsr;

       //============================================================*
       //    c_enter       "Datenfreigabetaste" = OK                 *
       //============================================================*

       begsr c_enter;

          clear usr8190;
          usr8190.var1 = ypgmcmd;
          o_msgid  = 'USR8190';
          o_msgdta = usr8190;

       endsr;

       //============================================================*
       //    c_cancel      F12 = Cancel                              *
       //============================================================*

       begsr c_cancel;

          clear usr8190;
          usr8190.var1 = ypgmcmd;
          o_msgid  = 'USR8190';
          o_msgdta = usr8190;

       endsr;

       //============================================================*
       //    c_refresh     F5  - Aktualisieren der Subfile           *
       //============================================================*

       begsr c_refresh;

          exsr fill##;

       endsr;

       //============================================================*
       //    c_moreKeys    F24 - Weitere Tasten                      *
       //============================================================*

       begsr c_morekeys;

          sfbot = sfbot + 1;

       endsr;

       //============================================================*
       //    FILL##        Füllen Bildschirm                         *
       //============================================================*

       begsr fill##;

          //  Überschrift ...
          select;
          when i_type = '*INFO';
             $$headline = f_msgtext('MBX0001': ' ');
          when i_type = '*QUESTION';
             $$headline = f_msgtext('MBX0002': ' ');
          other;
             $$headline = ' ';
          endsl;

          p_center($$headline);

          //  Nachrichtentext ...
          msgtext = f_msgtext(i_msgid: i_msgdta);

          //  ... Zeile 1
          strpos = 1;
          $$line#01 = f_wordwrap(msgtext: 40: strpos);
          $$line#01 = %triml($$line#01);
          //  ... Zeile 2
          if strpos > 0;
             $$line#02 = f_wordwrap(msgtext: 40: strpos);
             $$line#02 = %triml($$line#02);
          endif;
          //  ... Zeile 3
          if strpos > 0;
             $$line#03 = f_wordwrap(msgtext: 40: strpos);
             $$line#03 = %triml($$line#03);
          endif;
          //  ... Zeile 4
          if strpos > 0;
             $$line#04 = f_wordwrap(msgtext: 40: strpos);
             $$line#04 = %triml($$line#04);
          endif;
          //  ... Zeile 5
          if strpos > 0;
             $$line#05 = f_wordwrap(msgtext: 40: strpos);
             $$line#05 = %triml($$line#05);
          endif;

          //  Funktionstasten ...
          nbrofkeys = 0;
          yfkeys(*) = '';
          $$fkey(*) = '';
          //  ... YES
          if f_scan('Y': i_keys) <> 0;
             nbrofkeys = nbrofkeys + 1;
             ykey = '*YES';
             exsr getkey;
             $$fkey(nbrofkeys) = yfkeys(1);
          endif;
          //  ... NO
          if f_scan('N': i_keys) <> 0;
             nbrofkeys = nbrofkeys + 1;
             ykey = '*NO';
             exsr getkey;
             $$fkey(nbrofkeys) = yfkeys(1);
          endif;
          //  ... OK
          if f_scan('E': i_keys) <> 0;
             nbrofkeys = nbrofkeys + 1;
             ykey = '*OK';
             exsr getkey;
             $$fkey(nbrofkeys) = yfkeys(1);
          endif;
          //  ... CANCEL
          if f_scan('C': i_keys) <> 0;
             nbrofkeys = nbrofkeys + 1;
             ykey = '*CANCEL';
             exsr getkey;
             $$fkey(nbrofkeys) = yfkeys(1);
          endif;

          //  Sortieren der Funktionstasten
          if nbrofkeys > 1;
             dou ischanged = bfalse;
                ischanged = bfalse;
                for x = 2 to nbrofkeys;
                   tmpfkey = %subst(scrnfkeys(x-1): 2)+x'00';
                   int1 = atoi(%addr(tmpfkey));
                   tmpfkey = %subst(scrnfkeys(x  ): 2)+x'00';
                   int2 = atoi(%addr(tmpfkey));
                   if int2 < int1;
                      ischanged = btrue;
                      tmpfkey = scrnfkeys(x-1);
                      scrnfkeys(x-1) = scrnfkeys(x);
                      scrnfkeys(x  ) = tmpfkey;
                   endif;
                endfor;
             enddo;
          endif;

          ynbrofkeys = nbrofkeys;

       endsr;

       //============================================================*
       //    getKey        Einlesen F-Taste                          *
       //============================================================*

       begsr getkey;

          peek23(sds.pgmname: ykey: 0
                : yfkeys: ynbrofkeys);

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = *off;
             //   132-Zeichen Anzeige
             *in88 = *off;
             zei = 6 + 1;
             pos = 40;
          else;
             //    80-Zeichen Anzeige
             *in88 = *on;
             zei = 4 + 3;
             pos = 7;
          endif;

       endsr;

       //====================================================*
       //  Copy program fields to screen.                    *
       //====================================================*

       begsr toscreen;

          $$fkey01 = $$fkey( 1);
          $$fkey02 = $$fkey( 2);
          $$fkey03 = $$fkey( 3);
          $$fkey04 = $$fkey( 4);
          $$fkey05 = $$fkey( 5);
          $$fkey06 = $$fkey( 6);
          $$fkey07 = $$fkey( 7);
          $$fkey08 = $$fkey( 8);
          $$fkey09 = $$fkey( 9);
          $$fkey10 = $$fkey(10);
          $$fkey11 = $$fkey(11);
          $$fkey12 = $$fkey(12);
          $$fkey13 = $$fkey(13);
          $$fkey14 = $$fkey(14);
          $$fkey15 = $$fkey(15);
          $$fkey16 = $$fkey(16);
          $$fkey17 = $$fkey(17);
          $$fkey18 = $$fkey(18);
          $$fkey19 = $$fkey(19);
          $$fkey20 = $$fkey(20);
          $$fkey21 = $$fkey(21);
          $$fkey22 = $$fkey(22);
          $$fkey23 = $$fkey(23);
          $$fkey24 = $$fkey(24);

       endsr;

       //====================================================*
       //  Copy screen to program fields.                    *
       //====================================================*

       begsr fromscreen;

          $$fkey( 1) = $$fkey01;
          $$fkey( 2) = $$fkey02;
          $$fkey( 3) = $$fkey03;
          $$fkey( 4) = $$fkey04;
          $$fkey( 5) = $$fkey05;
          $$fkey( 6) = $$fkey06;
          $$fkey( 7) = $$fkey07;
          $$fkey( 8) = $$fkey08;
          $$fkey( 9) = $$fkey09;
          $$fkey(10) = $$fkey10;
          $$fkey(11) = $$fkey11;
          $$fkey(12) = $$fkey12;
          $$fkey(13) = $$fkey13;
          $$fkey(14) = $$fkey14;
          $$fkey(15) = $$fkey15;
          $$fkey(16) = $$fkey16;
          $$fkey(17) = $$fkey17;
          $$fkey(18) = $$fkey18;
          $$fkey(19) = $$fkey19;
          $$fkey(20) = $$fkey20;
          $$fkey(21) = $$fkey21;
          $$fkey(22) = $$fkey22;
          $$fkey(23) = $$fkey23;
          $$fkey(24) = $$fkey24;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peek59fm;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          o_msgid  = ' ';
          o_msgdta = ' ';

          // - Füllen der Bildschirmfelder
          exsr bzoff1;
          exsr fill##;

          // - Darstellung der Befehlstasten
          sfbot = 1;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

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

