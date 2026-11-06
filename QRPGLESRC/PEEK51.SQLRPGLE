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
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

dcl-pr f_sqlMsgID char(7);
  i_sqlCode int(10) const;
end-pr;

dcl-pr f_isDeleted like(bool_t);
  i_hFile likeds(hFile_t) const;
end-pr;

dcl-pr p_cvtSqlMg;
  i_toMsgID char(7) const;
  io_msgID  like(msgId_t);
  io_msgDta like(msgDta_t);
end-pr;

dcl-pr f_getField like(varString_t);
  i_sqlOrder like(varString_t) const;
end-pr;

dcl-pr f_chgField like(varString_t);
  i_string   like(varString_t) const;
  i_rmvOrder like(bool_t) const;
end-pr;

//  ... Execute Command (QCMDEXC) API
dcl-pr qcmdexc extpgm('QCMDEXC');
  i_cmd    char(32702) options(*varsize) const;
  i_length packed(15: 5) const;
end-pr;

// Für Sortierung nach relativer Satznummer
dcl-ds g_hFile03 likeds(hFile_t);

dcl-s g_file char(10);
dcl-s g_lib char(10);
dcl-s g_mbr char(10);
dcl-s g_fmt char(10);

dcl-s g_cmdOvrDbf like(varString_t);

//===================================================================*
//  Prozedur:  SQL_prepareStatement                       (Body)     *
//===================================================================*

dcl-proc SQL_prepareStatement export;
  dcl-pi *n like(bool_t);
    i_check     like(bool_t) value;
    i_file      like(file_t) value;
    i_lib       like(lib_t) value;
    i_mbr       like(mbr_t) value;
    i_fmt       like(rcdFmt_t) value;
    i_sqlSelect like(sqlSelect_t) value;
    i_sqlOrder  like(sqlWhere_t) value;
    o_msgID     like(msgId_t);
    o_msgDta    like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_prepStmt like(bool_t);

  dcl-s i like(int4_t);
  dcl-s sqlSelectStmt like(sqlStmt_t);
  dcl-s sqlCountStmt like(sqlStmt_t);

  dcl-s pFile like(file_t);
  dcl-s pLib like(lib_t);
  dcl-s pMbr like(mbr_t);
  dcl-s pFmt like(rcdFmt_t);

  dcl-s cmdOvrDbf like(g_cmdOvrDbf);

  // ------------------------------------------------------------------------

  //**                If         f_basedPF(i_file: i_lib: i_mbr: i_fmt: -1
  //**                                     : pFile: pLib: pMbr: pFmt) = bTrue
  //                  go ahead ...
  //**                Else
  pFile = i_file;
  pLib  = i_lib;
  pMbr  = i_mbr;
  pFmt  = i_fmt;
  //**                Endif

  //  ovrDbf
  //  (Eine Prüfung darf den Zustand des offenen Cursors nicht ändern,
  //  deshalb übernimmt erst eine erfolgreiche Vorbereitung g_cmdOvrDbf.)
  cmdOvrDbf = 'OVRDBF FILE(FILE03)'         +
               ' TOFILE('                  +
               %trim(pLib )                +
               '/'                         +
               %trim(pFile)                +
               ')'                         +
               ' MBR('                     +
               %trim(pMbr)                 +
               ')'                         +
               ' OVRSCOPE(*CALLLVL)'       +
               ' SHARE(*NO)'               +
               ' SECURE(*YES)'             +
               ' SEQONLY(*NO)';
  qcmdexc(cmdOvrDbf: %len(cmdOvrDbf));

  //  Statement ...
  sqlSelectStmt = 'SELECT'                  +
                 ' RRN(T3)';

  //  ... plus Datei
  sqlSelectStmt = %trim(sqlSelectStmt)      +
                 ' FROM'                   +
                 ' ' + %trim('FILE03')     +
                 ' T3';

  //  ... plus SELECT
  if (i_sqlSelect <> ' ');
    sqlSelectStmt = %trim(sqlSelectStmt)      +
                   ' WHERE'                  +
                   ' ' + %trim(i_sqlSelect);
  endif;

  //  ... erzeugen COUNT(*) Anweisung
  i = %scan('RRN(T3)': sqlSelectStmt);
  sqlCountStmt =
    %replace('COUNT(*)': sqlSelectStmt
             : i: %len('RRN(T3)'));

  //  ... plus ORDER BY
  if (i_sqlOrder <> ' ');
    sqlSelectStmt = %trim(sqlSelectStmt)      +
                   ' ORDER BY'               +
                   ' ' + %trim(i_sqlOrder);
  endif;

  // SQL-STATEMENT VORBEREITEN
  if (i_check = bTrue);
    EXEC SQL
      prepare g_chkStmt from :sqlSelectStmt;
  else;
    EXEC SQL
      prepare g_prepSelectStmt from :sqlSelectStmt;
    if (f_isSqlErr(o_msgID :
                o_msgDta) = bFalse);
      EXEC SQL
        prepare g_prepCountStmt from :sqlCountStmt;
    endif;
  endif;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgID: o_msgDta) = bTrue);
    f_prepStmt = bFalse;
    if (i_check = bFalse);
      g_file = '';
      g_lib = '';
      g_mbr = '';
      g_fmt = '';
    endif;

    p_cvtSqlMg('USR8210': o_msgID: o_msgDta);

  else;
    f_prepStmt = bTrue;
    if (i_check = bFalse);
      g_cmdOvrDbf = cmdOvrDbf;
      g_file = i_file;
      g_lib = i_lib;
      g_mbr = i_mbr;
      g_fmt = i_fmt;
    endif;
  endif;

  return f_prepStmt;

