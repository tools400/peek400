       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.2.0                               *
       //  Programm : PEEK17                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 20.10.97  Raddatz                                 *
       //  geändert : 27.04.99  für Version 2.1.0                       *
       //  geändert : 29.07.99  für Version 2.2.0                       *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Erfassen der Suchkriterien                                   *
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

       dcl-f peek17fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

       dcl-f peekfld keyed usropn infds(peek_01_ds) prefix(f_);

       dcl-ds workstn likeds(workstn_t);

       dcl-ds peek_01_ds likeds(infds_t);


      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_WORKSTN
      /COPY QCOPYLE,ShortCmd_D
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,SCRNFKEYS
      /COPY QCOPYLE,D_INFDS

      /define internal_prototype
      /COPY QCOPYLE,PPEEK17
      /undefine internal_prototype

      /COPY QCOPYLE,SET0002
      /COPY QCOPYLE,SET0003
      /COPY QCOPYLE,SET0008

      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8108
      /COPY QCOPYLE,USR8124
      /COPY QCOPYLE,USR8126
      /COPY QCOPYLE,USR8129
      /COPY QCOPYLE,USR8134
      /COPY QCOPYLE,USR8135
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8138
      /COPY QCOPYLE,USR8140
      /COPY QCOPYLE,USR8141
      /COPY QCOPYLE,USR8142
      /COPY QCOPYLE,USR8192

       dcl-ds set0002  likeds(set0002_t) inz;
       dcl-ds set0003  likeds(set0003_t) inz;
       dcl-ds set0008  likeds(set0008_t) inz;

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s yfkeys          char(18) dim(32);
       dcl-s ynbrofkeys      like(int4_t);
       dcl-s ymsgid          char(7);
       dcl-s ymsgdta         char(512);

       dcl-s ypgmcmd         char(10);
       dcl-s ycmddta         like(pgmcmddt_t);

       dcl-s yfield          char(10);

       dcl-s sfbot           like(int4_t);
       dcl-c NBR_F_KEYS const(2);

       dcl-s mustwait        char(1) inz(bFalse);

       dcl-s x               like(int4_t) inz;

       dcl-s r_sign          like(##sign);
       dcl-s r_arg30         like(##arg);
       dcl-s r_qfile         like(i_qfile);
       dcl-s r_member        like(i_member);
       dcl-s r_vork          like(##arg);
       dcl-s r_nachk         like(##arg);
       dcl-s r_a1            char(1);
       dcl-s r_field         like(##field);

       dcl-s peek21_name     like(pgmcalln_t) inz;
       dcl-s peek23_name     like(pgmcalln_t) inz;
       dcl-s peek37_name     like(pgmcalln_t) inz;

      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK37

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58

      /COPY QCOPYLE,CEECNDHDLR

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek17;
         i_dsp80         const like(bool_t);
         i_copyright     const like(copyrght_t);
         i_qfile         const like(qobj_t);
         i_member        const like(mbr_t);
         o_field               like(fieldNme_t);
         o_operation           like(operation_t);
         o_argument            like(argument_t);
         o_sign                like(sign_t);
         o_srchnbrs            like(srchNbrs_t);
         o_srchtype            like(type_t);
         o_srchcase            like(bool_t);
         o_sgid                like(msgid_t);
         o_msgdta              like(msgdta_t);
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

          //  Nachrichten anzeigen
          *in89 = '0';
          write msgctl;

          //  Anzeigen der Befehlstasten
          select;
          when (sfbot = 2) and
             (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
             write pbbot#2;
          when (sfbot = 3) and
             (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
             write pbbot#3;
          when (sfbot = 4) and
             (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
             write pbbot#4;
          when (sfbot = 5) and
             (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
             write pbbot#5;
          when (sfbot = 6) and
             (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
             write pbbot#6;
          other;
             write pbbot#1;
             sfbot = 1;
          endsl;

          //  Anzeigen Bildschirm
          exfmt bild01;

          //  Nachrichten löschen
          p_rmvpgmmg(sds.pgmname);

          //  Bezugszahlen löschen
          exsr bzoff1;

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

          //  Abfragen der Programmbefehle
          select;
             //  F3  - Ende
          when ypgmcmd = '*EXIT';
             exsr c_endpgm;
             leave;

             //  F4  - Prompt
          when ypgmcmd = '*PROMPT';
             exsr c_prompt;
             iter;

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
          when ypgmcmd = '*ENTER';
             exsr c_enter;
             if *in99 = *off;
                o_sgid = 'USR8112';
                o_msgdta = *blanks;
                leave;
             endif;

          other;
             //  Falsche Taste gedrückt
             p_wrongkey(workstn.aid: sds.pgmname);
             iter;
          endsl;

       enddo;

       close peekfld;
       close peek17fm;

       return;

       //============================================================*
       //    C_Enter       "Datenfreigabetaste"                      *
       //============================================================*

       begsr c_enter;

          dou ('1');

             r_field = ##field;

             //  Prompt?
             //  ... ##Field
             if %trim(##field ) = set0008.set_prmt;
                exsr c_prompt;
                if (*in99 = bTrue);
                   leave;
                else;
                   //  ...?
                endif;
             endif;

             exsr prfb1;

             if ##field <> r_field;
                mustwait = bTrue;
             endif;

             if mustwait = bTrue;
                *in99 = '1';
             else;
                //  Wert belassen ...
             endif;

          enddo;

          if *in99 = *off;
             o_field = ##field;
             o_operation = ##op;
             o_argument = r_arg30;
             o_sign = ##sign;
             o_srchnbrs = ##nbrs;

             select;
             when ##type = 'U';
                o_srchtype = '*UNDERLINE';
             when ##type = 'R';
                o_srchtype = '*REVERSE';
             when ##type = 'P';
                o_srchtype = '*PINROW';
             other;
                o_srchtype = '*NORMAL';
             endsl;

             o_srchcase = ##case;

             o_sgid = 'USR8112';
             o_msgdta = *blanks;
          endif;

       endsr;

       //============================================================*
       //    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
       //============================================================*

       begsr bzoff1;

          //  DSPATR(PC)
          *in20 = '0'; // ##FIELD
          *in21 = '0'; // ##OP
          *in22 = '0'; // ##ARG
          *in23 = '0'; // ##NBRS
          *in24 = '0'; // ##TYPE
          *in25 = '0'; // ##CASE

          //  DSPATR(RI)
          *in30 = '0'; // ##FIELD
          *in31 = '0'; // ##OP
          *in32 = '0'; // ##ARG
          *in33 = '0'; // ##NBRS
          *in34 = '0'; // ##TYPE
          *in35 = '0'; // ##CASE

          //  Fehler
          *in99 = '0';

       endsr;

       //============================================================*
       //    PRFB1         Prüfen der Eingaben                       *
       //============================================================*

       begsr prfb1;

          mustwait = bFalse;

          exsr prf20; // Field
          if (*in99 = bTrue);
             leavesr;
          endif;

          exsr prf21; // Operation
          if (*in99 = bTrue);
             leavesr;
          endif;

          exsr prf22; // Argument
          if (*in99 = bTrue);
             leavesr;
          endif;

          exsr prf23; // Search Nbrs
          if (*in99 = bTrue);
             leavesr;
          endif;

          exsr prf24; // Search Type
          if (*in99 = bTrue);
             leavesr;
          endif;

          exsr prf25; // Case-Sens.
          if (*in99 = bTrue);
             leavesr;
          endif;

       endsr;

       //============================================================*
       //    PRF20         Prüfen:  Feldname                         *
       //============================================================*

       begsr prf20;

          dou ('1');

             if ##field = '*RECORD';
                //        suchen im ganzen Datensatz
             else;

                clear f_key;
                f_key.f_field = ##field;
                chain %kds(f_key) fpeekfld;
                if (not %found());
                   //  Fehlermeldung ...
                   *in99 = '1';
                   clear usr8136;
                   usr8136.var1 = ##field;
                   p_sndpgmmg('USR8136': usr8136: sds.pgmname);
                   leave;
                else;
                   fldl0100 = f_ffd;
                endif;

                if fldl0100.f1dtyp <> 'A' and    // alpha-num
                   // FLDL0100.F1DTyp <> 'G' and // graphic
                   fldl0100.f1dtyp <> 'S' and    // Zoned
                   fldl0100.f1dtyp <> 'B' and    // Binary
                   fldl0100.f1dtyp <> 'P' and    // Packed
                   fldl0100.f1dtyp <> 'T' and    // Time
                   fldl0100.f1dtyp <> 'L' and    // Date
                   fldl0100.f1dtyp <> 'F';       // Float
                   *in99 = '1';
                   clear usr8129;
                   usr8129.var1 = ##field;
                   usr8129.var2 = fldl0100.f1dtyp;
                   p_sndpgmmg('USR8129': usr8129: sds.pgmname);
                   leave;
                endif;

             endif;

          enddo;

          if (*in99 = *on);
             *in20 = '1';
             *in30 = '1';
          endif;

       endsr;

       //============================================================*
       //    PRF21         Prüfen:  Operation                        *
       //============================================================*

       begsr prf21;

          dou ('1');

             if ##op <> 'EQ'
                and ##op <> 'NE'
                and ##op <> 'LT'
                and ##op <> 'GT'
                and ##op <> 'LE'
                and ##op <> 'GE'
                and ##op <> 'LIKE'
                and ##op <> 'NLIKE';
                *in99 = '1';
                clear usr8124;
                usr8124.var1 = ##op;
                p_sndpgmmg('USR8124': usr8124: sds.pgmname);
                leave;
             endif;

             if ##field <> '*RECORD';
                if ##op = 'LIKE'
                   or ##op = 'NLIKE';
                   //*   F1DTyp        IFNE      'A'  // alpha-num
                   //*   F1DTyp        ANDNE     'L'  // Date
                   //*   F1DTyp        ANDNE     'T'  // Time
                   if fldl0100.f1dtyp <> 'A' and      // alpha-num
                      fldl0100.f1dtyp <> 'L' and      // Date
                      fldl0100.f1dtyp <> 'T';         // Time
                      *in99 = '1';
                      clear usr8135;
                      usr8135.var1 = ##op;
                      usr8135.var2 = fldl0100.f1dtyp;
                      p_sndpgmmg('USR8135': usr8135: sds.pgmname);
                      leave;
                   endif;
                endif;
             endif;

             if ##field = '*RECORD'
                and ##op <> 'LIKE'
                and ##op <> 'NLIKE';
                *in99 = '1';
                clear usr8134;
                usr8134.var1 = ##op;    // Operation
                usr8134.var2 = ##field; // Feld
                p_sndpgmmg('USR8134': usr8134: sds.pgmname);
                leave;
             endif;

          enddo;

          if *in99 = *on;
             *in21 = '1';
             *in31 = '1';
          endif;

       endsr;

       //============================================================*
       //    PRF22         Prüfen:  Argument                         *
       //============================================================*

       begsr prf22;

          dou ('1');

             r_sign = *blanks;
             ##sign = *blanks;

             if ##arg = *blanks;
                *in99 = '1';
                p_sndpgmmg('USR8140': usr8140: sds.pgmname);
                leave;
             endif;

             //  Umsetzen in internes Arbeitsfeld ...
             //*   cLOWER:cUPPER XLATE (P) ##Arg         R_Arg30
             r_arg30 = %xlate(clower: cupper: ##arg);

             select;
                //  Umsetzen des Sonderwertes "*BLANKS" ...
             when r_arg30 = '*BLANKS'
                or r_arg30 = '*BLANK';
                r_arg30 = *blanks;

                //  Umsetzen des Sonderwertes "*ZEROS" ...
             when r_arg30 = '*ZEROS'
                or r_arg30 = '*ZERO';
                r_arg30 = *zeros;
             other;
                //  ... aktuellen Wert belassen
                r_arg30 = ##arg;
             endsl;

             //  Verarbeiten numerischer Werte ...
             if f_isnumfld(fldl0100) = bTrue;

                //  ... Vorzeichen, links
                exsr signleft;
                //  ... Vorzeichen, rechts
                exsr signright;

                //  ... umsetzen *BLANKS in '+' Zeichen
                if ##sign = *blanks;
                   ##sign = set0003.set_signp;
                else;
                   //      ... Vorzeichen stehen lassen
                endif;

                //  ... gültige Daten
                //      ... Komma extrahieren
                if fldl0100.f1dtyp = 'F'; // Float
                   if f_vldfloat(r_arg30) = bFalse;
                      *in99 = '1';
                      clear usr8192.var1;
                      usr8192.var1 = ##field;
                      p_sndpgmmg('USR8192': usr8192: sds.pgmname);
                   endif;
                else;
                   exsr srchpoint;
                   exsr expandnum;
                   exsr chknumdata;
                endif;

                if *in99 = *on;
                   leave;
                endif;

                //  ... falsches Vorzeichen
                if (##sign <> set0003.set_signm and
                    ##sign <> set0003.set_signp);
                   *in99 = '1';
                   clear usr8141;
                   usr8141.var1 = set0003.set_signp;
                   usr8141.var2 = set0003.set_signm;
                   p_sndpgmmg('USR8141': usr8141: sds.pgmname);
                   leave;
                else;
                   //  ... richtiges Vorzeichen
                endif;

             else;
                //  Alpha-numerische Werte ...
                //  ... Vorzeichen
                ##sign = *blanks;
             endif;

          enddo;

          if *in99 = *on;
             *in22 = '1';
             *in32 = '1';
          endif;

       endsr;

       //============================================================*
       //    SignLeft      Prüfen extrahieren Vorzeichen links       *
       //============================================================*

       begsr signleft;

          //   Suchen erstes Zeichen <> *BLANKS ...
          x = %check(' ':r_arg30);
          if x = *zeros;
             //   Wenn nicht gefunden, dann ist nichts zu tun ...
          else;
             //   ansonsten das Zeichen extrahieren.
             //*   1             SUBST (P) R_Arg30:X     R_Sign
             r_sign = %subst(r_arg30: x: 1);
             //   Wenn das extrahierte Zeichen dem '+' oder '-'
             //   Zeichen entspricht, dann die Umsetzung vornehmen ...
             if r_sign = set0003.set_signm
                or r_sign = set0003.set_signp;
                ##sign = r_sign;
                x = x + 1;
                if x <= 30;
                   //*                 SUBST (P) R_Arg30:X     R_Arg30
                   r_arg30 = %subst(r_arg30: x);
                else;
                   r_arg30 = *blanks;
                endif;
             else;
                //   ... ansonsten ist nix zu tun.
             endif;
          endif;

       endsr;

       //============================================================*
       //    SignRight     Prüfen und umsetzen Vorzeichen rechts     *
       //============================================================*

       begsr signright;

          //   Suchen letztes Zeichen <> *BLANKS ...
          //*   ' '           CHECKR    R_Arg30       X
          x = %checkr(' ': r_arg30);
          if x = *zeros;
             //   Wenn nicht gefunden, dann ist nichts zu tun ...
          else;
             //   ansonsten das Zeichen extrahieren.
             //*   1             SUBST (P) R_Arg30:X     R_Sign
             r_sign = %subst(r_arg30: x: 1);
             //   Wenn das extrahierte Zeichen dem '+' oder '-'
             //   Zeichen entspricht, dann die Umsetzung vornehmen ...
             if r_sign = set0003.set_signm
                or r_sign = set0003.set_signp;
                ##sign = r_sign;
                x = x - 1;
                if x > *zeros;
                   //*   X             SUBST (P) R_Arg30:1     R_Arg30
                   r_arg30 = %subst(r_arg30: 1: x);
                else;
                   r_arg30 = *blanks;
                endif;
             else;
                //   ... ansonsten ist nix zu tun.
             endif;
          endif;

       endsr;

       //============================================================*
       //    SrchPoint     Prüfen und umsetzen Komma                 *
       //============================================================*

       begsr srchpoint;

          if f_isnumfld(fldl0100) = bFalse;
             //    keine Aufbereitung für nicht-numerische Daten
          else;

             //  Suchen nach Komma ...
             x = %scan(set0003.set_point: r_arg30);
             if x = *zeros;
                //   Wenn nicht gefunden, dann Länge +1 ...
                //*   ' '           CHECKR    R_Arg30       X
                x = %checkr(' ': r_arg30);
                x = x + 1;
             endif;

             //   ansonsten Vorkommastellen ...
             x = x - 1;
             if x > *zeros;
                //*   X             SUBST (P) R_Arg30:1     R_VorK
                r_vork = %subst(r_arg30: 1: x);
             else;
                r_vork = *blanks;
             endif;
             //   ... und Nachkommastellen extrahieren
             x = x + 2;
             if x <= 30;
                //*                 SUBST (P) R_Arg30:X     R_NachK
                r_nachk = %subst(r_arg30: x);
             else;
                r_nachk = *blanks;
             endif;

             //   Anzahl der Nachkommastellen auffüllen ...
             if fldl0100.f1decp <= 0;
                //   ... keine vorhanden
                r_nachk = *blanks;
             else;
                //   ... auffüllen
                for do_x2 = 1 to *hival;
                   //*   1             SUBST     R_NachK:F1DECPR_A1
                   r_a1 = %subst(r_nachk: fldl0100.f1decp: 1);

                   if r_a1 <> *blanks;
                      //*   F1DECP        SUBST (P) R_NachK       R_NachK
                      r_nachk = %subst(r_nachk: 1: fldl0100.f1decp);
                      leave;
                   endif;

                   r_nachk = r_nachk + '0';
                endfor;
             endif;

             //   Ganzzahl zusammenbauen ...
             r_arg30 = %trimr(r_vork) + r_nachk;
          endif;

       endsr;

       //============================================================*
       //    PRF23         Prüfen:  Anzahl Datensätze                *
       //============================================================*

       begsr prf23;

          dou ('1');

             if ##nbrs = *zeros;
                *in99 = '1';
                p_sndpgmmg('USR8125': '': sds.pgmname);
                leave;
             endif;

          enddo;

          if *in99 = *on;
             *in23 = '1';
             *in33 = '1';
          endif;

       endsr;

       //============================================================*
       //    PRF24         Prüfen:  Suchtyp                          *
       //============================================================*

       begsr prf24;

          dou ('1');

             if ##type <> 'N'
                and ##type <> 'R'
                and ##type <> 'U'
                and ##type <> 'P';
                *in99 = '1';
                clear usr8126;
                usr8126.var1 = ##type;
                p_sndpgmmg('USR8126': usr8126: sds.pgmname);
                leave;
             endif;

          enddo;

          if *in99 = *on;
             *in24 = '1';
             *in34 = '1';
          endif;

       endsr;

       //============================================================*
       //    PRF25         Prüfen:  case-sensitive                   *
       //============================================================*

       begsr prf25;

          dou ('1');

             if ##case <> bTrue
                and ##case <> bFalse;
                *in99 = '1';
                p_sndpgmmg('USR8133': '': sds.pgmname);
                leave;
             endif;

          enddo;

          if *in99 = *on;
             *in25 = '1';
             *in35 = '1';
          endif;

       endsr;

       //============================================================*
       //    C_EndPgm      F3/F12 - Programm beenden                 *
       //============================================================*

       begsr c_endpgm;

          p_rmvpgmmg(sds.pgmname);

          o_sgid = 'USR8100';

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
       //    C_Prompt      F4  - Prompt                              *
       //============================================================*

       begsr c_prompt;

          select;
          when scnfld = '##FIELD'
             or ##field = set0008.set_prmt;
             exsr pmt_field;
          other;
             p_sndpgmmg('USR8179': '': sds.pgmname);
             *in99 = bTrue;
          endsl;

       endsr;

       //============================================================*
       //    Pmt_Field     Prompt - Field                            *
       //============================================================*

       begsr pmt_field;

          peek37(i_dsp80: i_copyright: yfield
                : ymsgid: ymsgdta);

          if ymsgid = *blanks;
             ##field = yfield;
          else;
             p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
             ymsgid = '';
             ymsgdta = '';
             *in99 = bTrue;
          endif;

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
       //    FILL##        Füllen Bildschirm                         *
       //============================================================*

       begsr fill##;

          //  Wenn die Datei oder das Member gewechselt hat,
          if i_qfile <> r_qfile
             or i_member <> r_member;
             //  ... dann die Bildschirmfelder neu
             //      initialisieren.
             exsr initfield;
             r_qfile = i_qfile;
             r_member = i_member;
          else;
             //  ... sonst die Bildschirmfelder belassen
          endif;

          clear f_key;
          f_key.f_field = ##field;
          chain %kds(f_key) fpeekfld;
          if (not %found());
             clear fldl0100;
          else;
             fldl0100 = f_ffd;
          endif;

          //  Defaultoperationscode einsetzen ...
          if ##op = *blanks;
             ##op = 'EQ';
          else;
             //  Operationscode stehenlasen
          endif;

          //  Sonderwerte einsetzen ...
          select;
          when ##arg = *blanks;
             ##arg = '*BLANKS';
          when ##arg = *zeros;
             ##arg = '*ZEROS';
          other;
             // ... Umsetzung nicht erforderlich
          endsl;

          if (##nbrs = 0);
             ##nbrs = set0002.set_snbrs;
          else;
             //  Wert stehenlassen ...
          endif;

       endsr;

       //============================================================*
       //    InitField     Initialisieren der Bildschirmfelder       *
       //============================================================*

       begsr initfield;

          ##field = '';
          ##op = '';
          ##arg = '';
          ##sign = '';
          $$wldcd = set0002.set_wldcd;
          ##nbrs = 0;
          ##type = 'N';
          ##case = bFalse;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = '0';
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 6;
             zei = zei + 1;
             pos = 26;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 4;
             zei = zei + 3;
             pos = 7;
          endif;

          //  Prompt-Felder anzeigen ...
          if (set0008.set_dsppmt = bTrue);
             *in71 = '1';
          else;
             *in71 = '0';
          endif;

       endsr;

       //============================================================*
       //    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
       //============================================================*

       begsr getusrsetg;

          //  Attribute der Suchfunktion
          set0002 = f_getusrsg('*SEARCH'   );

          //  Attribute der Schlüsselaufbeeitung
          set0003 = f_getusrsg('*ACCESSKEY');

          //  *PROMPT
          set0008 = f_getusrsg('*PROMPT'   );

       endsr;

       //============================================================*
       //    TrimNum       Nullenunterdrückung für numerische Daten  *
       //============================================================*

       begsr trimnum;

          if f_isnumfld(fldl0100) = bFalse;
             //    keine Aufbereitung für nicht-numerische Daten
          else;

             x = %check('0':r_arg30);
             if (x > 0);
                r_arg30 = %subst(r_arg30: x);
             else;
                // Nur führende Nullen vorhanden
                r_arg30 = *blanks;
             endif;

             // Argument bestand nur aus führenden Nullen
             // oder nur aus *BLANKS ...
             if r_arg30 = *blanks;
                r_arg30 = '0';
             else;
                // keine Korrektur der Aufbereitung
                // erforderlich
             endif;

          endif;

       endsr;

       //============================================================*
       //    ChkNumData    auf gültige numerische Daten prüfen       *
       //============================================================*

       begsr chknumdata;

          if f_isnumfld(fldl0100) = bFalse;
             //    keine Prüfung für nicht-numerische Daten
          else;

             if (%check(NUMERIC_DIGITS: r_arg30) > 0);
                *in99 = bTrue;
                clear usr8138.var1;
                usr8138.var1 = ##field;
                p_sndpgmmg('USR8138': usr8138: sds.pgmname);
             endif;

          endif;

       endsr;

       //============================================================*
       //    ExpandNum     numerische Daten rechtsbündig setzen      *
       //============================================================*

       begsr expandnum;

          if f_isnumfld(fldl0100) = bFalse;
             //    keine Aufbereitung für nicht-numerische Daten
          else;

             x = %checkr(' ': r_arg30);
             x = 30 - x;
             if (x > 0);
                r_arg30 = f_space(x) +  r_arg30;
             else;
                // ... ist bereits rechtbündig
             endif;

             r_arg30 = %xlate(' ': '0': r_arg30);

          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Öffnen der Dateien
          open peekfld;
          open peek17fm;

          // - Benutzervoreinstellungen
          exsr getusrsetg;

          // - Füllen der Bildschirmfelder
          exsr fill##;

          // - Programm initialisieren
          p_rmvpgmmg(sds.pgmname);

          o_sgid = *blanks;
          o_msgdta = *blanks;

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

          if (isInzSr = bTrue);
             leavesr;
          endif;

          isInzSr = bTrue;

          PGMQ = '*';

          peek21_name = f_pgmcalln('PEEK21');
          peek23_name = f_pgmcalln('PEEK23');
          peek37_name = f_pgmcalln('PEEK37');

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

