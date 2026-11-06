**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f oldfile disk(32766) usropn infds(File_01_DS) extfile(g_oldFile);

dcl-f peekusr usropn infds(File_02_DS) extfile(g_peekusr);

dcl-ds File_01_DS likeds(infds_t);
dcl-ds File_02_DS likeds(infds_t);

dcl-s g_oldFile char(21) inz;
dcl-s g_peekusr char(21) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,SDS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR9995
/copy QCOPYLE,USR9989

/define internal_prototype
/copy QCOPYLE,PPEEK62
/undefine internal_prototype

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s long_t int(10) template;
dcl-s short_t int(5) template;

dcl-s HENV_t like(long_t) template;
dcl-s HDBC_t like(long_t) template;
dcl-s HSTMT_t like(long_t) template;
dcl-s RETCODE_t like(SQLINTEGER_t) template;
dcl-s PTR_t pointer template;

dcl-s SQLINTEGER_t like(long_t) template;
dcl-s SQLSMALLINT_t like(short_t) template;
dcl-s SQLHENV_t like(HENV_t) template;
dcl-s SQLHDBC_t like(HDBC_t) template;
dcl-s SQLHSTMT_t like(HSTMT_t) template;
dcl-s SQLRETURN_t like(RETCODE_t) template;
dcl-s SQLPOINTER_t like(PTR_t) template;

dcl-c SQL_NTS -3;
dcl-c SQL_DROP 1;

dcl-c sql_attr_commit 0;
dcl-c sql_commit_none 1;

//  Allocate Environment Handle
dcl-pr SQLAllocEnv extproc('SQLAllocEnv') like(SQLRETURN_t);
  o_phenv pointer value;
end-pr;

//  Allocate Connection Handle
dcl-pr SQLAllocConnect extproc('SQLAllocConnect') like(SQLRETURN_t);
  i_henv  like(SQLHENV_t) value;
  o_phdbc pointer value;
end-pr;

//  Connect to a Data Source
dcl-pr SQLConnect extproc('SQLConnect') like(SQLRETURN_t);
  i_hdbc      like(SQLHDBC_t) value;
  i_szDSN     pointer options(*string) value;
  i_cbDSN     like(SQLSMALLINT_t) value;
  i_szUID     pointer options(*string) value;
  i_cbUID     like(SQLSMALLINT_t) value;
  i_szAuthStr pointer options(*string) value;
  i_cbAuthStr like(SQLSMALLINT_t) value;
end-pr;

//  Set Connection Option
dcl-pr SQLSetConnectOption extproc('SQLSetConnectOption') like(SQLRETURN_t);
  i_hdbc    like(SQLHDBC_t) value;
  i_fOption like(SQLSMALLINT_t) value;
  i_vParam  like(SQLPOINTER_t) value;
end-pr;

//  Allocate a Statement Handle
dcl-pr SQLAllocStmt extproc('SQLAllocStmt') like(SQLRETURN_t);
  i_hdbc   like(SQLHDBC_t) value;
  o_phstmt pointer value;
end-pr;

//  Execute a Statement Directly
dcl-pr SQLExecDirect extproc('SQLExecDirect') like(SQLRETURN_t);
  i_hstmt    like(SQLHSTMT_t) value;
  i_szSqlStr pointer options(*string) value;
  i_cbSqlStr like(SQLINTEGER_t) value;
end-pr;

//  Free (or Reset) a Statement Handle
dcl-pr SQLFreeStmt extproc('SQLFreeStmt') like(SQLRETURN_t);
  i_hstmt   like(SQLHSTMT_t) value;
  i_fOption like(SQLSMALLINT_t) value;
end-pr;

//  Disconnect from a Data Source
dcl-pr SQLDisconnect extproc('SQLDisconnect') like(SQLRETURN_t);
  i_hdbc like(SQLHDBC_t) value;
end-pr;

//  Free Connection Handle
dcl-pr SQLFreeConnect extproc('SQLFreeConnect') like(SQLRETURN_t);
  i_hdbc like(SQLHDBC_t) value;
end-pr;

//  Free Environment Handle
dcl-pr SQLFreeEnv extproc('SQLFreeEnv') like(SQLRETURN_t);
  i_henv like(SQLHENV_t) value;
end-pr;

dcl-s rcdLen1 uns(10) inz;
dcl-s rcdLen2 uns(10) inz;

dcl-s cOptVal int(10) inz;
dcl-s retCode like(SQLRETURN_t) inz;
dcl-s hEnv like(SQLHENV_t) inz;
dcl-s hDBc like(SQLHDBC_t) inz;
dcl-s hStmt like(SQLHSTMT_t) inz;
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
g_peekusr = %trim(f_getPrdLb()) + '/' + 'PEEKUSR';

//  Satzlängen vergleichen. Lässt sich eine der Dateien nicht öffnen
//  (z. B. gesperrt), entfällt die Anpassung; den Fehler meldet dann
//  PEEK31 beim Lesen der Einstellungen.
monitor;
  open oldfile;
  rcdLen1 = File_01_DS.RcdLen;
  close oldfile;

  open peekusr;
  rcdLen2 = File_02_DS.RcdLen;
  close peekusr;
on-error;
  if (%open(oldfile));
    close oldfile;
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
    open oldfile;
    rcdLen1 = File_01_DS.RcdLen;
    close oldfile;
  on-error;
    if (%open(oldfile));
      close oldfile;
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