end-proc;

//===================================================================*
//  Prozedur:  SQL_open                                   (Body)     *
//===================================================================*

dcl-proc SQL_open export;
  dcl-pi *n like(bool_t);
    o_hFile  likeds(hFile_t);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_opnSql like(bool_t) inz(bFalse);
  // ------------------------------------------------------------------------

  //  ovrDbf
  callp qcmdexc(g_cmdOvrDbf: %len(g_cmdOvrDbf));

  // CURSOR fileSQL DEKLARIEREN
  EXEC SQL
    declare g_fileSQL scroll cursor for g_prepSelectStmt;

  // CURSOR CS ÖFFNEN
  EXEC SQL
    open g_fileSQL;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgID :
              o_msgDta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgID: o_msgDta);
    CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta);

    f_opnSql = bFalse;
  else;
    if CIO_open(g_hFile03
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
      f_opnSql = bFalse;
      //  Cursor schließen, sonst scheitert das nächste
      //  SQL_open() mit SQL0502.
      EXEC SQL
        close g_fileSQL;
    else;
      f_opnSql = bTrue;
    endif;
  endif;

  //  Setzen Rückgabeparameter
  o_hFile = g_hFile03;

  return f_opnSql;

end-proc;

//===================================================================*
//  Prozedur:  SQL_nextRow                                (Body)     *
//===================================================================*

dcl-proc SQL_nextRow export;
  dcl-pi *n like(bool_t);
    o_buffer  like(rcdBuf_t);
    o_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
    o_hFile   likeds(hFile_t);
    o_msgID   like(msgId_t);
    o_msgDta  like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s isEOF like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recNbr int(10);
  dcl-s isDeleted like(bool_t);

  dcl-ds io_buff based(ptrBuffer);
    io_buffFld like(rcdBuf_t);
  end-ds;

  dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE) based(ptrNullMap);
  // ------------------------------------------------------------------------
  ptrBuffer = %addr(o_buffer );
  ptrNullMap= %addr(o_nullMap);

  //  Sätze, die nach dem Öffnen des Cursors gelöscht wurden, überlesen
  dou (isDeleted = bFalse);
    isDeleted = bFalse;

    // GET NEXT ROW
    EXEC SQL
      fetch next from g_fileSQL
        into :recNbr;

    // PRÜFUNG AUSWERTEN
    if (f_isSqlErr(o_msgID :
                o_msgDta) = bTrue);

      p_cvtSqlMg('USR8210': o_msgID: o_msgDta);
      CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta);
      isEOF = bTrue;

    else;

      if (sqlCode = 100);
        CIO_setEOF_read(g_hFile03);
      else;

        if (CIO_chainWithRRN(g_hFile03
                          : recNbr
                          : bTrue
                          : io_buff
                          : io_nullMap) = bFalse);
          isDeleted = f_isDeleted(g_hFile03);
          isEOF = bTrue;
        else;
          isEOF = bFalse;
        endif;

      endif;

    endif;
  enddo;

  //  Setzen Rückgabeparameter
  o_hFile = g_hFile03;

  return isEOF;

