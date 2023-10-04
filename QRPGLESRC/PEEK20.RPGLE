       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.1.0                               *
       //  Programm : PEEK20                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 27.10.97    Raddatz                               *
       //  geändert : 27.04.99    2.1.0                                 *
       //  geändert : 01.04.2004  2.2.2   Fixed problem that ybuffer    *
       //                                 was not cleared correclty     *
       //                                 for data/time/timestamp       *
       //                                 fields.                       *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Erstellen internen Aufsetzschlüssel                          *
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

       dcl-f peekfldl2 keyed usropn rename(fpeekfld:fpeekfldl2) prefix(f2)
             infds(peek_l2_ds);

       dcl-f peekfldl0 keyed usropn rename(fpeekfld:fpeekfldl0) prefix(f2)
             infds(peek_l0_ds);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,CEECNDHDLR
      /COPY QCOPYLE,ERR_D_SDS

      /define internal_prototype
      /COPY QCOPYLE,PPEEK20
      /undefine internal_prototype

      /COPY QCOPYLE,SET0003

      /COPY QCOPYLE,PPEEK18
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-ds peek_l0_ds qualified;
         p0file          char(10) pos(83);
         p0library       char(10);
         p0member        char(10) pos(129);
         p0rcdnbr        int(10) pos(397);
       end-ds;

       dcl-ds peek_l2_ds qualified;
         p2file          char(10) pos(83);
         p2library       char(10);
         p2member        char(10) pos(129);
         p2rcdnbr        int(10) pos(397);
       end-ds;

       //----------------------------------------------------*
       //  F E L D - D E F I N I T I O N E N                 *
       //----------------------------------------------------*

       dcl-ds yio_buff;
         yio_bufftb      char(1) dim(rcd_buff_len) inz;
       end-ds;

       dcl-s ybuffer         like(rcdbuf_t) inz;
       dcl-s ytgtvalue       char(10) inz(*blanks);
       dcl-s youtbuffer      like(rcdbuf_t) inz;
       dcl-s youtbuffln      like(int4_t) inz;
       dcl-s yMsgID          char(7) inz(*blanks);
       dcl-s yMsgDta         char(512) inz(*blanks);

       dcl-s x               like(int4_t) inz;
       dcl-s y               like(int4_t) inz;
       dcl-s inpkeylen       int(10) inz(-1);

       dcl-s bp              like(int4_t) inz;
       dcl-s kp              like(int4_t) inz;

       dcl-s peek18_name     like(pgmcalln_t) inz;

       dcl-s wrk_keyval      like(i_keyval) inz(*blanks);

       dcl-s dftval          char(30) inz(*blanks);
       dcl-s dftvallen       like(int4_t) inz;
       dcl-s idx             like(int4_t) inz;

       dcl-c §time_a const('00.00.00');
       dcl-c §date_a const('0001-01-01');
       dcl-c §tstmp_a const('0001-01-01-00.00.00.000000');

       dcl-c §time_d const('23.59.59');
       dcl-c §date_d const('9999-12-31');
       dcl-c §tstmp_d const('9999-12-31-23.59.59.999999');

       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-s isInzSr         like(bool_t) inz(bfalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek20;
         i_keyval        const like(keybuf_t);
         o_rcdbuffer     like(rcdbuf_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-ds f2key_l2 likerec(fpeekfldl2: *key);
       dcl-ds f1key_l0 likerec(fpeekfldl0: *key);
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       yio_bufftb(*) = '';
       bp = 1;
       kp = 1;

       select;
       when i_keyval = '*PHIVAL';
          wrk_keyval = '*HIVAL';
          exsr buildPseudoKey;

       when i_keyval = '*PLOVAL';
          wrk_keyval = '*LOVAL';
          exsr buildPseudoKey;

       when i_keyval = '*HIVAL';
          wrk_keyval = '*HIVAL';
          exsr buildKey;

       when i_keyval = '*LOVAL';
          wrk_keyval = '*LOVAL';
          exsr buildKey;

       other;
          inpkeylen = %len(%trimr(i_keyval));
          wrk_keyval = i_keyval;
          exsr buildKey;

       endsl;

       if (o_msgid = '');
          o_rcdbuffer = yio_buff;
       endif;

       return;

       //============================================================*
       //    BuildKey      Erstellen internen Aufsetzschlüssel       *
       //============================================================*

       begsr buildKey;

          clear f2key_l2;
          f2key_l2.f2kseq = 1;
          setll %kds(f2key_l2) fpeekfldl2;

          dow ('1');
             read fpeekfldl2;
             if (%eof());
                leave;
             endif;

             exsr intern;
             if (o_msgid <> '');
                leavesr;
             endif;

             if bp > rcd_buff_len;
                leave;
             endif;

             if (inpkeylen > 0 and kp > inpkeylen);
                wrk_keyval = '*LOVAL';
                inpkeylen = -1;
             endif;

          enddo;

       endsr;

       //============================================================*
       //    BuildPseud    Erstellen internes Satzformat             *
       //============================================================*

       begsr buildPseudoKey;

          clear f1key_l0;
          f1key_l0.f2fldseq = *zeros;
          setll %kds(f1key_l0) fpeekfldl0;

          dow ('1');
             read fpeekfldl0;
             if (%eof());
                leave;
             endif;

             exsr intern;
             if (o_msgid <> '');
                leavesr;
             endif;

             if (bp > rcd_buff_len);
                leave;
             endif;
          enddo;

       endsr;

       //============================================================*
       //    Intern        Formataufbereitung                        *
       //============================================================*

       begsr intern;

          fldl0100 = f2ffd;

          if (wrk_keyval = '*LOVAL' or wrk_keyval = '*HIVAL');
             ytgtvalue = wrk_keyval;
             clear ybuffer;
          else;
             ytgtvalue = '*CURRENT';

             select;
             when fldl0100.f1dtyp = 'S' or  // Zoned
                fldl0100.f1dtyp = 'B' or    // Binary
                fldl0100.f1dtyp = 'P';      // Packed
                y = fldl0100.f1digt;
             when fldl0100.f1dtyp = 'F';    // Float
                if fldl0100.f1flen = 4;
                   y = 14;
                else;
                   y = 23;
                endif;
             other;
                if (fldl0100.f1dtyp = 'G');
                   y = fldl0100.f1ndbc;
                else;
                   y = fldl0100.f1flen;
                endif;
             endsl;

             //  ... Länge +1 wegen nachgestelltem Vorzeichen
             //      grundsätzlich, ob mit oder ohne Vorzeichen
             //      Vorzeichen wird in PEEK18 ausgewertet
             if (f_isnumfld(fldl0100) = btrue);
                y = y + 1;
             endif;

             x = kp + y;
             x = x - 1;
             if (f_isvarlen(fldl0100) = btrue);
                x = x + 2;
                y = y - 2;
             endif;

             if (x <= key_buff_len);
                ybuffer = %subst(wrk_keyval:kp:y);
             else;
                ybuffer = %subst(wrk_keyval:kp);
             endif;

          endif;

          // ... Aufbereiten Datums-, Zeit- und
          //     Zeitstempelfelder
          select;
             // ... Time
          when fldl0100.f1dtyp = 'T';
             if (f2desc = 'D');
                dftval = §time_d;
                dftvallen = f_len(§time_d);
             else;
                dftval = §time_a;
                dftvallen = f_len(§time_a);
             endif;
             exsr chkvalue;
             // ... Date
          when fldl0100.f1dtyp = 'L';
             if (f2desc = 'D');
                dftval = §date_d;
                dftvallen = f_len(§date_d);
             else;
                dftval = §date_a;
                dftvallen = f_len(§date_a);
             endif;
             exsr chkvalue;
             // ... Timestamp
          when fldl0100.f1dtyp = 'Z';
             if (f2desc = 'D');
                dftval = §tstmp_d;
                dftvallen = f_len(§tstmp_d);
             else;
                dftval = §tstmp_a;
                dftvallen = f_len(§tstmp_a);
             endif;
             exsr chkvalue;
             // ... alle anderen Datentypen
          other;
             // werden nicht vorgeprüft
             // und vervollständigt
          endsl;

          peek18(fldl0100: f2format: ybuffer
                : '*INTERN': ytgtvalue
                : youtbuffer: youtbuffln
                : yMsgID: yMsgDta);
          if (yMsgID <> '');
             o_msgid = yMsgID;
             o_msgdta = yMsgDta;
             leavesr;
          endif;

          if f_isvarlen(fldl0100) = btrue;
             youtbuffln = youtbuffln + 2;
          endif;

          for y = 1 to youtbuffln;
             yio_bufftb(bp) = %subst(youtbuffer:y:1);
             bp = bp + 1;
             if bp > rcd_buff_len;
                leave;
             endif;
          endfor;

          if (bp > rcd_buff_len);
             // Puffer zu Ende
          else;
             //  Neue Startposition in Wrk_KeyVal
             if (f_isnumfld(fldl0100) = btrue) and
                (f_isfloatfld(fldl0100) = bfalse);
                // ... bei numerischen Werten
                kp = kp + fldl0100.f1digt;
                // ... wegen nachgestelltem Vorzeichen
                if set_signx <> bfalse;                                         // = bTrue
                   kp = kp + 1;
                else;
                   // keine Korrektur erforderlich
                endif;
             else;
                // ... bei alpha-numerischen Werten
                if (fldl0100.f1dtyp = 'G');
                   kp = kp + fldl0100.f1ndbc;
                else;
                   kp = kp + fldl0100.f1flen;
                endif;
             endif;
             if (f_isvarlen(fldl0100) = btrue);
                kp = kp - 2;
             endif;
          endif;

          // Delimeter ...
          if (set_dlmtr <> '');
             kp = kp + 1;
          else;
             // keine Korrektur erforderlich
          endif;

       endsr;

       //============================================================*
       //    ChkValue      Prüfen und vervollständigen Datums-,      *
       //                  Zeit- und Zeitstempelfelder               *
       //============================================================*

       begsr chkvalue;

          for idx = 1 to dftvallen;

             if (%subst(ybuffer: idx: 1) = ' ');
                %subst(ybuffer: idx: 1) = %subst(dftval: idx: 1);
             endif;

          endfor;

       endsr;

       //============================================================*
       //    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
       //============================================================*

       begsr getusrsetg;

          //  *ACCESSKEY
          set0003 = f_getusrsg('*ACCESSKEY');

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          o_rcdbuffer = '';
          o_msgid = '';
          o_msgdta = '';

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isInzSr = btrue);
             leavesr;
          endif;

          isInzSr = btrue;

          peek18_name = f_pgmcalln('PEEK18');

          open peekfldl0;
          open peekfldl2;

          exsr getusrsetg;

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

