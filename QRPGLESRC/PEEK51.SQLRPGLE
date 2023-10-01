      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.0.0                               *
      *  Programm : PEEK051                                           *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 15.03.99  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  SQL-Komponente                                               *
      *                                                               *
      * ============================================================= *
      * >>PRE-COMPILER<<                                              *
      *   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
      *                           OBJLIB(&LI) DEVLIB(&LI) +           *
      *                           SBMJOB(*NO) BNDDIR(PEEK) +          *
      *                           INSTALL(*NO);                       *
      *   >>EXECUTE<<                                                 *
      * >>END-PRE-COMPILER<<                                          *
      *===============================================================*
     H NOMAIN
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      * Für Sortierung nach relativer Satznummer
     D g_hFile03       DS                  likeds(hFile_t) inz
      *
     D g_file          S             10A   inz
     D g_lib           S             10A   inz
     D g_mbr           S             10A   inz
     D g_fmt           S             10A   inz
      *
      /COPY QCOPYLE,F_PEEK51
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_CLIB
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *-------------------------------------------------------------------*
     D f_isSqlErr      PR             1A
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D f_sqlMsgID      PR             7A
     D  i_sqlCod                     10I 0 const
      *
      *-------------------------------------------------------------------*
     D p_cvtSqlMg      PR
     D  i_toMsgID                     7A   const
     D  io_msgID                                  like(msgID_t)
     D  io_msgDta                                 like(msgDta_t)
      *
      *-------------------------------------------------------------------*
     D f_getField      PR           512A
     D  i_sqlOrder                  512A   const
      *
      *-------------------------------------------------------------------*
     D f_chgField      PR           512A
     D  i_string                    512A   const
     D  i_rmvOrder                    1A   const
      *
      *  ... Execute Command (QCMDEXC) API
     D QCMDEXC...
     D                 PR                  extpgm('QCMDEXC')
     D  i_cmd                     32702A   const  options(*varsize)
     D  i_length                     15P 5 const
      *
     D g_cmdOvrDbf     S            512A   varying inz
      *
      *===================================================================*
      *  Prozedur:  SQL_prepareStatement                       (Body)     *
      *===================================================================*
      *
     P SQL_prepareStatement...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  i_check                            value  like(bool_t)
     D  i_file                             value  like(file_t)
     D  i_lib                              value  like(lib_t)
     D  i_mbr                              value  like(mbr_t)
     D  i_fmt                              value  like(rcdFmt_t)
     D  i_sqlSelct                  512A   value
     D  i_sqlOrder                  512A   value
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_prepStmt      S              1A
      *
     D i               S             10I 0 inz                                  !
     D sqlSelectStmt   S                   like(sqlStmt_t) inz
     D sqlCountStmt    S                   like(sqlStmt_t) inz
      *
     D pFile           S                   like(file_t) inz
     D pLib            S                   like(lib_t) inz
     D pMbr            S                   like(mbr_t) inz
     D pFmt            S                   like(rcdFmt_t) inz
      *
      * ------------------------------------------------------------------------
      *
     C***                If         f_basedPF(i_file: i_lib: i_mbr: i_fmt: -1
     C***                                     : pFile: pLib: pMbr: pFmt) = bTrue
      *                  go ahead ...
     C***                Else
     C                   Eval       pFile = i_file
     C                   Eval       pLib  = i_lib
     C                   Eval       pMbr  = i_mbr
     C                   Eval       pFmt  = i_fmt
     C***                Endif
      *
      *  ovrDbf
     C                   Eval       g_cmdOvrDbf = 'OVRDBF FILE(FILE03)'       +
     C                                            ' TOFILE('                  +
     C                                            %trim(plib )                +
     C                                            '/'                         +
     C                                            %trim(pfile)                +
     C                                            ')'                         +
     C                                            ' MBR('                     +
     C                                            %trim(pMbr)                 +
     C                                            ')'                         +
     C                                            ' OVRSCOPE(*CALLLVL)'       +
     C                                            ' SHARE(*NO)'               +
     C                                            ' SECURE(*YES)'             +
     C                                            ' SEQONLY(*NO)'
     C                   Callp(E)  QCMDEXC(g_cmdOvrDbf: %len(g_cmdOvrDbf))
      *
      *  Statement ...
     C                   Eval      sqlSelectStmt = 'SELECT'                  +
     C                                             ' RRN(T3)'
      *
      *  ... plus Datei
     C                   Eval      sqlSelectStmt = %trim(sqlSelectStmt)      +
     C                                             ' FROM'                   +
     C                                             ' ' + %trim('FILE03')     +
     C                                             ' T3'
      *
      *  ... plus SELECT
     C                   If        i_sqlSelct <> ' '
     C                   Eval      sqlSelectStmt = %trim(sqlSelectStmt)      +
     C                                             ' WHERE'                  +
     C                                             ' ' + %trim(i_sqlSelct)
     C                   Endif
      *
      *  ... erzeugen COUNT(*) Anweisung
     C                   Eval      i = %scan('RRN(T3)': sqlSelectStmt)
     C                   Eval      sqlCountStmt =
     C                                %replace('COUNT(*)': sqlSelectStmt
     C                                         : i: %len('RRN(T3)'))
      *
      *  ... plus ORDER BY
     C                   If        i_sqlOrder <> ' '
     C                   Eval      sqlSelectStmt = %trim(sqlSelectStmt)      +
     C                                             ' ORDER BY'               +
     C                                             ' ' + %trim(i_sqlOrder)
     C                   Endif
      *
      * SQL-STATEMENT VORBEREITEN
     C                   If        i_check = bTrue
     C/EXEC SQL
     C+ PREPARE g_chkStmt FROM :sqlSelectStmt
     C/END-EXEC
     C                   Else
     C/EXEC SQL
     C+ PREPARE g_prepSelectStmt FROM :sqlSelectStmt
     C/END-EXEC
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bFalse)
     C/EXEC SQL
     C+ PREPARE g_prepCountStmt FROM :sqlCountStmt
     C/END-EXEC
     C                   Endif
     C                   Endif
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
     C                   Eval      f_prepStmt = bFalse
     C                   Eval      g_file = ' '
     C                   Eval      g_lib  = ' '
     C                   Eval      g_mbr  = ' '
     C                   Eval      g_fmt  = ' '
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
      *
     C                   Else
     C                   Eval      f_prepStmt = bTrue
     C                   Eval      g_file = i_file
     C                   Eval      g_lib  = i_lib
     C                   Eval      g_mbr  = i_mbr
     C                   Eval      g_fmt  = i_fmt
     C                   Endif
      *
     C                   Return    f_prepStmt
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_open                                   (Body)     *
      *===================================================================*
      *
     P SQL_open...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_opnSql        S                   like(bool_t) inz(bFalse)
      * ------------------------------------------------------------------------
      *
      *  ovrDbf
     C                   Callp(E)  QCMDEXC(g_cmdOvrDbf: %len(g_cmdOvrDbf))
      *
      * CURSOR fileSQL DEKLARIEREN
     C                   If        sqlCod >= 0
     C/EXEC SQL
     C+ DECLARE g_fileSQL SCROLL CURSOR FOR g_prepSelectStmt
     C/END-EXEC
     C                   Endif
      *
      *
      * CURSOR CS ÖFFNEN
     C                   If        sqlCod >= 0
     C/EXEC SQL
     C+ OPEN g_fileSQL
     C/END-EXEC
     C                   Endif
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
     C                   Callp     CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta)
      *
     C                   Eval      f_opnSql = bFalse
     C                   Else
     C                   If        CIO_open(g_hFile03
     C                                      : g_file
     C                                      : g_lib
     C                                      : g_mbr
     C                                      : g_fmt
     C                                      : 'rr, arrseq=N, commit=N, +
     C                                         nullcap=Y, riofb=Y, +
     C                                         secure=Y') = bTrue
     C                   Eval      *IN99 = *OFF
     C                   Else
     C                   Eval      *IN99 = *ON
     C                   Endif
      *
     C                   If        *IN99 = *ON
     C                   Eval      f_opnSql = bFalse
     C                   Else
     C                   Eval      f_opnSql = bTrue
     C                   Endif
     C                   Endif
      *
      *  Setzen Rückgabeparameter
     C                   Eval      o_hFile = g_hFile03
      *
     C                   Return    f_opnSql
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_nextRow                                (Body)     *
      *===================================================================*
      *
     P SQL_nextRow...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_buffer                                  like(rcdBuf_t)
     D  o_nullMap                                 like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D isEOF           S                   like(bool_t) inz(bTrue)
      *
      *  definieren lokale Variablen ...
     D recNbr          S             10I 0
      *
     D IO_Buff         DS                  based(ptrBuffer)
     D  IO_BuffFld                         like(rcdBuf_t)
      *
     D IO_NullMap      S                   like(nullMap_t)
     D                                     dim(NULL_MAP_SIZE)
     D                                     based(ptrNullMap)
      * ------------------------------------------------------------------------
     C                   Eval      ptrBuffer = %addr(o_buffer )
     C                   Eval      ptrNullMap= %addr(o_nullMap)
      *
      * GET NEXT ROW
     C/EXEC SQL
     C+ FETCH NEXT FROM g_fileSQL INTO :recNbr
     C/END-EXEC
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
     C                   Callp     CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta)
     C                   Eval      isEOF = bTrue
      *
     C                   Else
      *
     C                   If        SQLCODE = 100
     C                   Callp     CIO_setEOF_read(g_hFile03)
     C                   Else
      *
     C                   If        CIO_chainWithRRN(g_hFile03
     C                                              : recNbr
     C                                              : bTrue
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   Eval      isEOF = bTrue
     C                   Else
     C                   Eval      isEOF = bFalse
     C                   Endif                                                  CIO-CHAIN
      *
     C                   Endif                                                  Row not found
      *
     C                   Endif                                                  SQL error
      *
      *  Setzen Rückgabeparameter
     C                   Eval      o_hFile = g_hFile03
      *
     C                   Return    isEOF
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_previousRow                            (Body)     *
      *===================================================================*
      *
     P SQL_previousRow...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_buffer                                  like(rcdBuf_t)
     D  o_nullMap                                 like(nullMap_t)
     D                                            dim(NULL_MAP_SIZE)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D isEOF           S                   like(bool_t) inz(bTrue)
      *
      *  definieren lokale Variablen ...
     D recNbr          S             10I 0
      *
     D IO_Buff         DS                  based(ptrBuffer)
     D  IO_BuffFld                         like(rcdBuf_t)
      *
     D IO_NullMap      S                   like(nullMap_t)
     D                                     dim(NULL_MAP_SIZE)
     D                                     based(ptrNullMap)
      * ------------------------------------------------------------------------
     C                   Eval      ptrBuffer = %addr(o_buffer )
     C                   Eval      ptrNullMap= %addr(o_nullMap)
      *
      * GET NEXT ROW
     C/EXEC SQL
     C+ FETCH PRIOR FROM g_fileSQL INTO :recNbr
     C/END-EXEC
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
     C                   Callp     CIO_setErrorMsg(g_hFile03: o_msgID: o_msgDta)
     C                   Eval      isEOF = bTrue
      *
     C                   Else
      *
     C                   If        SQLCODE = 100
     C                   Callp     CIO_setEOF_readp(g_hFile03)
     C                   Else
      *
     C                   IF        CIO_chainWithRRN(g_hFile03
     C                                              : recNbr
     C                                              : bTrue
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   Eval      isEOF = bTrue
     C                   Else
     C                   Eval      isEOF = bFalse
     C                   Endif                                                  CIO-CHAIN
      *
     C                   Endif                                                  Row not found
      *
     C                   Endif                                                  SQL error
      *
      *  Setzen Rückgabeparameter
     C                   Eval      o_hFile = g_hFile03
      *
     C                   Return    isEOF
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_gotoTop                                (Body)     *
      *===================================================================*
      *
     P SQL_gotoTop...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_topRow        S                   like(bool_t) inz(bFalse)
      *
      * ------------------------------------------------------------------------
      *
      * POSITION BEFORE FIRST ROW
     C/EXEC SQL
     C+ FETCH BEFORE FROM g_fileSQL
     C/END-EXEC
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
      *
     C                   Eval      f_topRow = bFalse
     C                   Else
     C                   Eval      f_topRow = bTrue
     C                   Endif
      *
     C                   Return    f_topRow
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_gotoBottom                             (Body)     *
      *===================================================================*
      *
     P SQL_gotoBottom...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_botRow        S                   like(bool_t) inz(bFalse)
      *
      * ------------------------------------------------------------------------
      *
      * POSITION BEFORE FIRST ROW
     C/EXEC SQL
     C+ FETCH LAST   FROM g_fileSQL
     C/END-EXEC
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
      *
     C                   Eval      f_botRow = bFalse
     C                   Else
     C                   Eval      f_botRow = bTrue
     C                   Endif
      *
     C                   Return    f_botRow
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_close                                  (Body)     *
      *===================================================================*
      *
     P SQL_close...
     P                 B                   Export
     D                 PI                         like(bool_t)
     D  o_hFile                                   likeds(hFile_t)
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_clsSql        S                   like(bool_t) inz(bFalse)
      *
      * ------------------------------------------------------------------------
      *
      * CURSOR CS SCHLIEßEN
     C/EXEC SQL
     C+ CLOSE g_fileSQL
     C/END-EXEC
      *
      * PRÜFUNG AUSWERTEN
     C                   If        (f_isSqlErr(o_msgID :
     C                                         o_msgDta) = bTrue)
      *
     C                   Callp     p_cvtSqlMg('USR8210': o_msgID: o_msgDta)
      *
     C                   Eval      f_clsSql = bFalse
     C                   Else
     C                   IF        CIO_close(g_hFile03) = bTrue
     C                   EVAL      *IN99 = '0'
     C                   ELSE
     C                   EVAL      *IN99 = '1'
     C                   ENDIF
      *
     C                   If        *IN99 = *ON
     C                   Eval      f_clsSql = bFalse
     C                   Else
     C                   Eval      f_clsSql = bTrue
     C                   Eval      g_file = ' '
     C                   Eval      g_lib  = ' '
     C                   Eval      g_mbr  = ' '
     C                   Endif
     C                   Endif
      *
      *  Setzen Rückgabeparameter
     C                   Eval      o_hFile = g_hFile03
      *
     C                   Return    f_clsSql
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  SQL_count                                  (Body)     *
      *===================================================================*
      *
     P SQL_count...
     P                 B                   Export
     D                 PI            10I 0
      *
      *  definieren Funktionswert ...
     D f_count         S             10I 0 inz
      *
      *  definieren Arbeitsfelder
     D msgID           S                   like(msgID_t) inz
     D msgDta          S                   like(msgDta_t) inz
      * ------------------------------------------------------------------------
      *
      *  ovrDbf
     C                   Callp(E)  QCMDEXC(g_cmdOvrDbf: %len(g_cmdOvrDbf))
      *
      * CURSOR fileSQL DEKLARIEREN
     C/EXEC SQL
     C+ DECLARE g_countSQL SCROLL CURSOR FOR g_prepCountStmt
     C/END-EXEC
      *
      * CURSOR CS ÖFFNEN
     C/EXEC SQL
     C+ OPEN g_countSQL
     C/END-EXEC
      *
     C                   If        (f_isSqlErr(msgID: msgDta) = bTrue)
     C                   Return    -1
     C                   Endif
      *
      * GET FIRST ROW
     C/EXEC SQL
     C+ FETCH FIRST FROM g_countSQL INTO :f_count
     C/END-EXEC
      *
     C                   If        (f_isSqlErr(msgID: msgDta) = bTrue)
     C                   Return    -1
     C                   Endif
      *
      * CURSOR CS SCHLIEßEN
     C/EXEC SQL
     C+ CLOSE g_countSQL
     C/END-EXEC
     C                   If        (f_isSqlErr(msgID: msgDta) = bTrue)
     C                   Return    -1
     C                   Endif
      *
     C                   Return    f_count
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_isSqlErr                                 (Body)     *
      *===================================================================*
      *
     P f_isSqlErr      B
     D                 PI             1A
     D  o_msgID                                   like(msgID_t)
     D  o_msgDta                                  like(msgDta_t)
      *
      *  definieren Funktionswert ...
     D f_isSqlErr      S              1A
      *
      *  lokale variablen ...
      *
      * ------------------------------------------------------------------------
     C                   If        sqlCod >= 0
     C                   Eval      o_msgID  = ' '
     C                   Eval      o_msgDta = ' '
     C                   Eval      f_isSqlErr = bFalse
     C                   Else
     C                   Eval      o_msgID  = f_sqlMsgID(SqlCod)
     C                   Eval      o_msgDta = %subst(SqlErm: 1: SqlErl)
     C                   Eval      f_isSqlErr = bTrue
     C                   Endif
      *
     C                   Return    f_isSqlErr
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_sqlMsgID                                 (Body)     *
      *===================================================================*
      *
     P f_sqlMsgID      B
     D                 PI             7A
     D  i_sqlCod                     10I 0 const
      *
      *  definieren Funktionswert ...
     D f_sqlMsgID      S              7A
      *
      *  lokale variablen ...
     D                 DS
     D DS_sqlCod                     10S 0 INZ
     D DS_msgID                       7A   Overlay(DS_sqlCod: 4)
      *
     D idx             S             10I 0 INZ
     D §sqlMsgID       C                   const('SQL0000')
      *
      * ------------------------------------------------------------------------
      *
     C                   Eval      DS_sqlCod = i_sqlCod * -1
      *
     C     1             Do        7             idx
     C                   If        %subst(DS_msgID: idx: 1) = '0'
     C                   Eval      %subst(DS_msgID: idx: 1) =
     C                                 %subst(§sqlMsgID: idx: 1)
     C                   Else
     C                   Leave
     C                   Endif
     C                   Enddo
      *
     C                   Eval      f_sqlMsgID = DS_msgID
      *
     C                   Return    f_sqlMsgID
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  p_cvtSqlMg                                 (Body)     *
      *===================================================================*
      *
     P p_cvtSqlMg      B
     D                 PI
     D  i_toMsgID                     7A   const
     D  io_msgID                                  like(msgID_t)
     D  io_msgDta                                 like(msgDta_t)
      *
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,RTVM0100
      *----------------------------------------------------*
      *
      *  Nachrichten-DS ...
      /COPY QCOPYLE,USR8210
      * ------------------------------------------------------------------------
      *
     C                   Clear                   USR8210
     C                   Eval      USR82101   = io_msgID
     C                   Eval      USR82102   = f_msgText(io_msgID : io_msgDta:
     C                                                    'QSQLMSG': 'QSYS'   )
      *
     C                   Eval      io_msgID   = 'USR8210'
     C                   Eval      io_msgDta  = USR8210
      *
     C                   Return
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_getField                                 (Body)     *
      *===================================================================*
      *
     P f_getField      B
      *
      *  definieren Procedure Interface ...
     D f_getField      PI           512A
     D  i_sqlOrder                  512A   const
      * ------------------------------------------------------------------------
      *
     C                   Return    f_chgField(i_sqlOrder: bTrue)
      *
     P f_getField      E
      *
      *===================================================================*
      *  Prozedur:  SQL_quote                                  (Body)     *
      *===================================================================*
      *
     P SQL_quote...
     P                 B                   export
     D                 PI           512A
     D  i_string                    512A   const
      * ------------------------------------------------------------------------
      *
     C                   Return    f_chgField(i_string: bFalse)
      *
     P                 E
      *
      *===================================================================*
      *  Prozedur:  f_chgField                                 (Body)     *
      *===================================================================*
      *
     P f_chgField      B
     D                 PI           512A
     D  i_string                    512A   const
     D  i_rmvOrder                    1A   const
      *
      *  definieren Funktionswert ...
     D f_chgField      S            512A
      *
     D x               S                   like(int4_t) inz
     D y               S                   like(int4_t) inz
     D lenStr          S                   like(int4_t) inz
      *
     D isHyphen        S              1A   inz
     D isField         S              1A   inz
     D isOrder         S              1A   inz
      *
     D waitField       S              1A   inz
     D waitOrder       S              1A   inz
      * ------------------------------------------------------------------------
      *
     C                   Eval      y = 0
     C                   Eval      lenStr = f_len(i_string)
      *
     C                   Eval      isHyphen  = bFalse
     C                   Eval      isField   = bFalse
     C                   Eval      isOrder   = bFalse
      *
     C                   Eval      waitField = bTrue
     C                   Eval      waitOrder = bFalse
      *
     C     1             Do        lenStr        x
     C                   If        y = f_len(f_chgField)
     C                   Leave
     C                   Endif
      *
      *  Prüfen auf Hochkomma ...
     C                   If        (%subst(i_string: x: 1) = '"')  or
     C                             (%subst(i_string: x: 1) = '''')
     C                   If        isHyphen = bTrue
     C                   Eval      isHyphen = bFalse
     C                   Else
     C                   Eval      isHyphen = bTrue
     C                   Endif
     C                   Endif
      *
      *  Überlesen in Hochkomma eingeschlossene Felder ...
     C                   If        (isHyphen = bTrue)      and
     C                             (isField  = bTrue)
     C                   Eval      y = y + 1
     C                   Eval      %subst(f_chgField: y: 1) =
     C                                %subst(i_string: x: 1)
     C                   Iter
     C                   Endif
      *
      *  Festellen Feldanfang ...
     C                   Select
     C                   When      (%subst(i_string: x: 1) <> ' ')  and
     C                             (waitField = bTrue)
     C                   Eval      isField = bTrue
     C                   Eval      isOrder = bFalse
     C                   Eval      waitField = bFalse
     C                   Eval      waitOrder = bFalse
      *
     C                   If        (%subst(i_string: x: 1) <> '"')
     C                   Eval      y = y + 1
     C                   Eval      %subst(f_chgField: y: 1) = '"'
     C                   Endif
      *
      *  Festellen Feldende ...
     C                   When      ((%subst(i_string: x: 1) =   ' ')  or
     C                              (%subst(i_string: x: 1) =   ',')  or
     C                              (%subst(i_string: x: 1) =   '"')  or
     C                              (%subst(i_string: x: 1) =  '''')) and
     C                             (isField   = bTrue)                   and
     C                             (waitField = bFalse)
     C                   Eval      isField   = bFalse
     C                   Eval      isOrder   = bFalse
     C                   Eval      waitField = bFalse
     C                   Eval      waitOrder = bTrue
      *
     C                   If        (%subst(i_string: x: 1) <> '"')
     C                   Eval      y = y + 1
     C                   Eval      %subst(f_chgField: y: 1) = '"'
     C                   Endif
      *
      *  Festellen Orderanfang ...
     C                   When      (%subst(i_string: x: 1) <> ' ')  and
     C                             (waitOrder = bTrue)
     C                   Eval      isField = bFalse
     C                   Eval      isOrder = bTrue
     C                   Eval      waitField = bFalse
     C                   Eval      waitOrder = bFalse
      *
      *  Festellen Orderende ...
     C                   When      ((%subst(i_string: x: 1) =   ' ')  or
     C                              (%subst(i_string: x: 1) =   ',')  or
     C                              (%subst(i_string: x: 1) =   '"')  or
     C                              (%subst(i_string: x: 1) =  '''')) and
     C                             (isOrder   = bTrue)                   and
     C                             (waitOrder = bFalse)
     C                   Eval      isField   = bFalse
     C                   Eval      isOrder   = bFalse
     C                   Eval      waitField = bTrue
     C                   Eval      waitOrder = bFalse
     C                   Endsl
      *
      *  Trennzeichen  ...
     C                   If        (%subst(i_string: x: 1) =  ',')
     C                   Eval      isField   = bFalse
     C                   Eval      isOrder   = bFalse
     C                   Eval      waitField = bTrue
     C                   Eval      waitOrder = bFalse
     C                   Endif
      *
      *  Löschen Order ...
     C                   If        (isOrder    = bTrue)  and
     C                             (i_rmvOrder = bTrue)
      ***                Eval      y = y + 1
      ***                Eval      %subst(f_chgField: y: 1) = ' '
     C                   Else
     C                   Eval      y = y + 1
     C                   Eval      %subst(f_chgField: y: 1) =
     C                                %subst(i_string: x: 1)
     C                   Endif
      *
     C                   Enddo
      *
     C                   Return    f_chgField
      *
     P                 E
      *
