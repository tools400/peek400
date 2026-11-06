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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

/copy QCOPYLE,D_CLIB
/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100

/copy QCOPYLE,PPEEK51
/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58
/copy QCOPYLE,PPEEK63

dcl-pr f_isSqlErr like(bool_t);
  o_msgid  like(msgid_t);
  o_msgdta like(msgdta_t);
end-pr;

dcl-pr f_sqlMsgID char(7);
  i_sqlCode int(10) const;
end-pr;

dcl-pr f_isDeleted like(bool_t);
  i_hfile likeds(hfile_t) const;
end-pr;

dcl-pr p_cvtSqlMg;
  i_tomsgid char(7) const;
  io_msgid  like(msgid_t);
  io_msgdta like(msgdta_t);
end-pr;

dcl-pr f_getField like(varString_t);
  i_sqlorder like(varString_t) const;
end-pr;

dcl-pr f_chgField like(varString_t);
  i_string   like(varString_t) const;
  i_rmvorder like(bool_t) const;
end-pr;

//  ... Execute Command (QCMDEXC) API
dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd    char(32702) options(*varsize) const;
  i_length packed(15: 5) const;
end-pr;

// Für Sortierung nach relativer Satznummer
dcl-ds g_hfile03 likeds(hfile_t);

dcl-s g_file char(10);
dcl-s g_lib char(10);
dcl-s g_mbr char(10);
dcl-s g_fmt char(10);

dcl-s g_cmdovrdbf like(varString_t);

//===================================================================*
//  Prozedur:  SQL_prepareStatement                       (Body)     *
//===================================================================*

dcl-proc SQL_prepareStatement export;
  dcl-pi *n like(bool_t);
    i_check     like(bool_t) value;
    i_file      like(file_t) value;
    i_lib       like(lib_t) value;
    i_mbr       like(mbr_t) value;
    i_fmt       like(rcdfmt_t) value;
    i_sqlselect like(sqlSelect_t) value;
    i_sqlorder  like(sqlWhere_t) value;
    o_msgid     like(msgid_t);
    o_msgdta    like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_prepstmt like(bool_t);

  dcl-s i like(int4_t);
  dcl-s sqlselectstmt like(sqlstmt_t);
  dcl-s sqlcountstmt like(sqlstmt_t);

  dcl-s pfile like(file_t);
  dcl-s plib like(lib_t);
  dcl-s pmbr like(mbr_t);
  dcl-s pfmt like(rcdfmt_t);

  dcl-s cmdovrdbf like(g_cmdovrdbf);

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
  //  (Eine Prüfung darf den Zustand des offenen Cursors nicht ändern,
  //  deshalb übernimmt erst eine erfolgreiche Vorbereitung g_cmdovrdbf.)
  cmdovrdbf = 'OVRDBF FILE(FILE03)'         +
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
  qcmdexc(cmdovrdbf: %len(cmdovrdbf));

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
    if (i_check = bFalse);
      g_file = '';
      g_lib = '';
      g_mbr = '';
      g_fmt = '';
    endif;

    p_cvtSqlMg('USR8210': o_msgid: o_msgdta);

  else;
    f_prepstmt = bTrue;
    if (i_check = bFalse);
      g_cmdovrdbf = cmdovrdbf;
      g_file = i_file;
      g_lib = i_lib;
      g_mbr = i_mbr;
      g_fmt = i_fmt;
    endif;
  endif;

  return f_prepstmt;

end-proc;

//===================================================================*
//  Prozedur:  SQL_open                                   (Body)     *
//===================================================================*

dcl-proc SQL_open export;
  dcl-pi *n like(bool_t);
    o_hfile  likeds(hfile_t);
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_opnsql like(bool_t) inz(bFalse);
  // ------------------------------------------------------------------------

  //  ovrDbf
  callp qcmdexc(g_cmdovrdbf: %len(g_cmdovrdbf));

  // CURSOR fileSQL DEKLARIEREN
  EXEC SQL
   declare g_filesql scroll cursor for g_prepselectstmt;

  // CURSOR CS ÖFFNEN
  EXEC SQL
   open g_filesql;

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
      //  Cursor schließen, sonst scheitert das nächste
      //  SQL_open() mit SQL0502.
      EXEC SQL
       close g_filesql;
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
  dcl-pi *n like(bool_t);
    o_buffer  like(rcdbuf_t);
    o_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
    o_hfile   likeds(hfile_t);
    o_msgid   like(msgid_t);
    o_msgdta  like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s iseof like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recnbr int(10);
  dcl-s isdeleted like(bool_t);

  dcl-ds io_buff based(ptrbuffer);
    io_bufffld like(rcdbuf_t);
  end-ds;

  dcl-s io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE) based(ptrnullmap);
  // ------------------------------------------------------------------------
  ptrbuffer = %addr(o_buffer );
  ptrnullmap= %addr(o_nullmap);

  //  Sätze, die nach dem Öffnen des Cursors gelöscht wurden, überlesen
  dou (isdeleted = bFalse);
    isdeleted = bFalse;

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
          isdeleted = f_isDeleted(g_hfile03);
          iseof = bTrue;
        else;
          iseof = bFalse;
        endif;

      endif;

    endif;
  enddo;

  //  Setzen Rückgabeparameter
  o_hfile = g_hfile03;

  return iseof;

