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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT

       dcl-f oldfile disk(32766) usropn infds(file_01_ds) extfile(g_oldfile);

       dcl-f peekusr usropn infds(file_02_ds) extfile(g_peekusr);

       dcl-ds file_01_ds likeds(infds_t);
       dcl-ds file_02_ds likeds(infds_t);

       dcl-s g_oldfile char(21) inz;
       dcl-s g_peekusr char(21) inz;

      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,ERR_D_SDS
      /COPY QCOPYLE,CEECNDHDLR

      /COPY QCOPYLE,USR9995

      /define internal_prototype
      /COPY QCOPYLE,PPEEK62
      /undefine internal_prototype

      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58

       dcl-s long_t          int(10) template;
       dcl-s short_t         int(5) template;

       dcl-s henv_t          like(long_t) template;
       dcl-s hdbc_t          like(long_t) template;
       dcl-s hstmt_t         like(long_t) template;
       dcl-s retcode_t       like(sqlinteger_t) template;
       dcl-s ptr_t           pointer template;

       dcl-s sqlinteger_t    like(long_t) template;
       dcl-s sqlsmallint_t   like(short_t) template;
       dcl-s sqlhenv_t       like(henv_t) template;
       dcl-s sqlhdbc_t       like(hdbc_t) template;
       dcl-s sqlhstmt_t      like(hstmt_t) template;
       dcl-s sqlreturn_t     like(retcode_t) template;
       dcl-s sqlpointer_t    like(ptr_t) template;

       dcl-c SQL_NTS  -3;
       dcl-c SQL_DROP 1;

       dcl-c sql_attr_commit 0;
       dcl-c sql_commit_none 1;

       //  Allocate Environment Handle
       dcl-pr sqlallocenv extproc('SQLAllocEnv') like(sqlreturn_t  );
         o_phenv         pointer value;
       end-pr;

       //  Allocate Connection Handle
       dcl-pr sqlallocconnect extproc('SQLAllocConnect') like(sqlreturn_t);
         i_henv          value  like(sqlhenv_t);
         o_phdbc         pointer value;
       end-pr;

       //  Connect to a Data Source
       dcl-pr sqlconnect extproc('SQLConnect') like(sqlreturn_t);
         i_hdbc          value  like(sqlhdbc_t);
         i_szdsn         pointer value  options(*string);
         i_cbdsn         value  like(sqlsmallint_t);
         i_szuid         pointer value  options(*string);
         i_cbuid         value  like(sqlsmallint_t);
         i_szauthstr     pointer value  options(*string);
         i_cbauthstr     value  like(sqlsmallint_t);
       end-pr;

       //  Set Connection Option
       dcl-pr sqlsetconnectoption
                         extproc('SQLSetConnectOption') like(sqlreturn_t);
         i_hdbc          value  like(sqlhdbc_t);
         i_foption       value  like(sqlsmallint_t);
         i_vparam        value  like(sqlpointer_t);
       end-pr;

       //  Allocate a Statement Handle
       dcl-pr sqlallocstmt extproc('SQLAllocStmt') like(sqlreturn_t);
         i_hdbc          value  like(sqlhdbc_t);
         o_phstmt        pointer value;
       end-pr;

       //  Execute a Statement Directly
       dcl-pr sqlexecdirect extproc('SQLExecDirect') like(sqlreturn_t);
         i_hstmt         value  like(sqlhstmt_t);
         i_szsqlstr      pointer value  options(*string);
         i_cbsqlstr      value  like(sqlinteger_t);
       end-pr;

       //  Free (or Reset) a Statement Handle
       dcl-pr sqlfreestmt extproc('SQLFreeStmt') like(sqlreturn_t);
         i_hstmt         value  like(sqlhstmt_t);
         i_foption       value  like(sqlsmallint_t);
       end-pr;

       //  Disconnect from a Data Source
       dcl-pr sqldisconnect extproc('SQLDisconnect') like(sqlreturn_t);
         i_hdbc          value  like(sqlhdbc_t);
       end-pr;

       //  Free Connection Handle
       dcl-pr sqlfreeconnect extproc('SQLFreeConnect') like(sqlreturn_t );
         i_hdbc          value  like(sqlhdbc_t);
       end-pr;

       //  Free Environment Handle
       dcl-pr sqlfreeenv extproc('SQLFreeEnv') like(sqlreturn_t);
         i_henv          value  like(sqlhenv_t);
       end-pr;

       dcl-s rcdLen1         uns(10) inz;
       dcl-s rcdLen2         uns(10) inz;

       dcl-s cOptVal         int(10) inz;
       dcl-s retCode         like(sqlreturn_t) inz;
       dcl-s hEnv            like(sqlhenv_t  ) inz;
       dcl-s hDBc            like(sqlhdbc_t  ) inz;
       dcl-s hStmt           like(sqlhstmt_t ) inz;
       dcl-s sqlStr          char(512) inz;

       //*******************************************************************
       //                 S T E U E R  -  R O U T I N E                    *
       //*******************************************************************

       dcl-pi peek62;
         i_file          const like(file_t);
         i_lib           const like(lib_t);
       end-pi;
       //---------------------------------------------------*

       //  Register error handler
       ceehdlr(%paddr('errorHandler')
              : *null: *omit);

       g_oldfile = %trim(i_lib ) + '/' + %trim(i_file);

       open oldfile;
       p_rmvpgmmg(§§pgmname);

       rcdLen1 = file_01_ds.rcdlen;
       close oldfile;

       g_peekusr = %trim(f_getprdlb()) + '/' + 'PEEKUSR';

       open peekusr;
       rcdLen2 = file_02_ds.rcdlen;
       close peekusr;

         if (rcdLen1 <> rcdLen2);

          clear usr9995;

          p_sndstsmg('USR9995': usr9995);

          dou 1=1;
             //  Allocate SQL Environment Handle and ...
             retCode = sqlallocenv(%addr(hEnv));
             if (retCode <> 0);
                leave;
             endif;

             //  Allocate SQL Connection Handle
             retCode = sqlallocconnect(hEnv: %addr(hDBc));
             if (retCode <> 0);
                leave;
             endif;

             //  ... Set Connection Attribute
             cOptVal = sql_commit_none;
             retCode = sqlsetconnectoption(hDBc
                                           : sql_attr_commit: %addr(cOptVal));

             //  Connect to Server and ...
             retCode = sqlconnect(hDBc: '*LOCAL': SQL_NTS
                                  : *null: SQL_NTS: *null: SQL_NTS);
             if (retCode <> 0);
                leave;
             endif;

             //  Allocate Statement Handle
             retCode = sqlallocstmt(hDBc: %addr(hStmt));
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

             retCode = sqlexecdirect(hStmt: sqlStr: SQL_NTS);
             if (retCode <> 0);
                leave;
             endif;

          enddo;

          //  Free Statement Handle
          if (hStmt <> 0);
             retCode = sqlfreestmt(hStmt: SQL_DROP);
          endif;

          //  Disconnect from Server
          if (hDBc <> 0);
             retCode = sqldisconnect(hDBc);
          endif;

          //  Free Connection Handle
          if (hDBc <> 0);
             retCode = sqlfreeconnect(hDBc);
          endif;

          //  Free Environment Handle
          if (hEnv <> 0);
             retCode = sqlfreeenv(hEnv);
          endif;

       endif;

       return;

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

