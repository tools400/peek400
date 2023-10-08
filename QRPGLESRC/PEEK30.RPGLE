       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.5.0                               *
       //  Programm : PEEK30                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 03.11.97  Raddatz                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Lizenzprüfung                                                *
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

       dcl-f peek30fm workstn(*ext) usage(*input:*output)
             usropn infds(workstn);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,DS_WORKSTN
      /COPY QCOPYLE,D_COLORATR
      /COPY QCOPYLE,ERR_D_SDS
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK30
      /undefine internal_prototype

      /COPY QCOPYLE,USR8158
      /COPY QCOPYLE,USR9997

      /COPY QCOPYLE,PPEEK07
      /COPY QCOPYLE,PPEEK28
      /COPY QCOPYLE,PPEEK29

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-s usrspcdta       char(64) based(pspcptr);
       dcl-s ysrlnbrext      like(r_srlnbr );
       dcl-s ydateext        like(r_srldate);

       dcl-s yattrlen        like(int4_t);
       dcl-s yattrtyp        char(1);
       dcl-s yvalue          char(512);

       dcl-s ysysname        char(8);
       dcl-s ysysvers        char(6);
       dcl-s ysyssrlnbr      char(8);
       dcl-s ysrlnbrint      like(r_srlnbr );
       dcl-s ydateint        like(r_srldate);

       dcl-s r_srldata       char(20);
       dcl-s r_srlnbr        char(20);
       dcl-s r_srldate       char(20);

       //  Konvertierung HEX ==> DEC
       dcl-s r_dec           packed(30);
       dcl-s r_hex           like(r_srlnbr );
       dcl-s hex             char(1) dim(16);
       dcl-s zw1             packed(30);
       dcl-s exp             like(int4_t);
       dcl-s a1              char(1);
       dcl-s x               like(int4_t);
       dcl-s y               like(int4_t);

       //  DeadDate
       dcl-s zwint           packed(30);
       dcl-s zwext           packed(30);
       dcl-s deaddate        packed(8);

       //  Aktuelle Datum und Uhrzeit
       dcl-ds *N;
         currDatTim      zoned(14);
         currTime        zoned(6) overlay(currDatTim) inz;
         currDateFW      zoned(8) overlay(currDatTim:7) inz;
         currDayFW       zoned(2) overlay(currDateFW) inz;
         currMonFW       zoned(2) overlay(currDateFW:3) inz;
         currYearFW      zoned(4) overlay(currDateFW:5) inz;
       end-ds;

       dcl-ds *N;
         currdaterv      zoned(8);
         curryearrv      zoned(4) overlay(currdaterv) inz;
         currmonrv       zoned(2) overlay(currdaterv:5) inz;
         currdayrv       zoned(2) overlay(currdaterv:7) inz;
       end-ds;

       dcl-c btrueext const( 66);
       dcl-c bfalseext const(-55);
       dcl-c bshareext const(243);

       dcl-s iscompok        char(1) inz(bFalse);
       dcl-s isdateerr       char(1) inz(bFalse);
       dcl-s iswriteok       char(1) inz(bFalse);

       //  declarations for QUSCRTUS
       dcl-ds qusrspc likeds(qobj_t) inz;

       //  Programme
       dcl-s peek07_name     like(pgmcalln_t) inz;
       dcl-s peek28_name     like(pgmcalln_t) inz;
       dcl-s peek29_name     like(pgmcalln_t) inz;

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek30;
         i_dsp80         const like(dsp80_t);
         i_copyright     const like(copyrght_t);
         o_flag          like(int4_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       dcl-s do_x1           packed(7);

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       if iscompok = bFalse;
          //     Fehler in der Lizenz-Nr. ...
          if isdateerr = btrue;
             //     ... Datum abgelaufen
             //         ... Abfragen einer neuen LizenzNr.
             exsr getlicinf;
             if o_flag <> btrueext;
                //         ... wenn keine neue LizenzNr eingetragen
                //             worden ist, dann bFalse zurückliefern,
                //             damit kein weiterer Test möglich ist.
                open peek30fm;
                zei = zei + 4;
                pos = pos + 4;
                exfmt bild03;
                close peek30fm;
                o_flag = bfalseext;
             else;
                //         ... neue LizenzNr. wurde eingetragen
                //             Rückkehrcode in XFLag ist OK
             endif;
          else;
             //     ... Lizenzdaten abfragen
             exsr getlicinf;
          endif;
       else;
          //     Lizenznummer ist OK ...
          o_flag = btrueext;
       endif;

       return;

       //============================================================*
       //    GetLicInf     Abfragen der Lizenznummer                 *
       //============================================================*

       begsr getlicinf;

          // - Öffnen der Dateien
          open peek30fm;

          //  Löschen Lizenznummer
          ##licdata = *blanks;

          for do_x1 = 1 to *hival;

             //  Nachrichten anzeigen
             *in89 = '0';
             write msgctl;

             //  Anzeigen Bildschirm
             exfmt bild01;

             //  Nachrichten löschen
             p_rmvpgmmg(§§pgmname);

             //  Bezugszahlen löschen
             exsr bzoff1;

             //  Abfragen der Befehlstasten
             select;
                //  F9  - Ende
             when workstn.aid = k_f9;
                exsr c_endpgm;
                o_flag = bshareext;
                o_msgid = 'USR9997';
                usr9997.var1 = §yellow_r;
                usr9997.var2 = §white;
                o_msgdta = usr9997;
                leave;

                //  Datenfreigabe
             when workstn.aid = k_enter;
                exsr c_enter;
                if *in99 = *off;
                   o_flag = btrueext;
                   leave;
                endif;

             other;
                //  Falsche Taste gedrückt
                p_wrongkey(workstn.aid: §§pgmname);
                iter;
             endsl;

          endfor;

          // - Schließen der Dateien
          close peek30fm;

       endsr;

       //============================================================*
       //    C_EndPgm      Programm beenden                          *
       //============================================================*

       begsr c_endpgm;

          p_rmvpgmmg(§§pgmname);

       endsr;

       //============================================================*
       //    C_Enter       Datenfreigabe                             *
       //============================================================*

       begsr c_enter;

          exsr prfb1;

          if *in99 = *off;
             exsr wrtlicdata;
             if iswriteok = bFalse;
                *in99 = '1';
                p_sndpgmmg('USR8159': '': §§pgmname);
             else;
                zei = zei + 4;
                pos = pos + 4;
                exfmt bild02;
             endif;
          endif;

       endsr;

       //============================================================*
       //    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
       //============================================================*

       begsr bzoff1;

          //  DSPATR(PC)
          *in20 = '0';

          //  DSPATR(RI)
          *in30 = '0';

          //  Fehler
          *in99 = '0';

       endsr;

       //============================================================*
       //    PRFB1         Prüfen der Eingaben                       *
       //============================================================*

       begsr prfb1;

          dou ('1');

             exsr prf20;
             if (*in99 = bTrue);
                leave;
             endif;

          enddo;

       endsr;

       //============================================================*
       //    PRF20         Prüfen:  Lizenznummer                     *
       //============================================================*

       begsr prf20;

          dou ('1');

          if ##licdata = *blanks;
             clear usr8158;
             *in99 = '1';
             clear usr8158;
             usr8158.var1 = ##licdata;                                              // Liz.Nr.
             p_sndpgmmg('USR8158': usr8158: §§pgmname);
             leave;
          endif;

          r_srldata = ##licdata;
          exsr splittlic;
          ysrlnbrext = r_srlnbr;
          ydateext = r_srldate;

          exsr complicnbr;
          if iscompok = bFalse;
             clear usr8158;
             *in99 = '1';
             clear usr8158;
             usr8158.var1 = ##licdata;                                              // Liz.Nr.
             p_sndpgmmg('USR8158': usr8158: §§pgmname);
             leave;
          endif;

          enddo;

          if *in99 = *on;
             *in20 = '1';
             *in30 = '1';
          endif;

       endsr;

       //============================================================*
       //    Fill##        Abrufen der Lizenzdaten und füllen der    *
       //                  BIldschirmfelder                          *
       //============================================================*

       begsr fill##;

          iscompok = btrue;
          leavesr;

          //------------------------------------------*
          //  ... Existenzprüfung  UserSpace          *
          //------------------------------------------*
          if (not f_exist(
             qusrspc.name: qusrspc.lib: '*USRSPC'));
             exsr crtusrspc;
          endif;

          //------------------------------------------*
          //  ... einlesen der aktuellen Daten        *
          //      ( = YSrlNbrExt)                     *
          //------------------------------------------*
          exsr rtvusrspc;

          //------------------------------------------*
          //  ... vergleichen der Lizenzdaten         *
          //------------------------------------------*
          exsr complicnbr;

       endsr;

       //============================================================*
       //    CompLicNbr    Vergleichen der Lizenzdaten               *
       //============================================================*

       begsr complicnbr;

          //------------------------------------------*
          //  ... berechnen der Vergleichsserien-Nr.  *
          //      ( = YSrlNbrInt)                     *
          //      für normale Lizenznummer            *
          //------------------------------------------*
          iscompok = bFalse;
          isdateerr = btrue;

          exsr clcintnbr;
          exsr complicnb2;

          //------------------------------------------*
          //  ... berechnen der Vergleichsserien-Nr.  *
          //      ( = YSrlNbrInt)                     *
          //      für Firmenlizenznummer              *
          //------------------------------------------*
          if iscompok = bFalse;
             iscompok = bFalse;
             isdateerr = btrue;

             exsr clcintnbrf;
             exsr complicnb2;
          else;
             //    ... die Lizenznummer stimmt bereits
          endif;

       endsr;

       //============================================================*
       //    CompLicNb2    Vergleichen der Lizenzdaten 2             *
       //============================================================*

       begsr complicnb2;

          // -  interne Nummer umsetzen in Dezimalwert
          r_hex = ysrlnbrint;
          exsr hextodec;
          zwint = r_dec;

          // -  externe Nummer umsetzen in Dezimalwert
          r_hex = ysrlnbrext;
          exsr hextodec;
          zwext = r_dec;

          // -  externes Datum umsetzen in Dezimalwert
          r_hex = ydateext;
          exsr hextodec;
          deaddate = deaddate - r_dec + 99999999;

          // -  Angleichen externe Nummer
          zwext = zwext - r_dec;
          zwext = zwext + 99999999;

          //------------------------------------------*
          //  ... vergleichen interne & externe       *
          //      Seriennummer                        *
          //------------------------------------------*
          currTime = %dec(%char(%time(): *HMS0): 6: 0);
          currDateFW = %dec(%char(%date(): *EUR0): 8: 0);
          currdayrv = currDayFW;
          currmonrv = currMonFW;
          curryearrv = currYearFW;

          if zwext <> zwint;
             iscompok = bFalse;
             isdateerr = bFalse;
          else;
             if deaddate < currdaterv;
                iscompok = bFalse;
                isdateerr = btrue;
             else;
                iscompok = btrue;
                isdateerr = bFalse;
             endif;
          endif;

       endsr;

       //============================================================*
       //    CrtUsrSpc     Anlegen UserSpace                         *
       //============================================================*

       begsr crtusrspc;

          quscrtus(qusrspc: 'USRSPC': 64: x'00': '*ALL'
                  : 'Peek/400 Lizenzdaten');

       endsr;

       //============================================================*
       //    RtvUsrSpc     Einlesen UserSpace                        *
       //============================================================*

       begsr rtvusrspc;

          qusptrus(qusrspc: pspcptr);

          r_srldata = usrspcdta;
          exsr splittlic;
          ysrlnbrext = r_srlnbr;
          ydateext = r_srldate;

       endsr;

       //============================================================*
       //    SplittLic     Splitten der Lizenzdaten                  *
       //============================================================*

       begsr splittlic;

          x = %scan('-': r_srldata);
          if x > *zeros;
             x = x - 1;
             if x > *zeros;
                r_srlnbr = %subst(r_srldata: 1: x);
             else;
                r_srlnbr = *blanks;
             endif;

             x = x + 2;
             if x <= 64;
                r_srldate = %subst(r_srldata: x);
             else;
                r_srldate = *blanks;
             endif;
          else;
             r_srlnbr = *blanks;
             r_srldate = *blanks;
          endif;

       endsr;

       //============================================================*
       //    ClcIntNbr     Berechnen der internen Serien-Nr.         *
       //============================================================*

       begsr clcintnbr;

          // -  Netzwerkattribute
          peek07('SYSNAME': bFalse
                : yattrlen: yattrtyp: yvalue);
          if yattrlen > *zeros;
             ysysname = %subst(yvalue: 1: yattrlen);
          else;
             ysysname = *blanks;
          endif;

          // -  Version
          ysysvers = '010000';

          // -  Seriennummer
          peek28('QSRLNBR': bFalse
                : yattrlen: yattrtyp: yvalue);
          if yattrlen > *zeros;
             ysyssrlnbr = %subst(yvalue: 1: yattrlen);
          else;
             ysyssrlnbr = *blanks;
          endif;

          peek29(ysysname: '010000'
                : ysyssrlnbr: 0: r_srldata);

          exsr splittlic;
          ysrlnbrint = r_srlnbr;
          ydateint = r_srldate;

       endsr;

       //============================================================*
       //    ClcIntNbrF    Berechnen der internen Serien-Nr.         *
       //                  für eine Firmenlizenz                     *
       //============================================================*

       begsr clcintnbrf;

          peek29('*COMPANY': '999999'
                : '*LICENSE': 0: r_srldata);

          exsr splittlic;
          ysrlnbrint = r_srlnbr;
          ydateint = r_srldate;

       endsr;

       //============================================================*
       //    WrtLicData    Schreiben der Lizenzdaten                 *
       //============================================================*

       begsr wrtlicdata;

          usrspcdta = ##licdata;

       endsr;

       //============================================================*
       //    HexToDec      Konvertieren HEX ==> DEC                  *
       //============================================================*

       begsr hextodec;

          r_dec = *zeros;
          x = %checkr(' ':r_hex);

          for y = 1 to x;
             a1 = %subst(r_hex: y: 1);
             if a1 = *blanks;
                leave;
             endif;

             zw1 = 1;
             zw1 = %lookup(a1: hex);
             if (zw1 = 0);
                //      ... Umsetzung in Dezimalwert nicht gelungen
                iter;
             endif;

             zw1 = zw1 - 1;

             exp = x - y;
             if exp > *zeros;
                //      ... Exponenten größer 0
                dou exp = *zeros;
                   zw1 = zw1 * 16;
                   exp = exp - 1;
                enddo;

                r_dec = r_dec + zw1;
             else;
                //      ... Exponent = 0
                r_dec = r_dec + zw1;
             endif;

          endfor;

       endsr;

       //============================================================*
       //    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
       //============================================================*

       begsr setscreen;

          if i_dsp80 = '0';
             //   132-Zeichen Anzeige
             *in88 = '0';
             zei = 2;
             pos = 26;
          else;
             //    80-Zeichen Anzeige
             *in88 = '1';
             zei = 1;
             pos = 4;
          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Programm initialisieren
          p_rmvpgmmg(§§pgmname);

          // - Rückgabewerte
          o_flag = bfalseext;
          o_msgid = *blanks;
          o_msgdta = *blanks;

          // - Einlesen und prüfen der Lizenzdaten
          exsr fill##;

          // - Einstellen der Bildschirmauflösung 80/132-Zeichen
          exsr setscreen;

          // - Copyright
          p_sndpgmmg('USR9999': i_copyright: §§pgmname);

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

          peek07_name = f_pgmcalln('PEEK07');
          peek28_name = f_pgmcalln('PEEK28');
          peek29_name = f_pgmcalln('PEEK29');

          qusrspc.name = 'PEEKSRL';
          qusrspc.lib  = f_getprdlb();

          hex(1) = '0';
          hex(2) = '1';
          hex(3) = '2';
          hex(4) = '3';
          hex(5) = '4';
          hex(6) = '5';
          hex(7) = '6';
          hex(8) = '7';
          hex(9) = '8';
          hex(10) = '9';
          hex(11) = 'A';
          hex(12) = 'B';
          hex(13) = 'C';
          hex(14) = 'D';
          hex(15) = 'E';
          hex(16) = 'F';

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

