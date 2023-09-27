      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.2.4                               *
      *  Programm : PEEK70                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 05.11.2010  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Ermitteln Dateiliste                              *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQFILE  - Qualified file name                                *
      *             1 - 10:  file                                     *
      *            11 - 20:  library                                  *
      *                                                               *
      *  XRFMT   - Record format name                                 *
      *                                                               *
      *  XFUNK   - control of modul function                          *
      *     *CREATE  - create list of database relations   CREATE     *
      *     *READ    - get next entry                      READ       *
      *     *DELETE  - delete list                         DELETE     *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XANZ    - number of entry (depedencies)                      *
      *            parameter is supported using XFUNK=1   (create)    *
      *                                                               *
      *  XLIST   - entry                                              *
      *            parameter is supported using XFUNK=5   (read)      *
      *            (must be splitted using a data structure)          *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Typical call sequence:                                       *
      *                                                               *
      *      PEEK70 - Funktion (*CREATE) create list                  *
      *                                                               *
      *  1   DO  XANZ                                                 *
      *      PEEK70 - Funktion (*READ)   read next entry              *
      *      ENDDO                                                    *
      *                                                               *
      *      PEEK70 - Funktion (*DELETE) delete list (user space)     *
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
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,OBJL0200
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK70
      /undefine internal_prototype
      *
      /COPY QCOPYLE,QUSLOBJ
      *
     D  qUsrSpc        DS                  likeds(r§qObj) inz
     D  pSpcPtr        S               *
     D  errCode        DS                  likeds(errCode_t) inz
      *
      *  Organisation of generic header
     D GenHeader       DS                  BASED(pSpcPtr)
     D  Data                          1A   DIM(32767)
     D  OffsetHdr            117    120I 0
     D  OffsetLst            125    128I 0
     D  maxListE             133    136I 0
     D  NumLstEnt            133    136I 0
     D  EntrySize            137    140I 0
     D  DataLen        C                   CONST(32767)
      *
      *  Pointer for UserSpace-ListData
     D  ListPtr        S               *
      *
      *  Organisation of list data
     D List            DS                  BASED(ListPtr)
     D  ListData               1    512A
     D  LstDataLen     C                   CONST(512)
      *
     D  maxData        S                   like(r§int4    ) inz
      *
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
     D msgId           S                   like(r§msgId)
     D msgDta          S                   like(r§msgDta)
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     D PEEK70          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_function                         const like(r§function)
     D  o_numE                                   like(r§int4)
     D  o_objl0200                               likeds(objl0200_t)
      *---------------------------------------------------*
      *
     C                   monitor
      *
     C                   SELECT
     C                   WHEN      (i_function = '*CREATE')
     C                   EXSR      Create
     C                   WHEN      (i_function = '*DELETE')
     C                   EXSR      Delete
     C                   WHEN      (i_function = '*READ')
     C                   EXSR      Read
     C                   Endsl
      *
     C                   on-error
     C                   dump
     C                   eval      o_numE = 0
     C                   endmon
      *
     C                   RETURN
      *
      *====================================================*
      *  Create --  create user space and get database rel.*
      *====================================================*
      *
     C     Create        BEGSR
      *
     C                   EVAL      o_numE = *ZEROS
      *
      *  create user space
     C                   IF        (not f_exist(
     C                                qUsrSpc.name: qUsrSpc.lib: '*USRSPC'))
     C                   Callp     QUSCRTUS(qUsrSpc: 'TEMP': 32767: x'00'
     C                                      : '*ALL': 'Peek/400 - Work Area')
     C                   Endif
      *
      *  get user space pointer
     C                   Callp     QUSPTRUS(qUsrSpc: pSpcPtr)
      *
      *  get file format description
     C                   Callp     QUSLOBJ(qUsrSpc: 'OBJL0200'
     C                                     : i_qFile: '*FILE': errCode)
      *
     C                   If        (errCode.bytAvl > 0)
     C                   EVAL      NumLstEnt = 0
     C                   Endif
      *
     C                   EVAL      maxListE = NumLstEnt
     C                   EVAL      o_numE = NumLstEnt
      *
     C                   ENDSR
      *
      *====================================================*
      *  Delete --  Delete user space                      *
      *====================================================*
      *
     C     Delete        BEGSR
      *
     C                   IF        (f_exist(
     C                                qUsrSpc.name: qUsrSpc.lib: '*USRSPC'))
     C
     C                   Callp     f_execute('DLTUSRSPC USRSPC(' +
     C                                         %trim(qUsrSpc.lib) + '/' +
     C                                         %trim(qUsrSpc.name) +
     C                                       ')': msgId: msgDta)
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  Read   --  Read next entry                        *
      *====================================================*
      *
     C     Read          BEGSR
      *
     C                   Clear                   o_objl0200
      *
     C                   IF        (NumLstEnt <= 0)
     C                   Exsr      setError
     C                   Leavesr
     C                   ENDIF
      *
     C                   IF        (OffsetLst >= maxData)
     C                   Exsr      setError
     C                   Leavesr
     C                   ENDIF
      *
     C                   EVAL      ListPtr = %ADDR(Data(OffsetLst+1))
      *
     C                   EVAL      o_objl0200 = ListData
     C                   EVAL      OffsetLst = OffsetLst + EntrySize
     C                   EVAL      NumLstEnt = NumLstEnt - 1
      *
     C                   EVAL      o_numE = NumLstEnt
      *
     C                   ENDSR
      *
      *====================================================*
      *  Set error condition                               *
      *====================================================*
      *
     C     setError      BEGSR
      *
     C                   EVAL      o_numE = 0
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   EVAL      qUsrSpc.lib = 'QTEMP'
     C                   EVAL      qUsrSpc.name = '§PEEK§'
      *
     C                   EVAL      maxData = DataLen - LstDataLen
      *
     C                   ENDSR
      *