end-proc;

//===================================================================*
//  Prozedur:  SQL_previousRow                            (Body)     *
//===================================================================*

dcl-proc SQL_previousRow export;
  dcl-pi *n like(bool_t);
    o_buffer  like(rcdBuf_t);
    o_nullMap like(nullMap_t) dim(NULL_MAP_SIZE);
    o_hFile   likeds(hFile_t);
    o_msgID   like(msgId_t);
    o_msgDta  like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s isEOF like(bool_t) inz(bTrue);

  //  definieren lokale Variablen ...
  dcl-s recNbr int(10);
  dcl-s isDeleted like(bool_t);

  dcl-ds io_buff based(ptrBuffer);
    io_buffFld like(rcdBuf_t);
  end-ds;

  dcl-s io_nullMap like(nullMap_t) dim(NULL_MAP_SIZE) based(ptrNullMap);
  // ------------------------------------------------------------------------
  ptrBuffer = %addr(o_buffer );
  ptrNullMap= %addr(o_nullMap);

  //  Sätze, die nach dem Öffnen des Cursors gelöscht wurden, überlesen
  dou (isDeleted = bFalse);
    isDeleted = bFalse;

    // GET PREVIOUS ROW
    EXEC SQL
      fetch prior from g_fileSQL
        into :recNbr;

    // PRÜFUNG AUSWERTEN
    if (f_isSqlErr(o_msgID :
                o_msgDta) = bTrue);

      p_cvtSqlMg('USR8210': o_msgID: o_msgDta);
      CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta);
      isEOF = bTrue;

    else;

      if (sqlCode = 100);
        CIO_setEOF_readp(g_hFile03);
      else;

        if (CIO_chainWithRRN(g_hFile03
                          : recNbr
                          : bTrue
                          : io_buff
                          : io_nullMap) = bFalse);
          isDeleted = f_isDeleted(g_hFile03);
          isEOF = bTrue;
        else;
          isEOF = bFalse;
        endif;

      endif;

    endif;
  enddo;

  //  Setzen Rückgabeparameter
  o_hFile = g_hFile03;

  return isEOF;

end-proc;

//===================================================================*
//  Prozedur:  SQL_gotoTop                                (Body)     *
//===================================================================*

dcl-proc SQL_gotoTop export;
  dcl-pi *n like(bool_t);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_topRow like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // POSITION BEFORE FIRST ROW
  EXEC SQL
    fetch before from g_fileSQL;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgID :
              o_msgDta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgID: o_msgDta);

    f_topRow = bFalse;
  else;
    f_topRow = bTrue;
  endif;

  return f_topRow;

end-proc;

//===================================================================*
//  Prozedur:  SQL_gotoBottom                             (Body)     *
//===================================================================*

dcl-proc SQL_gotoBottom export;
  dcl-pi *n like(bool_t);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_botRow like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // POSITION BEFORE FIRST ROW
  EXEC SQL
    fetch last from g_fileSQL;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgID :
              o_msgDta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgID: o_msgDta);

    f_botRow = bFalse;
  else;
    f_botRow = bTrue;
  endif;

  return f_botRow;

end-proc;

//===================================================================*
//  Prozedur:  SQL_close                                  (Body)     *
//===================================================================*

