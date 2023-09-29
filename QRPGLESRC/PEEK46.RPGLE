      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK46                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 11.12.98  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Ermitteln Teildateiliste                          *
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
      *      PEEK46 - Funktion (*CREATE) create list                  *
      *                                                               *
      *  1   DO  XANZ                                                 *
      *      PEEK46 - Funktion (*READ)   read next entry              *
      *      ENDDO                                                    *
      *                                                               *
      *      PEEK46 - Funktion (*DELETE) delete list (user space)     *
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
     H main(PEEK46)
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,MBRL0200
      /COPY QCOPYLE,GENHEADER
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK46
      /undefine internal_prototype
      *
      /COPY QCOPYLE,QUSLMBR
      *
     D  qUsrSpc        DS                  likeds(qObj_t) inz
     D  pSpcPtr        S               *
     D  errCode        DS                  likeds(errCode_t) inz
      *
      *  Organisation of generic header
     D GenHeader       DS                  likeds(genHeader_t) based(pSpcPtr)
      *
      *  List data
     D currListE       S                   like(int4_t)
     D offsetListE     S                   like(int4_t)
     D pListE          S               *
     D listE           DS                  likeds(mbrl0200_t) based(pListE)
      *
      /COPY QCOPYLE,QUSCRTUS
      /COPY QCOPYLE,QUSPTRUS
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
     D msgId           S                   like(msgId_t)
     D msgDta          S                   like(msgDta_t)
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     P PEEK46          B
     D                 PI
     D  i_qFile                            const likeds(qObj_t)
     D  i_mbr                              const like(mbr_t)
     D  i_function                         const like(function_t)
     D  o_numE                                   like(int4_t)
     D  o_mbrl0200                               likeds(mbrl0200_t)
      *
      *---------------------------------------------------*
      *
     C                   EVAL      qUsrSpc.lib = USRSPC_LIBRARY
     C                   EVAL      qUsrSpc.name = USRSPC_NAME
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
      *  get file member list
     C                   CALLP     QUSLMBR(qUsrSpc: 'MBRL0200'
     C                                     : i_qFile: i_mbr: '0': errCode)
      *
     C                   If        (errCode.bytAvl > 0)
     C                   Eval      o_numE = 0
     C                   Eval      currListE = -1
     C                   Else
     C                   Eval      o_numE = GenHeader.NumLstEnt
     C                   Eval      currListE = 0
     C                   Endif
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
     C                   Clear                   o_mbrl0200
      *
     C                   IF        (currListE < 0 or
     C                              currListE >= GenHeader.NumLstEnt)
     C                   Exsr      setError
     C                   Leavesr
     C                   ENDIF
      *
     C                   Eval      currListE = currListE + 1
      *
     C                   Eval      offsetListE =
     C                               GenHeader.OffsetLst +
     C                               ((currListE - 1) * GenHeader.EntrySize)
      *
     C                   EVAL      pListE = pSpcPtr + offsetListE
      *
     C                   EVAL      o_mbrl0200 = listE
      *
     C                   EVAL      o_numE = GenHeader.NumLstEnt - currListE
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
     P                 E
      *
