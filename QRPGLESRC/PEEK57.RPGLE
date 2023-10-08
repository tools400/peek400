       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.1.0                               *
       //  Programm : PEEK57                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 06.05.1999  Raddatz                               *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Peek/400 - Löschen   "Arbeitsumgebung"                       *
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

       dcl-f peek57fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,DS_WORKSTN
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,ERR_D_SDS
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110

      /define internal_prototype
      /COPY QCOPYLE,PPEEK57
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       //  Peek21:
       dcl-s ypgmcmd         char(10) inz(*blanks);
       dcl-s ycmddta         like(pgmcmddt_t);
       dcl-s ymsgid          char(7) inz(*blanks);
       dcl-s ymsgdta         char(512) inz(*blanks);

       //  Peek23:
       dcl-s yfkeys          char(18) dim(32);
       dcl-s ynbrofkeys      like(int4_t);

       dcl-s sfbot           like(int4_t);
       dcl-c nbrfkeys const(2);
       dcl-s ispgmerror      like(bool_t) inz(bfalse);

       dcl-s peek21_name     like(pgmcalln_t);
       dcl-s peek23_name     like(pgmcalln_t);

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek57;
         i_dsp80         const like(dsp80_t);
         i_copyright     const like(copyrght_t);
         i_envfile       const like(file_t);
         i_envlib        const like(lib_t);
         i_envmbr        const like(mbr_t);
         i_envtext       const like(text_t);
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

          //  Nachrichten anzeigen
          *in89 = '0';
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
          *in70 = '0';

          //  Nachrichten löschen
          p_rmvpgmmg(§§pgmname);

          //  Mappen der gedrückten Taste
          //  in Programmbefehl
          peek21(workstn.aid: §§pgmname
                : ypgmcmd: ycmddta: ymsgid: ymsgdta);
          if ymsgid <> *blanks;
             p_sndpgmmg(ymsgid: ymsgdta: §§pgmname);
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

             //  F9  - Löschen Arbeitsumgebung
          when ypgmcmd = '*DELETEENV';
             exsr c_delenv;
             if (ispgmerror = btrue);
                leave;
             else;
                iter;
             endif;

             //  F12 - Ende
          when ypgmcmd = '*CANCEL';
             exsr c_endpgm;
             leave;

             //  F24 - Weitere Tasten
          when ypgmcmd = '*MOREKEYS';
             exsr c_morekeys;

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: §§pgmname);
             iter;
          endsl;

       enddo;

       close peek57fm;

       return;

       //============================================================*
       //    C_EndPgm      F3/F12 - Programm beenden                 *
       //============================================================*

       begsr c_endpgm;

          p_rmvpgmmg(§§pgmname);

          o_msgid = 'USR8100';
          usr8100.var1 = ypgmcmd;
          o_msgdta = usr8100;

       endsr;

       //============================================================*
       //    C_Refresh     F5  - Aktualisieren der Subfile           *
       //============================================================*

       begsr c_refresh;

          exsr fill##;

       endsr;

       //============================================================*
       //    C_MoreKeys    F24 - Weitere Tasten                      *
       //============================================================*

       begsr c_morekeys;

          sfbot = sfbot + 1;

       endsr;

       //============================================================*
       //    C_delEnv      Verarbeiten der Eingaben                  *
       //============================================================*

       begsr c_delenv;

          f_execute('RMVM'          +
                   ' FILE('        +
                   %trim(i_envlib ) +
                   '/'             +
                   %trim(i_envfile) +
                   ')'             +
                   ' MBR('         +
                   %trim(i_envmbr ) +
                   ')'             :
                   ymsgid          :
                   ymsgdta         );

          if (ymsgid <> '');
             p_sndpgmmg(ymsgid: ymsgdta: §§pgmname);
             ymsgid = '';
             ymsgdta = '';
             ispgmerror = btrue;
          else;
             ispgmerror = bfalse;
          endif;

       endsr;

       //============================================================*
       //    FILL##        Füllen Bildschirm                         *
       //============================================================*

       begsr fill##;

          ##file  = i_envfile;
          ##lib   = i_envlib;
          ##mbr   = i_envmbr;
          ##text  = i_envtext;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if (i_dsp80 = '0');
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 6;
             pos = 40;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 6;
             pos = 19;
          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peek57fm;

          // - Programm initialisieren
          p_rmvpgmmg(§§pgmname);

          // - Rückkehrcode
          o_msgid = *blanks;
          o_msgdta = *blanks;

          // - Darstellung der Befehlstasten
          sfbot = 1;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

          // - Bildschirm füllen
          exsr c_refresh;

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

          peek23(§§pgmname: '*ALL': 0
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

