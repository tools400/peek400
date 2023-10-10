**free
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

dcl-pr f_isSqlErr like(bool_t);
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

dcl-pr f_getField like(varString_t);
  i_sqlorder      const like(varString_t);
end-pr;

dcl-pr f_chgField like(varString_t);
  i_string        const  like(varString_t);
  i_rmvorder      const  like(bool_t);
end-pr;

//  ... Execute Command (QCMDEXC) API
dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd           char(32702) const  options(*varsize);
  i_length        packed(15:5) const;
end-pr;

// Für Sortierung nach relativer Satznummer
dcl-ds g_hfile03 likeds(hfile_t);

dcl-s g_file          char(10);
dcl-s g_lib           char(10);
dcl-s g_mbr           char(10);
dcl-s g_fmt           char(10);

dcl-s g_cmdovrdbf     like(varString_t);

//===================================================================*
//  Prozedur:  SQL_prepareStatement                       (Body)     *
//===================================================================*

dcl-proc SQL_prepareStatement export;
  dcl-pi *N like(bool_t);
    i_check         value  like(bool_t);
    i_file          value  like(file_t);
    i_lib           value  like(lib_t);
    i_mbr           value  like(mbr_t);
    i_fmt           value  like(rcdfmt_t);
    i_sqlselect     value  like(sqlSelect_t);
    i_sqlorder      value  like(sqlWhere_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_prepstmt      like(bool_t);

  dcl-s i               like(int4_t);
  dcl-s sqlselectstmt   like(sqlstmt_t);
  dcl-s sqlcountstmt    like(sqlstmt_t);

  dcl-s pfile           like(file_t);
  dcl-s plib            like(lib_t);
  dcl-s pmbr            like(mbr_t);
  dcl-s pfmt            like(rcdfmt_t);

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
  if (i_sqlselect <> ' ');
    sqlselectstmt = %trim(sqlselectstmt)      +
                   ' WHERE'                  +
                   ' ' + %trim(i_sqlselect);
  endif;

  //  ... erzeugen COUNT(*) Anweisung
  i = %scan('RRN(T3)': sqlselectstmt);
  sqlcountstmt =
    %replace('COUNT(*)': sqlselectstmt
             : i: %len('RRN(T3)'));

  //  ... plus ORDER BY
  if (i_sqlorder <> ' ');
    sqlselectstmt = %trim(sqlselectstmt)      +
                   ' ORDER BY'               +
                   ' ' + %trim(i_sqlorder);
  endif;

  // SQL-STATEMENT VORBEREITEN
  if (i_check = bTrue);
    EXEC SQL
     prepare g_chkstmt from :sqlselectstmt;
  else;
    EXEC SQL
     prepare g_prepselectstmt from :sqlselectstmt;
    if (f_isSqlErr(o_msgid :
                o_msgdta) = bFalse);
      EXEC SQL
       prepare g_prepcountstmt from :sqlcountstmt;
    endif;
  endif;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid: o_msgdta) = bTrue);
    f_prepstmt = bFalse;
    g_file = ' ';
    g_lib  = ' ';
    g_mbr  = ' ';
    g_fmt  = ' ';

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

  else;
    f_prepstmt = bTrue;
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
  dcl-pi *N like(bool_t);
    o_hfile                likeds(hfile_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_opnsql        like(bool_t) inz(bFalse);
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
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
    cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);

    f_opnsql = bFalse;
  else;
    if cio_open(g_hfile03
             : g_file
             : g_lib
             : g_mbr
             : g_fmt
             : 'rr, arrseq=N, commit=N, +
                nullcap=Y, riofb=Y, +
                secure=Y') = bTrue;
      *in99 = *off;
    else;
      *in99 = *on;
    endif;

    if (*in99 = *on);
      f_opnsql = bFalse;
    else;
      f_opnsql = bTrue;
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
  dcl-pi *N like(bool_t);
    o_buffer               like(rcdbuf_t);
    o_nullmap              like(nullmap_t) dim(NULL_MAP_SIZE);
    o_hfile                likeds(hfile_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s iseof           like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recnbr          int(10);

  dcl-ds io_buff based(ptrbuffer);
    io_bufffld      like(rcdbuf_t);
  end-ds;

  dcl-s io_nullmap      like(nullmap_t) dim(NULL_MAP_SIZE)
  based(ptrnullmap);
  // ------------------------------------------------------------------------
  ptrbuffer = %addr(o_buffer );
  ptrnullmap= %addr(o_nullmap);

  // GET NEXT ROW
  EXEC SQL
   fetch next from g_filesql into :recnbr;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid :
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
    cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);
    iseof = bTrue;

  else;

    if (sqlCode = 100);
      cio_seteof_read(g_hfile03);
    else;

      if cio_chainwithrrn(g_hfile03
                       : recnbr
                       : bTrue
                       : io_buff
                       : io_nullmap) = bFalse;
        iseof = bTrue;
      else;
        iseof = bFalse;
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
  dcl-pi *N like(bool_t);
    o_buffer               like(rcdbuf_t);
    o_nullmap              like(nullmap_t) dim(NULL_MAP_SIZE);
    o_hfile                likeds(hfile_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s iseof           like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recnbr          int(10);

  dcl-ds io_buff based(ptrbuffer);
    io_bufffld      like(rcdbuf_t);
  end-ds;

  dcl-s io_nullmap      like(nullmap_t) dim(NULL_MAP_SIZE)
  based(ptrnullmap);
  // ------------------------------------------------------------------------
  ptrbuffer = %addr(o_buffer );
  ptrnullmap= %addr(o_nullmap);

  // GET NEXT ROW
  EXEC SQL
   fetch prior from g_filesql into :recnbr;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid :
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);
    cio_seterrormsg(g_hfile03: o_msgid: o_msgdta);
    iseof = bTrue;

  else;

    if (sqlCode = 100);
      cio_seteof_readp(g_hfile03);
    else;

      if cio_chainwithrrn(g_hfile03
                       : recnbr
                       : bTrue
                       : io_buff
                       : io_nullmap) = bFalse;
        iseof = bTrue;
      else;
        iseof = bFalse;
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
  dcl-pi *N like(bool_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_toprow like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // POSITION BEFORE FIRST ROW
  EXEC SQL
   fetch before from g_filesql;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid :
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

    f_toprow = bFalse;
  else;
    f_toprow = bTrue;
  endif;

  return f_toprow;

end-proc;

//===================================================================*
//  Prozedur:  SQL_gotoBottom                             (Body)     *
//===================================================================*

dcl-proc SQL_gotoBottom export;
  dcl-pi *N like(bool_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_botrow like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // POSITION BEFORE FIRST ROW
  EXEC SQL
   fetch last   from g_filesql;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid :
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

    f_botrow = bFalse;
  else;
    f_botrow = bTrue;
  endif;

  return f_botrow;

end-proc;

//===================================================================*
//  Prozedur:  SQL_close                                  (Body)     *
//===================================================================*

dcl-proc SQL_close export;
  dcl-pi *N like(bool_t);
    o_hfile                likeds(hfile_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_clssql like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // CURSOR CS SCHLIEßEN
  EXEC SQL
   close g_filesql;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgid :
              o_msgdta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

    f_clssql = bFalse;
  else;
    if (cio_close(g_hfile03) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;

    if (*in99 = *on);
      f_clssql = bFalse;
    else;
      f_clssql = bTrue;
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
  dcl-pi *N like(int4_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_count like(int4_t);

  //  definieren Arbeitsfelder
  dcl-s msgid like(msgid_t);
  dcl-s msgdta like(msgdta_t);
  // ------------------------------------------------------------------------

  //  ovrDbf
  callp(e) qcmdexc(g_cmdovrdbf: %len(g_cmdovrdbf));

  // CURSOR fileSQL DEKLARIEREN
  EXEC SQL
   declare g_countsql scroll cursor for g_prepcountstmt;

  // CURSOR CS ÖFFNEN
  EXEC SQL
   open g_countsql;

  if (f_isSqlErr(msgid: msgdta) = bTrue);
    return -1;
  endif;

  // GET FIRST ROW
  EXEC SQL
   fetch first from g_countsql into :f_count;

  if (f_isSqlErr(msgid: msgdta) = bTrue);
    return -1;
  endif;

  // CURSOR CS SCHLIEßEN
  EXEC SQL
   close g_countsql;
  if (f_isSqlErr(msgid: msgdta) = bTrue);
    return -1;
  endif;

  return f_count;

end-proc;

//===================================================================*
//  Prozedur:  f_isSqlErr                                 (Body)     *
//===================================================================*

dcl-proc f_isSqlErr;
  dcl-pi *N like(bool_t);
    o_msgid                like(msgid_t);
    o_msgdta               like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_issqlerr      like(bool_t);
  // ------------------------------------------------------------------------
  if (sqlCode >= 0);
    o_msgid  = ' ';
    o_msgdta = ' ';
    f_issqlerr = bFalse;
  else;
    o_msgid  = f_sqlMsgID(sqlCode);
    o_msgdta = %subst(sqlerm: 1: sqlerl);
    f_issqlerr = bTrue;
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
    if (%subst(ds_sqlCode.msgID: idx: 1) = '0');
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
    io_msgid               like(msgid_t);
    io_msgdta              like(msgdta_t);
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
  dcl-pi f_getField like(varString_t);
    i_sqlorder      const  like(varString_t);
  end-pi;
  // ------------------------------------------------------------------------

  return f_chgField(i_sqlorder: bTrue);

end-proc f_getField;

//===================================================================*
//  Prozedur:  SQL_quote                                  (Body)     *
//===================================================================*

dcl-proc SQL_quote export;
  dcl-pi *N like(varString_t);
    i_string        const  like(varString_t);
  end-pi;
  // ------------------------------------------------------------------------

  return f_chgField(i_string: bFalse);

end-proc;

//===================================================================*
//  Prozedur:  f_chgField                                 (Body)     *
//===================================================================*

dcl-proc f_chgField;
  dcl-pi *N like(varString_t);
    i_string        const  like(varString_t);
    i_rmvorder      const  like(bool_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_chgfield      like(varString_t);

  dcl-s x               like(int4_t);
  dcl-s y               like(int4_t);
  dcl-s lenstr          like(int4_t);

  dcl-s isHyphen        like(bool_t);
  dcl-s isField         like(bool_t);
  dcl-s isOrder         like(bool_t);

  dcl-s waitField       like(bool_t);
  dcl-s waitOrder       like(bool_t);
  // ------------------------------------------------------------------------

  y = 0;
  lenstr = %len(i_string);

  isHyphen  = bFalse;
  isField   = bFalse;
  isOrder   = bFalse;

  waitField = bTrue;
  waitOrder = bFalse;

  for x = 1 to lenstr;
    if y = %len(f_chgfield);
      leave;
    endif;

    //  Prüfen auf Hochkomma ...
    if (%subst(i_string: x: 1) = '"')  or
       (%subst(i_string: x: 1) = '''');
      if (isHyphen = bTrue);
        isHyphen = bFalse;
      else;
        isHyphen = bTrue;
      endif;
    endif;

    //  Überlesen in Hochkomma eingeschlossene Felder ...
    if (isHyphen = bTrue)      and
       (isField  = bTrue);
      y = y + 1;
      %subst(f_chgfield: y: 1) =
        %subst(i_string: x: 1);
      iter;
    endif;

    //  Festellen Feldanfang ...
    select;
    when (%subst(i_string: x: 1) <> ' ')  and
       (waitField = bTrue);
      isField = bTrue;
      isOrder = bFalse;
      waitField = bFalse;
      waitOrder = bFalse;

      if (%subst(i_string: x: 1) <> '"');
        y = y + 1;
        %subst(f_chgfield: y: 1) = '"';
      endif;

    //  Festellen Feldende ...
    when ((%subst(i_string: x: 1) =   ' ')  or
       (%subst(i_string: x: 1) =   ',')  or
       (%subst(i_string: x: 1) =   '"')  or
       (%subst(i_string: x: 1) =  '''')) and
       (isField   = bTrue)                   and
       (waitField = bFalse);
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bFalse;
      waitOrder = bTrue;

      if (%subst(i_string: x: 1) <> '"');
        y = y + 1;
        %subst(f_chgfield: y: 1) = '"';
      endif;

    //  Festellen Orderanfang ...
    when (%subst(i_string: x: 1) <> ' ')  and
       (waitOrder = bTrue);
      isField = bFalse;
      isOrder = bTrue;
      waitField = bFalse;
      waitOrder = bFalse;

    //  Festellen Orderende ...
    when ((%subst(i_string: x: 1) =   ' ')  or
       (%subst(i_string: x: 1) =   ',')  or
       (%subst(i_string: x: 1) =   '"')  or
       (%subst(i_string: x: 1) =  '''')) and
       (isOrder   = bTrue)                   and
       (waitOrder = bFalse);
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bTrue;
      waitOrder = bFalse;
    endsl;

    //  Trennzeichen  ...
    if (%subst(i_string: x: 1) =  ',');
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bTrue;
      waitOrder = bFalse;
    endif;

    //  Löschen Order ...
    if (isOrder    = bTrue)  and
       (i_rmvorder = bTrue);
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