end-proc;

//===================================================================*
//  Prozedur:  SQL_previousRow                            (Body)     *
//===================================================================*

dcl-proc SQL_previousRow export;
  dcl-pi *n like(bool_t);
    o_buffer  like(rcdbuf_t);
    o_nullmap like(nullmap_t) dim(NULL_MAP_SIZE);
    o_hfile   likeds(hfile_t);
    o_msgid   like(msgid_t);
    o_msgdta  like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s iseof like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recnbr int(10);
  dcl-s isdeleted like(bool_t);

  dcl-ds io_buff based(ptrbuffer);
    io_bufffld like(rcdbuf_t);
  end-ds;

  dcl-s io_nullmap like(nullmap_t) dim(NULL_MAP_SIZE) based(ptrnullmap);
  // ------------------------------------------------------------------------
  ptrbuffer = %addr(o_buffer );
  ptrnullmap= %addr(o_nullmap);

  //  Sätze, die nach dem Öffnen des Cursors gelöscht wurden, überlesen
  dou (isdeleted = bFalse);
    isdeleted = bFalse;

    // GET PREVIOUS ROW
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
          isdeleted = f_isDeleted(g_hfile03);
          iseof = bTrue;
        else;
          iseof = bFalse;
        endif;

      endif;

    endif;
  enddo;

  //  Setzen Rückgabeparameter
  o_hfile = g_hfile03;

  return iseof;

end-proc;

//===================================================================*
//  Prozedur:  SQL_gotoTop                                (Body)     *
//===================================================================*

