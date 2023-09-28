      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.3.3                               *
      *  Programm : PEEK62                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 03.04.2006  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Ändern Satzformat PEEKUSR                         *
      *                                                               *
      *===============================================================*
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FOLDFILE   IF   F32766        DISK    usropn
     F                                     infds(File_01_DS)
     F                                     extfile(g_oldFile)
      *
     FPEEKUSR   IF   E             DISK    usropn
     F                                     infds(File_02_DS)
     F                                     extfile(g_peekusr)
      *
     DFile_01_DS       DS                  likeds(r§infds)
     DFile_02_DS       DS                  likeds(r§infds)
      *
     D g_oldFile       S             21A   inz
     D g_peekusr       S             21A   inz
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK62
      /undefine internal_prototype
      *
     D long_t          S             10I 0                    based(pDummy)
     D short_t         S              5I 0                    based(pDummy)
      *
     D HENV_t          S                   like(long_t      ) based(pDummy)
     D HDBC_t          S                   like(long_t      ) based(pDummy)
     D HSTMT_t         S                   like(long_t      ) based(pDummy)
     D RETCODE_t       S                   like(SQLINTEGER_t) based(pDummy)
     D PTR_t           S               *                    based(pDummy)
      *
     D SQLINTEGER_t    S                   like(long_t      ) based(pDummy)
     D SQLSMALLINT_t   S                   like(short_t     ) based(pDummy)
     D SQLHENV_t       S                   like(HENV_t      ) based(pDummy)
     D SQLHDBC_t       S                   like(HDBC_t      ) based(pDummy)
     D SQLHSTMT_t      S                   like(HSTMT_t     ) based(pDummy)
     D SQLRETURN_t     S                   like(RETCODE_t   ) based(pDummy)
     D SQLPOINTER_t    S                   like(PTR_t     ) based(pDummy)
      *
     D SQL_FALSE       C                   const(  0)
     D SQL_TRUE        C                   const(  1)
     D SQL_NTS         C                   const( -3)
     D SQL_DROP        C                   const(  1)
      *
     D SQL_ATTR_COMMIT...
     D                 C                   const(  0)
     D SQL_COMMIT_NONE...
     D                 C                   const(  1)
      *
      *  Allocate Environment Handle
     D SQLAllocEnv...
     D                 PR                         extproc('SQLAllocEnv')
     D                                     like(SQLRETURN_t )
     D  o_phenv                        *   value
      *
      *  Allocate Connection Handle
     D SQLAllocConnect...
     D                 PR                         extproc('SQLAllocConnect')
     D                                     like(SQLRETURN_t )
     D  i_henv                             value  like(SQLHENV_t   )
     D  o_phdbc                        *   value
      *
      *  Connect to a Data Source
     D SQLConnect...
     D                 PR                         extproc('SQLConnect')
     D                                     like(SQLRETURN_t )
     D  i_hdbc                             value  like(SQLHDBC_t   )
     D  i_szDSN                        *   value  options(*string)
     D  i_cbDSN                            value  like(SQLSMALLINT_t)
     D  i_szUID                        *   value  options(*string)
     D  i_cbUID                            value  like(SQLSMALLINT_t)
     D  i_szAuthStr                    *   value  options(*string)
     D  i_cbAuthStr                        value  like(SQLSMALLINT_t)
      *
      *  Set Connection Option
     D SQLSetConnectOption...
     D                 PR                         extproc('SQLSetConnectOption')
     D                                     like(SQLRETURN_t )
     D  i_hdbc                             value  like(SQLHDBC_t    )
     D  i_fOption                          value  like(SQLSMALLINT_t)
     D  i_vParam                           value  like(SQLPOINTER_t )
      *
      *  Allocate a Statement Handle
     D SQLAllocStmt...
     D                 PR                         extproc('SQLAllocStmt')
     D                                     like(SQLRETURN_t )
     D  i_hdbc                             value  like(SQLHDBC_t   )
     D  o_phstmt                       *   value
      *
      *  Execute a Statement Directly
     D SQLExecDirect...
     D                 PR                         extproc('SQLExecDirect')
     D                                     like(SQLRETURN_t )
     D  i_hstmt                            value  like(SQLHSTMT_t  )
     D  i_szSqlStr                     *   value  options(*string)
     D  i_cbSqlStr                         value  like(SQLINTEGER_t)
      *
      *  Free (or Reset) a Statement Handle
     D SQLFreeStmt...
     D                 PR                         extproc('SQLFreeStmt')
     D                                     like(SQLRETURN_t )
     D  i_hstmt                            value  like(SQLHSTMT_t   )
     D  i_fOption                          value  like(SQLSMALLINT_t)
      *
      *  Disconnect from a Data Source
     D SQLDisconnect...
     D                 PR                         extproc('SQLDisconnect')
     D                                     like(SQLRETURN_t )
     D  i_hdbc                             value  like(SQLHDBC_t   )
      *
      *  Free Connection Handle
     D SQLFreeConnect...
     D                 PR                         extproc('SQLFreeConnect')
     D                                     like(SQLRETURN_t )
     D  i_hdbc                             value  like(SQLHDBC_t   )
      *
      *  Free Environment Handle
     D SQLFreeEnv...
     D                 PR                         extproc('SQLFreeEnv')
     D                                     like(SQLRETURN_t )
     D  i_henv                             value  like(SQLHENV_t   )
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---Allg. Funktionen---------------------------------*
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *----------------------------------------------------*
      *
     D rcdLen1         S             10U 0 inz
     D rcdLen2         S             10U 0 inz
      *
     D cOptVal         S             10I 0                 inz
     D retCode         S                   like(SQLRETURN_t) inz
     D henv            S                   like(SQLHENV_t  ) inz
     D hdbc            S                   like(SQLHDBC_t  ) inz
     D hstmt           S                   like(SQLHSTMT_t ) inz
     D sqlStr          S            512A                     inz
      *
      /COPY QCOPYLE,USR9995
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK62          PI
     D  i_file                             const like(r§file)
     D  i_lib                              const like(r§lib)
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   Eval      g_oldFile = %trim(i_lib ) + '/' +
     C                                         %trim(i_file)
      *
     C                   Open      OLDFILE
     C                   Callp     p_rmvPgmMg(§§PgmName)
      *
     C                   Eval      rcdLen1 = File_01_DS.RcdLen
     C                   Close     OLDFILE
      *
     C                   Eval      g_peekusr = %trim(f_getPrdLb()) + '/' +
     C                                         'PEEKUSR'
      *
     C                   Open      PEEKUSR
     C                   Eval      rcdLen2 = File_02_DS.RcdLen
     C                   Close     PEEKUSR
      *
     C                   If        rcdLen1 <> rcdLen2
      *
     C                   Clear                   USR9995
      *
     C                   Callp     p_sndStsMg('USR9995': USR9995)
      *
     C                   Dou       1=1
      *  Allocate SQL Environment Handle and ...
     C                   Eval      retCode = SQLAllocEnv(%addr(henv))
     C                   If        retCode <> 0
     C                   Leave
     C                   Endif
      *
      *  Allocate SQL Connection Handle
     C                   Eval      retCode = SQLAllocConnect(henv      :
     C                                                     %addr(hdbc) )
     C                   If        retCode <> 0
     C                   Leave
     C                   Endif
      *
      *  ... Set Connection Attribute
     C                   Eval      cOptVal = SQL_COMMIT_NONE
     C                   Eval      retCode = SQLSetConnectOption(hdbc          :
     C                                                          SQL_ATTR_COMMIT:
     C                                                          %addr(cOptVal) )
      *
      *  Connect to Server and ...
     C                   Eval      retCode = SQLConnect(hdbc      :
     C                                                  '*LOCAL'  :
     C                                                  SQL_NTS   :
     C                                                  *null     :
     C                                                  SQL_NTS   :
     C                                                  *null     :
     C                                                  SQL_NTS   )
     C                   If        retCode <> 0
     C                   Leave
     C                   Endif
      *
      *  Allocate Statement Handle
     C                   Eval      retCode = SQLAllocStmt(hdbc       :
     C                                                  %addr(hstmt) )
     C                   If        retCode <> 0
     C                   Leave
     C                   Endif
      *
      *  Execute SQL Statement
     C                   Eval      sqlStr =
     C                               'ALTER TABLE '             +
     C                                 %trim(i_lib) + '.' + %trim(i_file) +
     C                               ' ALTER COLUMN DATA +
     C                                 SET DATA TYPE CHARACTER (256) +
     C                                     NOT NULL WITH DEFAULT'
      *
     C                   Eval      retCode = SQLExecDirect(hstmt    :
     C                                                     sqlStr   :
     C                                                     SQL_NTS  )
     C                   If        retCode <> 0
     C                   Leave
     C                   Endif
      *
     C                   Enddo
      *
      *  Free Statement Handle
     C                   If        hstmt <> 0
     C                   Eval      retCode = SQLFreeStmt(hstmt    :
     C                                                   SQL_DROP )
     C                   Endif
      *
      *  Disconnect from Server
     C                   If        hdbc <> 0
     C                   Eval      retCode = SQLDisconnect(hdbc)
     C                   Endif
      *
      *  Free Connection Handle
     C                   If        hdbc <> 0
     C                   Eval      retCode = SQLFreeConnect(hdbc)
     C                   Endif
      *
      *  Free Environment Handle
     C                   If        henv <> 0
     C                   Eval      retCode = SQLFreeEnv(henv)
     C                   Endif
      *
     C                   Endif
      *
      *  Programm verlassen
     C     ende          Tag
      *
     C                   Return
      *
      *============================================================*
      *  Program error handler                                     *
      *============================================================*
      *
     P errorHandler    b                   
     D                 pi
     D i_condToken                         value likeds(cee_fc_t)
     D i_pCommArea                   10i 0 value
     D o_action                      10i 0
     D o_newCondToken                            likeds(cee_fc_t)
      /free

         dump;
         o_action = CEE_PERCOLATE;

      /end-free
     P                 e
      *
