**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Ändern Satzformat PEEKUSR                    *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.3.3                               *
//  Programm : PEEK62                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 03.04.2006  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Ändern Satzformat PEEKUSR                         *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f oldFile disk(32766) usropn infds(file_01_ds) extfile(g_oldFile);

dcl-f peekusr usropn infds(file_02_ds) extfile(g_peekUsr);

dcl-ds file_01_ds likeds(infds_t);
dcl-ds file_02_ds likeds(infds_t);

dcl-s g_oldFile char(21) inz;
dcl-s g_peekUsr char(21) inz;

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr9995.rpgleinc'
/copy 'qcopyle/usr9989.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek62.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s long_t int(10) template;
dcl-s short_t int(5) template;

dcl-s henv_t like(long_t) template;
dcl-s hdbc_t like(long_t) template;
dcl-s hstmt_t like(long_t) template;
dcl-s retCode_t like(sqlinteger_t) template;
dcl-s ptr_t pointer template;

dcl-s sqlinteger_t like(long_t) template;
dcl-s sqlsmallint_t like(short_t) template;
dcl-s sqlhenv_t like(henv_t) template;
dcl-s sqlhdbc_t like(hdbc_t) template;
dcl-s sqlhstmt_t like(hstmt_t) template;
dcl-s sqlreturn_t like(retCode_t) template;
dcl-s sqlpointer_t like(ptr_t) template;

dcl-c SQL_NTS -3;
dcl-c SQL_DROP 1;

dcl-c sql_attr_commit 0;
dcl-c sql_commit_none 1;

//  Allocate Environment Handle
dcl-pr SQLAllocEnv extproc('SQLAllocEnv') like(sqlreturn_t);
  o_phenv pointer value;
end-pr;

//  Allocate Connection Handle
dcl-pr SQLAllocConnect extproc('SQLAllocConnect') like(sqlreturn_t);
  i_henv  like(sqlhenv_t) value;
  o_phdbc pointer value;
end-pr;

//  Connect to a Data Source
dcl-pr SQLConnect extproc('SQLConnect') like(sqlreturn_t);
  i_hdbc      like(sqlhdbc_t) value;
  i_szDSN     pointer options(*string) value;
  i_cbDSN     like(sqlsmallint_t) value;
  i_szUID     pointer options(*string) value;
  i_cbUID     like(sqlsmallint_t) value;
  i_szAuthStr pointer options(*string) value;
  i_cbAuthStr like(sqlsmallint_t) value;
end-pr;

//  Set Connection Option
dcl-pr SQLSetConnectOption extproc('SQLSetConnectOption') like(sqlreturn_t);
  i_hdbc    like(sqlhdbc_t) value;
  i_fOption like(sqlsmallint_t) value;
  i_vParam  like(sqlpointer_t) value;
end-pr;

//  Allocate a Statement Handle
dcl-pr SQLAllocStmt extproc('SQLAllocStmt') like(sqlreturn_t);
  i_hdbc   like(sqlhdbc_t) value;
  o_phstmt pointer value;
end-pr;

//  Execute a Statement Directly
dcl-pr SQLExecDirect extproc('SQLExecDirect') like(sqlreturn_t);
  i_hstmt    like(sqlhstmt_t) value;
  i_szSqlStr pointer options(*string) value;
  i_cbSqlStr like(sqlinteger_t) value;
end-pr;

//  Free (or Reset) a Statement Handle
dcl-pr SQLFreeStmt extproc('SQLFreeStmt') like(sqlreturn_t);
  i_hstmt   like(sqlhstmt_t) value;
  i_fOption like(sqlsmallint_t) value;
end-pr;

//  Disconnect from a Data Source
dcl-pr SQLDisconnect extproc('SQLDisconnect') like(sqlreturn_t);
  i_hdbc like(sqlhdbc_t) value;
end-pr;

//  Free Connection Handle
dcl-pr SQLFreeConnect extproc('SQLFreeConnect') like(sqlreturn_t);
  i_hdbc like(sqlhdbc_t) value;
end-pr;

//  Free Environment Handle
dcl-pr SQLFreeEnv extproc('SQLFreeEnv') like(sqlreturn_t);
  i_henv like(sqlhenv_t) value;