dcl-proc SQL_close export;
  dcl-pi *n like(bool_t);
    o_hFile  likeds(hFile_t);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_clsSql like(bool_t) inz(bFalse);

  // ------------------------------------------------------------------------

  // CURSOR CS SCHLIESSEN
  EXEC SQL
    close g_fileSQL;

  // PRÜFUNG AUSWERTEN
  if (f_isSqlErr(o_msgID :
              o_msgDta) = bTrue);

    p_cvtSqlMg('USR8210': o_msgID: o_msgDta);

    f_clsSql = bFalse;
  else;
    if (CIO_close(g_hFile03) = bTrue);
      *in99 = '0';
    else;
      *in99 = '1';
    endif;

    if (*in99 = *on);
      f_clsSql = bFalse;
    else;
      f_clsSql = bTrue;
      g_file = ' ';
      g_lib  = ' ';
      g_mbr  = ' ';
    endif;
  endif;

  //  Setzen Rückgabeparameter
  o_hFile = g_hFile03;

  return f_clsSql;

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
  dcl-s msgID like(msgId_t);
  dcl-s msgDta like(msgDta_t);
  // ------------------------------------------------------------------------

  //  ovrDbf
  callp(e) qcmdexc(g_cmdOvrDbf: %len(g_cmdOvrDbf));

  // CURSOR fileSQL DEKLARIEREN
  EXEC SQL
    declare g_countSQL scroll cursor for g_prepCountStmt;

  // CURSOR CS ÖFFNEN
  EXEC SQL
    open g_countSQL;

  if (f_isSqlErr(msgID: msgDta) = bTrue);
    return -1;
  endif;

  // GET FIRST ROW
  EXEC SQL
    fetch first from g_countSQL
      into :f_count;

  if (f_isSqlErr(msgID: msgDta) = bTrue);
    //  Cursor schließen, sonst scheitert der nächste Aufruf.
    EXEC SQL
      close g_countSQL;
    return -1;
  endif;

  // CURSOR CS SCHLIESSEN
  EXEC SQL
    close g_countSQL;
  if (f_isSqlErr(msgID: msgDta) = bTrue);
    return -1;
  endif;

  return f_count;

end-proc;

//===================================================================*
//  Prozedur:  f_isSqlErr                                 (Body)     *
//===================================================================*

dcl-proc f_isSqlErr;
  dcl-pi *n like(bool_t);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_isSqlErr like(bool_t);
  // ------------------------------------------------------------------------
  if (sqlCode >= 0);
    o_msgID  = ' ';
    o_msgDta = ' ';
    f_isSqlErr = bFalse;
  else;
    o_msgID  = f_sqlMsgID(sqlCode);
    o_msgDta = %subst(sqlErm: 1: sqlErl);
    f_isSqlErr = bTrue;
  endif;

  return f_isSqlErr;

end-proc;

//===================================================================*
//  Prozedur:  f_isDeleted                                (Body)     *
//  Prüft, ob der letzte Zugriff auf die Datei fehlschlug, weil der  *
//  Satz nicht mehr existiert.                                       *
//===================================================================*

dcl-proc f_isDeleted;
  dcl-pi *n like(bool_t);
    i_hFile likeds(hFile_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  if (CIO_getError(i_hFile) = enorec_c or
      CIO_getError(i_hFile) = eiorecerr_c);
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
    i_toMsgID char(7) const;
    io_msgID  like(msgId_t);
    io_msgDta like(msgDta_t);
  end-pi;

/copy QCOPYLE,RTVM0100

/copy QCOPYLE,USR8210
  // ------------------------------------------------------------------------

  clear usr8210;
  usr8210.var1 = io_msgID;
  usr8210.var2 = f_msgText(io_msgID : io_msgDta:
                        'QSQLMSG': 'QSYS'   );

  io_msgID = 'USR8210';
  io_msgDta = usr8210;

  return;

end-proc;

//===================================================================*
//  Prozedur:  f_getField                                 (Body)     *
//===================================================================*

dcl-proc f_getField;

  //  definieren Procedure Interface ...
  dcl-pi *n like(varString_t);
    i_sqlOrder like(varString_t) const;
  end-pi;
  // ------------------------------------------------------------------------

  return f_chgField(i_sqlOrder: bTrue);

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
    i_rmvOrder like(bool_t) const;
  end-pi;

  //  definieren Funktionswert ...
  dcl-s f_chgField like(varString_t);

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
    if (%len(f_chgField) >= %len(f_chgField: *max));
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
      f_chgField = f_chgField + char;
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
        f_chgField = f_chgField + DOOUBLE_QUOTE;
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
        f_chgField = f_chgField + DOOUBLE_QUOTE;
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
    if (isOrder = bTrue and i_rmvOrder = bTrue);
    //**                Eval      y = y + 1
    //**                Eval      %subst(f_chgField: y: 1) = ' '
    else;
      f_chgField = f_chgField + char;
    endif;

  endfor;

  //  Abschließen Feldname am Ende der Zeichenkette ...
  if (isField = bTrue and %len(f_chgField) < %len(f_chgField: *max));
    f_chgField = f_chgField + DOOUBLE_QUOTE;
  endif;

  return f_chgField;

end-proc;

