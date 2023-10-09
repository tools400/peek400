       //===============================================================*
       //                                                               *
       //  (c) Thomas Raddatz                                           *
       //                                                               *
       //  Bereich  : PEEK, Version 2.0.0                               *
       //  Programm : PEEK051                                           *
       //  Typ      : RPG                                               *
       //                                                               *
       //  erstellt : 15.03.99  Raddatz                                 *
       //                                                               *
       //===============================================================*
       //                                                               *
       //  Kurzdokumentation :                                          *
       //                                                               *
       //  SQL-Komponente                                               *
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
       ctl-opt nomain;
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

      /COPY QCOPYLE,D_CLIB
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,FLDL0100

      /COPY QCOPYLE,PPEEK51
      /COPY QCOPYLE,PPEEK53
      /COPY QCOPYLE,PPEEK58
      /COPY QCOPYLE,PPEEK63

       dcl-pr f_isSqlErr      char(1);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pr;

       dcl-pr f_sqlMsgID      char(7);
         i_sqlCode        int(10) const;
       end-pr;

       dcl-pr p_cvtSqlMg;
         i_tomsgid       char(7) const;
         io_msgid        like(msgid_t);
         io_msgdta       like(msgdta_t);
       end-pr;

       dcl-pr f_getField      char(512);
         i_sqlorder      char(512) const;
       end-pr;

       dcl-pr f_chgField      char(512);
         i_string        char(512) const;
         i_rmvorder      char(1) const;
       end-pr;

       //  ... Execute Command (QCMDEXC) API
       dcl-pr qcmdexc
              extpgm('QCMDEXC');
         i_cmd           char(32702) const  options(*varsize);
         i_length        packed(15:5) const;
       end-pr;

       // Für Sortierung nach relativer Satznummer
       dcl-ds g_hfile03 likeds(hfile_t) inz;

       dcl-s g_file          char(10) inz;
       dcl-s g_lib           char(10) inz;
       dcl-s g_mbr           char(10) inz;
       dcl-s g_fmt           char(10) inz;

       dcl-s g_cmdovrdbf     varchar(512) inz;

       //===================================================================*
       //  Prozedur:  SQL_prepareStatement                       (Body)     *
       //===================================================================*

       dcl-proc SQL_prepareStatement export;
       dcl-pi *N        like(bool_t);
         i_check         value  like(bool_t);
         i_file          value  like(file_t);
         i_lib           value  like(lib_t);
         i_mbr           value  like(mbr_t);
         i_fmt           value  like(rcdfmt_t);
         i_sqlselct      char(512) value;
         i_sqlorder      char(512) value;
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_prepstmt      char(1);

       dcl-s i               int(10) inz;                                       // !
       dcl-s sqlselectstmt   like(sqlstmt_t) inz;
       dcl-s sqlcountstmt    like(sqlstmt_t) inz;

       dcl-s pfile           like(file_t) inz;
       dcl-s plib            like(lib_t) inz;
       dcl-s pmbr            like(mbr_t) inz;
       dcl-s pfmt            like(rcdfmt_t) inz;

       // ------------------------------------------------------------------------

       //**                If         f_basedPF(i_file: i_lib: i_mbr: i_fmt: -1
       //**                                     : pFile: pLib: pMbr: pFmt) = bTrue
       //                  go ahead ...
       //**                Else
       pfile = i_file;
       plib  = i_lib;
       pmbr  = i_mbr;
       pfmt  = i_fmt;
       //**                Endif

       //  ovrDbf
       g_cmdovrdbf = 'OVRDBF FILE(FILE03)'       +
                    ' TOFILE('                  +
                    %trim(plib )                +
                    '/'                         +
                    %trim(pfile)                +
                    ')'                         +
                    ' MBR('                     +
                    %trim(pmbr)                 +
                    ')'                         +
                    ' OVRSCOPE(*CALLLVL)'       +
                    ' SHARE(*NO)'               +
                    ' SECURE(*YES)'             +
                    ' SEQONLY(*NO)';
       qcmdexc(g_cmdovrdbf: %len(g_cmdovrdbf));

       //  Statement ...
       sqlselectstmt = 'SELECT'                  +
                      ' RRN(T3)';

       //  ... plus Datei
       sqlselectstmt = %trim(sqlselectstmt)      +
                      ' FROM'                   +
                      ' ' + %trim('FILE03')     +
                      ' T3';

       //  ... plus SELECT
       if i_sqlselct <> ' ';
          sqlselectstmt = %trim(sqlselectstmt)      +
                         ' WHERE'                  +
                         ' ' + %trim(i_sqlselct);
       endif;

       //  ... erzeugen COUNT(*) Anweisung
       i = %scan('RRN(T3)': sqlselectstmt);
       sqlcountstmt =
         %replace('COUNT(*)': sqlselectstmt
                  : i: %len('RRN(T3)'));

       //  ... plus ORDER BY
       if i_sqlorder <> ' ';
          sqlselectstmt = %trim(sqlselectstmt)      +
                         ' ORDER BY'               +
                         ' ' + %trim(i_sqlorder);
       endif;

       // SQL-STATEMENT VORBEREITEN
       if i_check = btrue;
          EXEC SQL
           prepare g_chkstmt from :sqlselectstmt;
       else;
          EXEC SQL
           prepare g_prepselectstmt from :sqlselectstmt;
          if (f_isSqlErr(o_msgid :
                      o_msgdta) = bfalse);
             EXEC SQL
              prepare g_prepcountstmt from :sqlcountstmt;
          endif;
       endif;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);
          f_prepstmt = bfalse;
          g_file = ' ';
          g_lib  = ' ';
          g_mbr  = ' ';
          g_fmt  = ' ';

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

       else;
          f_prepstmt = btrue;
          g_file = i_file;
          g_lib  = i_lib;
          g_mbr  = i_mbr;
          g_fmt  = i_fmt;
       endif;

       return f_prepstmt;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_open                                   (Body)     *
       //===================================================================*

       dcl-proc SQL_open export;
       dcl-pi *N        like(bool_t);
         o_hfile         likeds(hfile_t);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_opnsql        like(bool_t) inz(bfalse);
       // ------------------------------------------------------------------------

       //  ovrDbf
       callp qcmdexc(g_cmdovrdbf: %len(g_cmdovrdbf));

       // CURSOR fileSQL DEKLARIEREN
       if (sqlCode >= 0);
          EXEC SQL
           declare g_filesql scroll cursor for g_prepselectstmt;
       endif;


       // CURSOR CS ÖFFNEN
       if (sqlCode >= 0);
          EXEC SQL
           open g_filesql;
       endif;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
          cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);

          f_opnsql = bfalse;
       else;
          if cio_open(g_hfile03
                   : g_file
                   : g_lib
                   : g_mbr
                   : g_fmt
                   : 'rr, arrseq=N, commit=N, +
                      nullcap=Y, riofb=Y, +
                      secure=Y') = btrue;
             *in99 = *off;
          else;
             *in99 = *on;
          endif;

          if *in99 = *on;
             f_opnsql = bfalse;
          else;
             f_opnsql = btrue;
          endif;
       endif;

       //  Setzen Rückgabeparameter
       o_hfile = g_hfile03;

       return f_opnsql;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_nextRow                                (Body)     *
       //===================================================================*

       dcl-proc SQL_nextRow export;
       dcl-pi *N        like(bool_t);
         o_buffer       like(rcdbuf_t);
         o_nullmap      like(nullmap_t) dim(null_map_size);
         o_hfile        likeds(hfile_t);
         o_msgid        like(msgid_t);
         o_msgdta       like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s iseof           like(bool_t) inz(btrue);

       //  definieren lokale Variablen ...
       dcl-s recnbr          int(10);

       dcl-ds io_buff based(ptrbuffer);
         io_bufffld      like(rcdbuf_t);
       end-ds;

       dcl-s io_nullmap      like(nullmap_t) dim(null_map_size)
       based(ptrnullmap);
       // ------------------------------------------------------------------------
       ptrbuffer = %addr(o_buffer );
       ptrnullmap= %addr(o_nullmap);

       // GET NEXT ROW
       EXEC SQL
        fetch next from g_filesql into :recnbr;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
          cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);
          iseof = btrue;

       else;

          if (sqlCode = 100);
             cio_seteof_read(g_hfile03);
          else;

             if cio_chainwithrrn(g_hfile03
                              : recnbr
                              : btrue
                              : io_buff
                              : io_nullmap) = bfalse;
                iseof = btrue;
             else;
                iseof = bfalse;
             endif;

          endif;

       endif;

       //  Setzen Rückgabeparameter
       o_hfile = g_hfile03;

       return iseof;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_previousRow                            (Body)     *
       //===================================================================*

       dcl-proc SQL_previousRow export;
       dcl-pi *N        like(bool_t);
         o_buffer        like(rcdbuf_t);
         o_nullmap       like(nullmap_t)
              dim(null_map_size);
         o_hfile         likeds(hfile_t);
       o_msgid         like(msgid_t);
       o_msgdta        like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s iseof           like(bool_t) inz(btrue);

       //  definieren lokale Variablen ...
       dcl-s recnbr          int(10);

       dcl-ds io_buff based(ptrbuffer);
         io_bufffld      like(rcdbuf_t);
       end-ds;

       dcl-s io_nullmap      like(nullmap_t) dim(null_map_size)
       based(ptrnullmap);
       // ------------------------------------------------------------------------
       ptrbuffer = %addr(o_buffer );
       ptrnullmap= %addr(o_nullmap);

       // GET NEXT ROW
       EXEC SQL
        fetch prior from g_filesql into :recnbr;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
          cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);
          iseof = btrue;

       else;

          if (sqlCode = 100);
             cio_seteof_readp(g_hfile03);
          else;

             if cio_chainwithrrn(g_hfile03
                              : recnbr
                              : btrue
                              : io_buff
                              : io_nullmap) = bfalse;
                iseof = btrue;
             else;
                iseof = bfalse;
             endif;

          endif;

       endif;

       //  Setzen Rückgabeparameter
       o_hfile = g_hfile03;

       return iseof;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_gotoTop                                (Body)     *
       //===================================================================*

       dcl-proc SQL_gotoTop export;
       dcl-pi *N        like(bool_t);
         o_msgid        like(msgid_t);
         o_msgdta       like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_toprow        like(bool_t) inz(bfalse);

       // ------------------------------------------------------------------------

       // POSITION BEFORE FIRST ROW
       EXEC SQL
        fetch before from g_filesql;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

          f_toprow = bfalse;
       else;
          f_toprow = btrue;
       endif;

       return f_toprow;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_gotoBottom                             (Body)     *
       //===================================================================*

       dcl-proc SQL_gotoBottom export;
       dcl-pi *N        like(bool_t);
         o_msgid        like(msgid_t);
         o_msgdta       like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_botrow        like(bool_t) inz(bfalse);

       // ------------------------------------------------------------------------

       // POSITION BEFORE FIRST ROW
       EXEC SQL
        fetch last   from g_filesql;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

          f_botrow = bfalse;
       else;
          f_botrow = btrue;
       endif;

       return f_botrow;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_close                                  (Body)     *
       //===================================================================*

       dcl-proc SQL_close export;
       dcl-pi *N        like(bool_t);
         o_hfile        likeds(hfile_t);
         o_msgid        like(msgid_t);
         o_msgdta       like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_clssql        like(bool_t) inz(bfalse);

       // ------------------------------------------------------------------------

       // CURSOR CS SCHLIEßEN
       EXEC SQL
        close g_filesql;

       // PRÜFUNG AUSWERTEN
       if (f_isSqlErr(o_msgid :
                   o_msgdta) = btrue);

          p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

          f_clssql = bfalse;
       else;
          if cio_close(g_hfile03) = btrue;
             *in99 = '0';
          else;
             *in99 = '1';
          endif;

          if *in99 = *on;
             f_clssql = bfalse;
          else;
             f_clssql = btrue;
             g_file = ' ';
             g_lib  = ' ';
             g_mbr  = ' ';
          endif;
       endif;

       //  Setzen Rückgabeparameter
       o_hfile = g_hfile03;

       return f_clssql;

       end-proc;

       //===================================================================*
       //  Prozedur:  SQL_count                                  (Body)     *
       //===================================================================*

       dcl-proc SQL_count export;
       dcl-pi *N              int(10);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_count         int(10) inz;

       //  definieren Arbeitsfelder
       dcl-s msgid           like(msgid_t) inz;
       dcl-s msgdta          like(msgdta_t) inz;
       // ------------------------------------------------------------------------

       //  ovrDbf
       callp(e) qcmdexc(g_cmdovrdbf: %len(g_cmdovrdbf));

       // CURSOR fileSQL DEKLARIEREN
       EXEC SQL
        declare g_countsql scroll cursor for g_prepcountstmt;

       // CURSOR CS ÖFFNEN
       EXEC SQL
        open g_countsql;

       if (f_isSqlErr(msgid: msgdta) = btrue);
          return -1;
       endif;

       // GET FIRST ROW
       EXEC SQL
        fetch first from g_countsql into :f_count;

       if (f_isSqlErr(msgid: msgdta) = btrue);
          return -1;
       endif;

       // CURSOR CS SCHLIEßEN
       EXEC SQL
        close g_countsql;
       if (f_isSqlErr(msgid: msgdta) = btrue);
          return -1;
       endif;

       return f_count;

       end-proc;

       //===================================================================*
       //  Prozedur:  f_isSqlErr                                 (Body)     *
       //===================================================================*

       dcl-proc f_isSqlErr;
       dcl-pi *N              char(1);
         o_msgid         like(msgid_t);
         o_msgdta        like(msgdta_t);
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_issqlerr      char(1);

       //  lokale variablen ...

       // ------------------------------------------------------------------------
       if (sqlCode >= 0);
          o_msgid  = ' ';
          o_msgdta = ' ';
          f_issqlerr = bfalse;
       else;
          o_msgid  = f_sqlMsgID(sqlCode);
          o_msgdta = %subst(sqlerm: 1: sqlerl);
          f_issqlerr = btrue;
       endif;

       return f_issqlerr;

       end-proc;

       //===================================================================*
       //  Prozedur:  f_sqlMsgID                                 (Body)     *
       //===================================================================*

       dcl-proc f_sqlMsgID;
       dcl-pi *N char(7);
         i_sqlCode   int(10) const;
       end-pi;

       //  definieren Funktionswert ...
       dcl-s sqlMsgID char(7);

       //  lokale variablen ...
       dcl-ds ds_sqlCode qualified;
         sqlCode  zoned(10) inz;
         msgID    char(7) overlay(sqlCode: 4);
       end-ds;

       dcl-s idx       int(10);
       dcl-c SQL0000   'SQL0000';

       // ------------------------------------------------------------------------

       ds_sqlCode.sqlCode = i_sqlCode * -1;

       for idx = 1 to 7;
          if %subst(ds_sqlCode.msgID: idx: 1) = '0';
             %subst(ds_sqlCode.msgID: idx: 1) = %subst(SQL0000: idx: 1);
          else;
             leave;
          endif;
       endfor;

       sqlMsgID = ds_sqlCode.msgID;

       return sqlMsgID;

       end-proc;

       //===================================================================*
       //  Prozedur:  p_cvtSqlMg                                 (Body)     *
       //===================================================================*

       dcl-proc p_cvtSqlMg;
       dcl-pi *N;
         i_tomsgid       char(7) const;
         io_msgid        like(msgid_t);
         io_msgdta       like(msgdta_t);
       end-pi;

      /COPY QCOPYLE,RTVM0100

      /COPY QCOPYLE,USR8210
       // ------------------------------------------------------------------------

       clear usr8210;
       usr8210.var1 = io_msgid;
       usr8210.var2 = f_msgtext(io_msgid : io_msgdta:
                             'QSQLMSG': 'QSYS'   );

       io_msgid = 'USR8210';
       io_msgdta = usr8210;

       return;

       end-proc;

       //===================================================================*
       //  Prozedur:  f_getField                                 (Body)     *
       //===================================================================*

       dcl-proc f_getField;

       //  definieren Procedure Interface ...
       dcl-pi f_getField      char(512);
         i_sqlorder      char(512) const;
       end-pi;
       // ------------------------------------------------------------------------

       return f_chgField(i_sqlorder: btrue);

       end-proc f_getField;

       //===================================================================*
       //  Prozedur:  SQL_quote                                  (Body)     *
       //===================================================================*

       dcl-proc SQL_quote export;
       dcl-pi *N              char(512);
         i_string        char(512) const;
       end-pi;
       // ------------------------------------------------------------------------

       return f_chgField(i_string: bfalse);

       end-proc;

       //===================================================================*
       //  Prozedur:  f_chgField                                 (Body)     *
       //===================================================================*

       dcl-proc f_chgField;
       dcl-pi *N              char(512);
         i_string        char(512) const;
         i_rmvorder      char(1) const;
       end-pi;

       //  definieren Funktionswert ...
       dcl-s f_chgfield      char(512);

       dcl-s x               like(int4_t) inz;
       dcl-s y               like(int4_t) inz;
       dcl-s lenstr          like(int4_t) inz;

       dcl-s ishyphen        char(1) inz;
       dcl-s isfield         char(1) inz;
       dcl-s isorder         char(1) inz;

       dcl-s waitfield       char(1) inz;
       dcl-s waitorder       char(1) inz;
       // ------------------------------------------------------------------------

       y = 0;
       lenstr = f_len(i_string);

       ishyphen  = bfalse;
       isfield   = bfalse;
       isorder   = bfalse;

       waitfield = btrue;
       waitorder = bfalse;

       for x = 1 to lenstr;
          if y = f_len(f_chgfield);
             leave;
          endif;

          //  Prüfen auf Hochkomma ...
          if (%subst(i_string: x: 1) = '"')  or
             (%subst(i_string: x: 1) = '''');
             if ishyphen = btrue;
                ishyphen = bfalse;
             else;
                ishyphen = btrue;
             endif;
          endif;

          //  Überlesen in Hochkomma eingeschlossene Felder ...
          if (ishyphen = btrue)      and
             (isfield  = btrue);
             y = y + 1;
             %subst(f_chgfield: y: 1) =
               %subst(i_string: x: 1);
             iter;
          endif;

          //  Festellen Feldanfang ...
          select;
          when (%subst(i_string: x: 1) <> ' ')  and
             (waitfield = btrue);
             isfield = btrue;
             isorder = bfalse;
             waitfield = bfalse;
             waitorder = bfalse;

             if (%subst(i_string: x: 1) <> '"');
                y = y + 1;
                %subst(f_chgfield: y: 1) = '"';
             endif;

             //  Festellen Feldende ...
          when ((%subst(i_string: x: 1) =   ' ')  or
             (%subst(i_string: x: 1) =   ',')  or
             (%subst(i_string: x: 1) =   '"')  or
             (%subst(i_string: x: 1) =  '''')) and
             (isfield   = btrue)                   and
             (waitfield = bfalse);
             isfield   = bfalse;
             isorder   = bfalse;
             waitfield = bfalse;
             waitorder = btrue;

             if (%subst(i_string: x: 1) <> '"');
                y = y + 1;
                %subst(f_chgfield: y: 1) = '"';
             endif;

             //  Festellen Orderanfang ...
          when (%subst(i_string: x: 1) <> ' ')  and
             (waitorder = btrue);
             isfield = bfalse;
             isorder = btrue;
             waitfield = bfalse;
             waitorder = bfalse;

             //  Festellen Orderende ...
          when ((%subst(i_string: x: 1) =   ' ')  or
             (%subst(i_string: x: 1) =   ',')  or
             (%subst(i_string: x: 1) =   '"')  or
             (%subst(i_string: x: 1) =  '''')) and
             (isorder   = btrue)                   and
             (waitorder = bfalse);
             isfield   = bfalse;
             isorder   = bfalse;
             waitfield = btrue;
             waitorder = bfalse;
          endsl;

          //  Trennzeichen  ...
          if (%subst(i_string: x: 1) =  ',');
             isfield   = bfalse;
             isorder   = bfalse;
             waitfield = btrue;
             waitorder = bfalse;
          endif;

          //  Löschen Order ...
          if (isorder    = btrue)  and
             (i_rmvorder = btrue);
             //**                Eval      y = y + 1
             //**                Eval      %subst(f_chgField: y: 1) = ' '
          else;
             y = y + 1;
             %subst(f_chgfield: y: 1) =
               %subst(i_string: x: 1);
          endif;

       endfor;

       return f_chgfield;

       end-proc;