end-pr;

dcl-s rcdLen1 uns(10) inz;
dcl-s rcdLen2 uns(10) inz;

dcl-s cOptVal int(10) inz;
dcl-s retCode like(sqlreturn_t) inz;
dcl-s hEnv like(sqlhenv_t) inz;
dcl-s hDBc like(sqlhdbc_t) inz;
dcl-s hStmt like(sqlhstmt_t) inz;
dcl-s sqlStr char(512) inz;

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek62;
  i_file   like(file_t) const;
  i_lib    like(lib_t) const;
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

o_msgID = '';
o_msgDta = '';

g_oldFile = %trim(i_lib ) + '/' + %trim(i_file);
g_peekUsr = %trim(f_getPrdLb()) + '/' + 'PEEKUSR';

//  Satzlängen vergleichen. Lässt sich eine der Dateien nicht öffnen
//  (z. B. gesperrt), entfällt die Anpassung; den Fehler meldet dann
//  PEEK31 beim Lesen der Einstellungen.
monitor;
  open oldFile;
  rcdLen1 = file_01_ds.rcdLen;
  close oldFile;

  open peekusr;
  rcdLen2 = file_02_ds.rcdLen;
  close peekusr;
on-error;
  if (%open(oldFile));
    close oldFile;
  endif;
  if (%open(peekusr));
    close peekusr;
  endif;
  return;
endmon;

p_rmvPgmMg(sds.pgmName);

if (rcdLen1 <> rcdLen2);

  clear usr9995;

  p_sndStsMg('USR9995': usr9995);

  dou (1=1);
    //  Allocate SQL Environment Handle and ...
    retCode = SQLAllocEnv(%addr(hEnv));
    if (retCode <> 0);
      leave;
    endif;

    //  Allocate SQL Connection Handle
    retCode = SQLAllocConnect(hEnv: %addr(hDBc));
    if (retCode <> 0);
      leave;
    endif;

    //  ... Set Connection Attribute
    cOptVal = sql_commit_none;
    retCode = SQLSetConnectOption(hDBc
                                  : sql_attr_commit: %addr(cOptVal));

    //  Connect to Server and ...
    retCode = SQLConnect(hDBc: '*LOCAL': SQL_NTS
                         : *null: SQL_NTS: *null: SQL_NTS);
    if (retCode <> 0);
      leave;
    endif;

    //  Allocate Statement Handle
    retCode = SQLAllocStmt(hDBc: %addr(hStmt));
    if (retCode <> 0);
      leave;
    endif;

    //  Execute SQL Statement
    sqlStr =
     'ALTER TABLE ' +
       %trim(i_lib) + '.' + %trim(i_file) +
     ' ALTER COLUMN DATA +
       SET DATA TYPE CHARACTER (256) +
           NOT NULL WITH DEFAULT';

    retCode = SQLExecDirect(hStmt: sqlStr: SQL_NTS);
    if (retCode <> 0);
      leave;
    endif;

  enddo;

  //  Free Statement Handle
  if (hStmt <> 0);
    retCode = SQLFreeStmt(hStmt: SQL_DROP);
  endif;

  //  Disconnect from Server
  if (hDBc <> 0);
    retCode = SQLDisconnect(hDBc);
  endif;

  //  Free Connection Handle
  if (hDBc <> 0);
    retCode = SQLFreeConnect(hDBc);
  endif;

  //  Free Environment Handle
  if (hEnv <> 0);
    retCode = SQLFreeEnv(hEnv);
  endif;

  //  Prüfen, ob die Anpassung gelungen ist: Scheitert das ALTER
  //  (z. B. Datei in Benutzung) oder weicht eine andere Spalte ab,
  //  hat die Datei weiterhin eine andere Satzlänge.
  rcdLen1 = 0;
  monitor;
    open oldFile;
    rcdLen1 = file_01_ds.rcdLen;
    close oldFile;
  on-error;
    if (%open(oldFile));
      close oldFile;
    endif;
  endmon;

  if (rcdLen1 <> rcdLen2);
    clear usr9989;
    usr9989.var1 = i_file;
    usr9989.var2 = i_lib;
    o_msgID  = 'USR9989';
    o_msgDta = usr9989;
  endif;

endif;

return;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