dcl-proc SQL_gotoTop export;
  dcl-pi *n like(bool_t);
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
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
  dcl-pi *n like(bool_t);
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
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
  dcl-pi *n like(bool_t);
    o_hfile  likeds(hfile_t);
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_clssql like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // CURSOR CS SCHLIESSEN
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
  dcl-pi *n like(int4_t);
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
    //  Cursor schließen, sonst scheitert der nächste Aufruf.
    EXEC SQL
     close g_countsql;
    return -1;
  endif;

  // CURSOR CS SCHLIESSEN
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
  dcl-pi *n like(bool_t);
    o_msgid  like(msgid_t);
    o_msgdta like(msgdta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_issqlerr like(bool_t);
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
//  Prozedur:  f_isDeleted                                (Body)     *
//  Prüft, ob der letzte Zugriff auf die Datei fehlschlug, weil der  *
//  Satz nicht mehr existiert.                                       *
//===================================================================*

dcl-proc f_isDeleted;
  dcl-pi *n like(bool_t);
    i_hfile likeds(hfile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (cio_geterror(i_hfile) = enorec_c or
      cio_geterror(i_hfile) = eiorecerr_c);
    return bTrue;
  endif;

  return bFalse;

end-proc;

//===================================================================*
//  Prozedur:  f_sqlMsgID                                 (Body)     *
//===================================================================*

dcl-proc f_sqlMsgID;
  dcl-pi *n char(7);
    i_sqlCode int(10) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s sqlMsgID char(7);

  //  lokale variablen ...
  dcl-ds ds_sqlCode qualified;
    sqlCode zoned(10) inz;
    msgID   char(7) overlay(sqlCode: 4);
  end-ds;

  dcl-s idx int(10);
  dcl-c SQL0000 'SQL0000';

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
  dcl-pi *n;
    i_tomsgid char(7) const;
    io_msgid  like(msgid_t);
    io_msgdta like(msgdta_t);
  end-pi;

/copy QCOPYLE,RTVM0100

/copy QCOPYLE,USR8210
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
  dcl-pi *n like(varString_t);
    i_sqlorder like(varString_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  return f_chgField(i_sqlorder: bTrue);

end-proc;

//===================================================================*
//  Prozedur:  SQL_quote                                  (Body)     *
//===================================================================*

dcl-proc SQL_quote export;
  dcl-pi *n like(varString_t);
    i_string like(varString_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  return f_chgField(i_string: bFalse);

end-proc;

//===================================================================*
//  Prozedur:  f_chgField                                 (Body)     *
//===================================================================*

dcl-proc f_chgField;
  dcl-pi *n like(varString_t);
    i_string   like(varString_t) const;
    i_rmvorder like(bool_t) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_chgfield like(varString_t);

  dcl-s x like(int4_t);
  dcl-s char char(1);

  dcl-s isHyphen like(bool_t);
  dcl-s isField like(bool_t);
  dcl-s isOrder like(bool_t);

  dcl-s waitField like(bool_t);
  dcl-s waitOrder like(bool_t);

  dcl-s isEndOfQuotedValue like(bool_t);

  dcl-c DOOUBLE_QUOTE '"';
  dcl-c SIGNLE_QUOTE '''';
  dcl-c COMMA ',';
  dcl-c SPACE ' ';
  dcl-c END_OF_FIELD '"'', ';
  // ------------------------------------------------------------------------

  isHyphen  = bFalse;
  isField   = bFalse;
  isOrder   = bFalse;

  waitField = bTrue;
  waitOrder = bFalse;

  for x = 1 to %len(i_string);
    if (%len(f_chgfield) >= %len(f_chgfield: *max));
      leave;
    endif;

    char = %subst(i_string: x: 1);

    //  Prüfen auf Hochkomma ...
    if (char = DOOUBLE_QUOTE or char = SIGNLE_QUOTE);
      if (isHyphen = bTrue);
        isHyphen = bFalse;
      else;
        isHyphen = bTrue;
      endif;
    endif;

    //  Überlesen in Hochkomma eingeschlossene Felder ...
    if (isHyphen = bTrue and isField = bTrue);
      f_chgfield = f_chgfield + char;
      iter;
    endif;

    //  Festellen Feldanfang ...
    isEndOfQuotedValue = %check(END_OF_FIELD: char) = 0;
    select;
    when (char <> SPACE and char <> COMMA and waitField = bTrue);
      isField = bTrue;
      isOrder = bFalse;
      waitField = bFalse;
      waitOrder = bFalse;

      if (char <> DOOUBLE_QUOTE);
        f_chgfield = f_chgfield + DOOUBLE_QUOTE;
      endif;

    //  Festellen Feldende ...
    // when ((char = SPACE or char = COMMA or char = DOOUBLE_QUOTE or char = SIGNLE_QUOTE) and
    //        isField = bTrue and waitField = bFalse);
    when (isEndOfQuotedValue and isField = bTrue and waitField = bFalse);
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bFalse;
      waitOrder = bTrue;

      if (char <> DOOUBLE_QUOTE);
        f_chgfield = f_chgfield + DOOUBLE_QUOTE;
      endif;

    //  Festellen Orderanfang ...
    when (char <> SPACE and waitOrder = bTrue);
      isField = bFalse;
      isOrder = bTrue;
      waitField = bFalse;
      waitOrder = bFalse;

    //  Festellen Orderende ...
    // when ((char = SPACE or char = COMMA or char = DOOUBLE_QUOTE or char = SIGNLE_QUOTE) and
    //        isOrder = bTrue and waitOrder = bFalse);
    when (isEndOfQuotedValue and isOrder = bTrue and waitField = bFalse);
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bTrue;
      waitOrder = bFalse;
    endsl;

    //  Trennzeichen  ...
    if (char = COMMA);
      isField   = bFalse;
      isOrder   = bFalse;
      waitField = bTrue;
      waitOrder = bFalse;
    endif;

    //  Löschen Order ...
    if (isOrder = bTrue and i_rmvorder = bTrue);
    //**                Eval      y = y + 1
    //**                Eval      %subst(f_chgField: y: 1) = ' '
    else;
      f_chgfield = f_chgfield + char;
    endif;

  endfor;

  //  Abschließen Feldname am Ende der Zeichenkette ...
  if (isField = bTrue and %len(f_chgfield) < %len(f_chgfield: *max));
    f_chgfield = f_chgfield + DOOUBLE_QUOTE;
  endif;

  return f_chgfield;

end-proc;

