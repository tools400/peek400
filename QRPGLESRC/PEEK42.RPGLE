       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 1.4.0                               *
       //  Programm : PEEK42                                            *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 14.04.98  Raddatz                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  Verarbeiten einer Kurzauswahl                                *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Gültige Ersatzvariablen:                                     *
       //  ------------------------                                     *
       //     &L           - Bibliothek der geöffneten Datei            *
       //     &F           - Name der geöffneten Datei                  *
       //     &N           - Name der Teildatei                         *
       //     &R           - Relative Satznummer                        *
       //     % + Feldname - Wert des angegebenen Feldes                *
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

       // Aufbau des Satzformats
       dcl-f peekfld keyed usropn prefix(f_);

       dcl-ds io_buff;
         io_bufffld      like(rcdbuf_t);
       end-ds;

       dcl-s io_nullmap      like(nullmap_t) dim(null_map_size);

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,ShortCmd_d
      /COPY QCOPYLE,D_CLIB
      /COPY QCOPYLE,SDS
      /COPY QCOPYLE,CEECNDHDLR

      /define internal_prototype
      /COPY QCOPYLE,PPEEK42
      /undefine internal_prototype

      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK66

      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58
      /COPY QCOPYLE,PPEEK63

       dcl-pr lf_rtvfldname varchar(10);
         i_buffer        const  like(r_shortcmd  );
         i_startpos      const  like(int4_t);
       end-pr;

       dcl-pr lf_rtvfldformat like(bool_t);
         io_buffer       like(r_shortcmd  );
         i_startpos      const  like(int4_t);
         o_fldl0100      likeds(fldl0100_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pr;

       dcl-pr lf_loadfldatr char(1);
         i_fldname       char(10) const;
         o_fldl0100      likeds(fldl0100_t);
       end-pr;

       dcl-s isInit          like(bool_t) inz(bFalse);
       dcl-s isRecord        like(bool_t) inz(bFalse);

       dcl-s r_file          like(shortcmd_t.sc_file) inz;
       dcl-s r_lib           like(shortcmd_t.sc_lib) inz;
       dcl-s r_mbr           like(shortcmd_t.sc_mbr) inz;
       dcl-s r_shortcmd      like(o_execcmd  ) inz(*blanks);
       dcl-s r_cmd1          varchar(32702) inz(*blanks);
       dcl-s r_cmd2          varchar(32702) inz(*blanks);
       dcl-c r_maxlen const(256);
       dcl-s r_var           varchar(10) inz(*blanks);
       dcl-s r_value         varchar(32766) inz('');
       dcl-s s               like(int4_t) inz;
       dcl-s i               like(int4_t) inz;
       dcl-s fldname         varchar(10) inz(*blanks);
       dcl-s isoutformat     like(bool_t) inz(bFalse);
       dcl-ds shortcmd likeds(shortcmd_t) inz;
       dcl-ds fldl0100 likeds(fldl0100_t) inz;
       dcl-ds fldl0100_out likeds(fldl0100_t) inz;

       dcl-s peek06_name     like(pgmcalln_t) inz;
       dcl-s peek66_name     like(pgmcalln_t) inz;

       //  Parameterliste PEEK06
       dcl-s youtbuffer      like(rcdbuf_t);
       dcl-s youtbuffln      like(int4_t) inz;
       dcl-s ymsgid          like(msgid_t) inz(*blanks);
       dcl-s ymsgdta         like(msgdta_t) inz(*blanks);

       dcl-c NAME_PREFIX const('%');
       dcl-c cformat_start const('(');
       dcl-c cformat_end const(')');
       dcl-c cformat_delimiter
             const(',');

       // Für Einzelsatzzugriff
       dcl-ds hfile00  likeds(hfile_t);

       dcl-s isInzSr         like(bool_t) inz(bFalse);

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek42;
         i_file          const like(file_t);
         i_library       const like(lib_t);
         i_member        const like(mbr_t);
         i_rcdformat     const like(fmt_t);
         i_shortcmd      const like(shortcmd_t);
         i_rcdnbr        const like(rcdnbr_t);
         o_execcmd       like(cmdbuffer_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       exsr inzsr;

       exsr first;

       select;
          // Initialisierung
       when (shortcmd.sc_action = '*INIT');
          r_file = shortcmd.sc_file;
          r_lib = shortcmd.sc_lib;
          r_mbr = shortcmd.sc_mbr;
          isInit = bTrue;
          // Befehl
       when (shortcmd.sc_action = '*CMD');
          exsr buildcmd;
          //  Unbekannte Aktion
       other;
          p_kill('Unknown short command action: ' +
                shortcmd.sc_action);
       endsl;

       return;

       //============================================================*
       //    BuildCmd      Aufbereiten des auszuführenden Befehls    *
       //============================================================*

       begsr buildcmd;

          r_shortcmd = shortcmd.sc_cmd;

          if (isInit = bFalse);
             //  keine Initialisierung
          else;
             exsr rpl_file;
             exsr rpl_lib;
             exsr rpl_mbr;
             exsr rpl_rrn;
             exsr rpl_fldname;
          endif;

          o_execcmd = r_shortcmd;

       endsr;

       //============================================================*
       //    Rpl_File      Ersetzen der Ersatzvariablen &F           *
       //============================================================*

       begsr rpl_file;

          r_var   = '&F';
          r_value = %trimr(r_file);
          exsr rpl_var;

       endsr;

       //============================================================*
       //    Rpl_Lib       Ersetzen der Ersatzvariablen &L           *
       //============================================================*

       begsr rpl_lib;

          r_var   = '&L';
          r_value = %trimr(r_lib);
          exsr rpl_var;

       endsr;

       //============================================================*
       //    Rpl_Mbr       Ersetzen der Ersatzvariablen &N           *
       //============================================================*

       begsr rpl_mbr;

          r_var   = '&N';
          r_value = %trimr(r_mbr);
          exsr rpl_var;

       endsr;

       //============================================================*
       //    Rpl_Rrn       Ersetzen der Ersatzvariablen &R           *
       //============================================================*

       begsr rpl_rrn;

          r_var   = '&R';
          r_value = %trimr(%editc(i_rcdnbr: 'X'));
          exsr rpl_var;

       endsr;

       //============================================================*
       //    Rpl_FldName   Ersetzen der Ersatzvariablen %*           *
       //============================================================*

       begsr rpl_fldname;

          dou ('1');

             if cio_open(hfile00
                      : i_file
                      : i_library
                      : i_member
                      : ''
                      : 'rr, arrseq=Y, commit=N, +
                         nullcap=Y, riofb=Y, +
                         secure=Y') = bFalse;
                isRecord = bFalse;
                leave;
             endif;

             for i = 1 to %len(r_shortcmd);

                if %subst(r_shortcmd: i: 1) = NAME_PREFIX;

                   exsr readrcd;
                   if (isRecord = bFalse);
                      leave;
                   endif;

                   if (not %open(peekfld));
                      open peekfld;
                   endif;

                   fldname = lf_rtvfldname(r_shortcmd: i);
                   if (fldname <> '') and
                      (lf_loadfldatr(fldname: fldl0100) = bTrue);

                      monitor;
                         peek06(fldl0100: 'FLDL0100': io_buff
                               : bTrue: bTrue
                               : youtbuffer: youtbuffln
                               : ymsgid: ymsgdta);
                         *in99 = bFalse;
                      on-error;
                         *in99 = bTrue;
                      endmon;

                      isoutformat = lf_rtvfldformat(
                                      r_shortcmd
                                      : i+%len(%trimr(fldname))+1
                                      : fldl0100_out
                                      : ymsgid
                                      : ymsgdta);

                      if (ymsgid <> '');
                         o_msgid  = ymsgid;
                         o_msgdta = ymsgdta;
                         leave;
                      endif;

                      r_var = NAME_PREFIX + fldname;

                      if (isoutformat = bFalse);
                         r_value = %trimr(%subst(youtbuffer :
                                                1          :
                                                youtbuffln ));
                      else;
                         monitor;
                            peek66(youtbuffer: youtbuffln
                                  : fldl0100: fldl0100_out
                                  : ymsgid: ymsgdta);
                            *in99 = bFalse;
                         on-error;
                            *in99 = bTrue;
                         endmon;

                         if (ymsgid <> '');
                            o_msgid  = ymsgid;
                            o_msgdta = ymsgdta;
                            leave;
                         endif;

                         r_value = %subst(youtbuffer: 1: youtbuffln);
                      endif;

                      r_shortcmd =
                        %replace(r_value: r_shortcmd: i: %len(r_var));
                   endif;

                endif;

             endfor;

          enddo;

          if cio_isopen(hfile00) = bTrue;
             cio_close(hfile00);
          endif;

          if %open(peekfld);
             close peekfld;
          endif;

       endsr;

       //============================================================*
       //    Rpl_Var       Ersetzen der Ersatzvariablen              *
       //============================================================*

       begsr rpl_var;

          s = 1;

          dou s = 0;

             s = %scan(r_var: r_shortcmd: s);
             if s = *zeros;
                //  Nix gefunden ...
             else;
                //  Variable ersetzen ...
                //  ... extrahieren 1. Teil
                s = s - 1;
                if (s <= 0);
                   r_cmd1 = '';
                else;
                   r_cmd1 = %subst(r_shortcmd: 1: s);
                endif;

                //  ... extrahieren 2. Teil
                s = s + 1 + %len(r_var);
                if s > r_maxlen;
                   r_cmd2 = '';
                else;
                   r_cmd2 = %trimr(%subst(r_shortcmd: s));
                endif;

                //  ... zusammenführen Teil 1, Variable und Teil 2
                r_shortcmd = r_cmd1 + r_value + r_cmd2;

             endif;

          enddo;

       endsr;

       //============================================================*
       //    ReadRcd       Einlesen des anzuzeigenden Satzes         *
       //============================================================*

       begsr readrcd;

          if cio_chainwithrrn(hfile00
                           : i_rcdnbr
                           : bFalse
                           : io_buff
                           : io_nullmap) = bFalse;
             isRecord = bFalse;
          else;
             isRecord = bTrue;
          endif;

       endsr;

       //============================================================*
       //    First         Initialisierung                           *
       //============================================================*

       begsr first;

          // - Programm initialisieren
          //**                Callp     p_rmvPgmMg(sds.pgmName)

          o_msgid = *blanks;
          o_msgdta = *blanks;

          shortcmd = i_shortcmd;

       endsr;

       //====================================================*
       //  InzSr --  Initialize program                      *
       //====================================================*

       begsr inzsr;

          if (isInzSr = bTrue);
             leavesr;
          endif;

          isInzSr = bTrue;

          isInit = bFalse;

          peek06_name = f_pgmcalln('PEEK06');
          peek66_name = f_pgmcalln('PEEK66');

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

       //============================================================*
       //    Ermitteln Feldname aus Kurzbefehl                       *
       //============================================================*
       dcl-proc lf_rtvfldname;
       dcl-pi *N              varchar(10);
         i_buffer        const  like(r_shortcmd  );
         i_startpos      const  like(int4_t);
       end-pi;

       //  Funktionswert
       dcl-s fldname         char(10) inz;

       //  Arbeitsfelder
       dcl-s i               like(int4_t) inz;

       //  Gültige Zeichen für Feldnamen
       dcl-c VALID_CHARS const('_$#§ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890');
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       fldname = '';

       for i = i_startpos + 1 to %len(i_buffer);
          if %scan(%subst(i_buffer: i: 1): VALID_CHARS) = 0;
             leave;
          endif;

          fldname = %trimr(fldname) +
                   %subst(i_buffer: i: 1);
       endfor;

       return %trimr(fldname);

       end-proc;

       //============================================================*
       //    Ermitteln Feldformat                                    *
       //============================================================*
       dcl-proc lf_rtvfldformat;
       dcl-pi *N        like(bool_t);
         io_buffer       like(r_shortcmd  );
         i_startpos      const  like(int4_t);
         o_fldl0100      likeds(fldl0100_t);
       o_msgid         like(msgid_t);
       o_msgdta        like(msgdta_t);
       end-pi;

       //  Arbeitsfelder
       dcl-s s               like(int4_t) inz;
       dcl-s e               like(int4_t) inz;
       dcl-s l               like(int4_t) inz;
       dcl-s strformat       char(256) inz;
       dcl-ds data qualified inz;
         type            char(1);
         length          int(10);
         decpos          int(10);
       end-ds;
       dcl-s ptoken          pointer inz;
       dcl-ds fldl0100_tmp likeds(fldl0100_t) inz;

       //  Nachrichten
      /COPY QCOPYLE,USR8228
      /COPY QCOPYLE,USR8229
      /COPY QCOPYLE,USR8230
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       clear o_fldl0100;
       clear o_msgid;
       clear o_msgdta;

       if (i_startpos > %len(io_buffer) or
           %subst(io_buffer: i_startpos: 1) <> cformat_start);
          return bfalse;
       endif;

       // Find end of format definition
       s = i_startpos;
       e = s;
       l = 0;

       dow (e <= %len(io_buffer));
          if (%subst(io_buffer: e: 1) = cformat_end);
             l = e - s + 1;
             leave;
          else;
             e = e + 1;
          endif;
       enddo;

       // Get format without leading and trailing parenthesis
       strformat = %subst(io_buffer: s+1: l-2);

       if (strformat = '');
          return bfalse;
       endif;

       // Remove format definition from buffer
       io_buffer = %replace('': io_buffer: s: l);

       // Splitt format into data type, length and decimal positions
       ptoken = strtok(strformat: cformat_delimiter);
       if (ptoken <> *null);            // data type
          data.type = %str(ptoken);
          ptoken = strtok(*null: cformat_delimiter);
       endif;

       if (ptoken <> *null);            // field length
          monitor;
             data.length = %dec(%str(ptoken): 10: 0);
          on-error;
             clear usr8229;
             usr8229.var1 = %str(ptoken);
             o_msgid  = 'USR8229';
             o_msgdta = usr8229;
             return bfalse;
          endmon;
          ptoken = strtok(*null: cformat_delimiter);
       endif;

       if (ptoken <> *null);            // decimal positions
          monitor;
             data.decpos = %dec(%str(ptoken): 10: 0);
          on-error;
             clear usr8230;
             usr8230.var1 = %str(ptoken);
             o_msgid  = 'USR8230';
             o_msgdta = usr8230;
             return bfalse;
          endmon;
       endif;

       // Compose new field type
       if lf_loadfldatr(fldname: fldl0100_tmp) = bfalse;
          return bfalse;
       endif;

       fldl0100_tmp.f1dtyp = %xlate(clower: cupper: data.type);
       if (f_isnotalw(fldl0100_tmp) = btrue);
          clear usr8228;
          usr8228.var1 = data.type;
          o_msgid  = 'USR8228';
          o_msgdta = usr8228;
          return bfalse;
       endif;

       // Check data type
       if (f_isnotalw(fldl0100_tmp) = btrue);
          return bfalse;
       endif;

       // Replace length and decimal position
       if (f_isnumfld(fldl0100) = btrue);
          fldl0100_tmp.f1decp = data.decpos;
          select;
          when (fldl0100_tmp.f1dtyp = 'S');
             fldl0100_tmp.f1digt = data.length;
             fldl0100_tmp.f1flen = data.length;
          when (fldl0100_tmp.f1dtyp = 'P');
             fldl0100_tmp.f1digt = data.length;
             fldl0100_tmp.f1flen = %int(data.length / 2);
             if (%rem(data.length: 2) <> 0);
                fldl0100_tmp.f1flen = fldl0100_tmp.f1flen + 1;
             endif;
          when (fldl0100_tmp.f1dtyp = 'B' or fldl0100_tmp.f1dtyp = 'I');
             select;
             when (data.length <= 3);
                fldl0100_tmp.f1digt = 3;
                fldl0100_tmp.f1flen = 1;
             when (data.length <= 5);
                fldl0100_tmp.f1digt = 5;
                fldl0100_tmp.f1flen = 2;
             when (data.length <= 10);
                fldl0100_tmp.f1digt = 10;
                fldl0100_tmp.f1flen = 4;
             when (data.length <= 20);
                fldl0100_tmp.f1digt = 20;
                fldl0100_tmp.f1flen = 8;
             endsl;
          when (fldl0100_tmp.f1dtyp = 'F');
             if (data.decpos <> 0);
                clear usr8230;
                usr8230.var1 = %char(data.decpos);
                o_msgid  = 'USR8230';
                o_msgdta = usr8230;
                return bfalse;
             endif;
             select;
             when (data.length = 4);
                fldl0100_tmp.f1digt = 8;
                fldl0100_tmp.f1flen = 4;
                fldl0100_tmp.f1decp = 7;
             when (data.length = 8);
                fldl0100_tmp.f1digt = 16;
                fldl0100_tmp.f1flen = 8;
                fldl0100_tmp.f1decp = 15;
             other;
                clear usr8229;
                usr8229.var1 = %char(data.length);
                o_msgid  = 'USR8229';
                o_msgdta = usr8229;
                return bfalse;
             endsl;
          endsl;
       else;
          fldl0100_tmp.f1flen = data.length;
       endif;

       // Replace start position
       fldl0100_tmp.f1obuf = 1;
       fldl0100_tmp.f1ibuf = 1;

       o_fldl0100 = fldl0100_tmp;

       return btrue;


       end-proc;

       //============================================================*
       //    Laden Feldattribute                                     *
       //============================================================*
       dcl-proc lf_loadfldatr;
       dcl-pi *N              char(1);
         i_fldname       char(10) const;
         o_fldl0100      likeds(fldl0100_t);
       end-pi;

       //  Funktionswert
       dcl-s isloaded        char(1) inz(bfalse);

       //  Arbeitsfelder
       dcl-ds fldl0100 likeds(fldl0100_t) inz;

       dcl-ds f_key likerec(fpeekfld: *key);
       // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

       clear f_key;
       f_key.f_field = i_fldname;
       chain %kds(f_key) fpeekfld;
       if (%found(peekfld));
          fldl0100 = f_ffd;
          isloaded = btrue;
       else;
          clear fldl0100;
          isloaded = bfalse;
       endif;

       o_fldl0100 = fldl0100;

       return isloaded;

       end-proc;

