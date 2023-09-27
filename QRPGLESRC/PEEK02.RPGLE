      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK02                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.09.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Abrufen einer Satzformatbeschreibung über API's              *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  xQFile  - Qualified file name                                *
      *             1 - 10:  file                                     *
      *            11 - 20:  library                                  *
      *                                                               *
      *  xRFmt   - Record format name                                 *
      *                                                               *
      *  xOption - control of modul function                          *
      *     *CREATE  - create list of database relations   CREATE     *
      *     *READ    - get next entry                      READ       *
      *     *DELETE  - delete list                         DELETE     *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  xAnz    - number of entry (depedencies)                      *
      *            parameter is supported using xOption=1 (create)    *
      *                                                               *
      *  xRcdFmtID - record format id                                 *
      *            parameter is supported using xOption=1 (create)    *
      *                                                               *
      *  xListE  - list entry                                         *
      *            parameter is supported using xOption=5 (read)      *
      *            (must be splitted using a data structure)          *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Typical call sequence:                                       *
      *                                                               *
      *      PEEK02 - Funktion (1)       create list                  *
      *                                                               *
      *  1   DO  xAnz                                                 *
      *      PEEK02 - Funktion (5)       read next entry              *
      *      ENDDO                                                    *
      *                                                               *
      *      PEEK02 - Funktion (4)       delete list (user space)     *
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
      /COPY QCOPYLE,FLDL0100
      /COPY QCOPYLE,QUSLFLD
      /COPY QCOPYLE,GENHEADER
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK02
      /undefine internal_prototype
      *
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSCRTUS
     D  qUsrSpc        DS                  likeds(r§qObj)
      *
     D                 DS
     D  SpaceAttr             21     30    INZ
     D  SpaceSize             31     34I 0 INZ
     D  SpaceInit             35     35    INZ
     D  SpaceAut              36     45    INZ
     D  SpaceDesc             46     95    INZ
      *
      *  Pointer for UserSpace
     D  SpacePtr       S               *
      *
      *  Organisation of generic header
     D GenHeader       DS                  likeds(genHeader_t)
     D                                     based(SpacePtr)
      *
     D inputParm       DS                  likeds(QUSLFLD_inpParm_t)
     D                                     based(pInputParm)
      *
      *  Header section of List Fields (QUSLFLD) API
     D header          DS                  likeds(QUSLFLD_header_t)
     D                                     based(pHeader)
      *
      *  Pointer for UserSpace-ListData
     D  ListPtr        S               *
      *  Organisation of list data
     D List            DS                  BASED(ListPtr)
     D  ListData               1    512A
      *
      *  declarations for QUSLFLD
     D                 DS
     D  DRFNME                 1     20
     D   DRFILE                1     10
     D   DRLIB                11     20
     D  DRFMT                 21     28
     D  DRRCDF                31     40
     D  DROVRR                41     41
      *
      *  API error reporting
      /COPY QCOPYLE,API_ERROR
      *
      *  QCMDEXC:
     D YCMD            S            256A   inz
     D YCMDL           S             15P 5 inz
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     D PEEK02          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_option                           const like(r§option)
     D  o_count                                  like(r§int4)
     D  o_listE                                  likeds(FLDL0100_t)
     D  o_rcdFmtId                               like(r§fmtId)
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     i_option      WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     i_option      WHENEQ    '*DELETE'
     C                   EXSR      Delete
     C     i_option      WHENEQ    '*READ'
     C                   EXSR      Read
     C                   Endsl
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *====================================================*
      *  Create --  create user space and get database rel.*
      *====================================================*
      *
     C     Create        BEGSR
      *
     C                   EVAL      o_count = *ZEROS
      *
     C                   EXSR      CHKOBJ
      *
      *  create user space
     C                   IF        (%error())
     C                   CALL      'QUSCRTUS'
     C                   PARM                    qUsrSpc
     C                   PARM      'TEMP'        SpaceAttr
     C                   PARM      32767         SpaceSize
     C                   PARM      ' '           SpaceInit
     C                   PARM      '*ALL'        SpaceAut
     C                   PARM      ' '           SpaceDesc
     C                   Endif
      *
      *  Ausrichten des UserSpace-Pointers
     C                   CALL      'QUSPTRUS'
     C                   PARM                    qUsrSpc
     C                   PARM                    SpacePtr
      *
      *  get file format description
     C                   CALLP     QUSLFLD(qUsrSpc: 'FLDL0100': i_qFile
     C                                     : i_rcdFmt: '0': §ErrorCode)
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      GenHeader.numLstEnt = 0
     C                   Endif
      *
     C                   EVAL      pInputParm = SpacePtr + GenHeader.OffsetInp
     C                   EVAL      pHeader = SpacePtr + GenHeader.OffsetHdr
      *
     C                   EVAL      o_count = GenHeader.NumLstEnt
     C                   EVAL      o_rcdFmtId = Header.rcdFmtID
      *
     C                   ENDSR
      *
      *====================================================*
      *  Delete --  Delete user space                      *
      *====================================================*
      *
     C     Delete        BEGSR
      *
     C                   EXSR      CHKOBJ
      *
     C                   IF        (not %error())
      *
     C                   EVAL      YCMD = 'DLTUSRSPC USRSPC(' +
     C                                      %trim(qUsrSpc.lib) + '/' +
     C                                      %trim(qUsrSpc.name) +
     C                                    ')'
      *
     C                   CALL      'QCMDEXC'
     C                   PARM                    yCmd
     C                   PARM      256           yCmdL
      *
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
     C                   EVAL      o_listE = *BLANKS
      *
     C                   IF        GenHeader.numLstEnt > *ZEROS
      *
     C                   EVAL      ListPtr = SpacePtr + GenHeader.OffsetLst
      *
     C                   EVAL      o_listE = ListData
     C                   EVAL      GenHeader.OffsetLst += GenHeader.EntrySize
     C                   EVAL      GenHeader.NumLstEnt -= 1
      *
     C                   EVAL      o_count = GenHeader.NumLstEnt
     C                   ELSE
      *   Ungültiger Wert in NumLstEnt
     C                   EXSR      *PSSR
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  CHKOBJ --  check existance of user space          *
      *====================================================*
      *
     C     CHKOBJ        BEGSR
      *
     C                   EVAL      YCMD = 'CHKOBJ OBJ(' +
     C                                      %trim(qUsrSpc.lib) + '/' +
     C                                      %trim(qUsrSpc.name) +
     C                                    ') OBJTYPE(*USRSPC)'
      *
     C                   CALL(E)   'QCMDEXC'
     C                   PARM                    yCmd
     C                   PARM      256           yCmdL
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
     C                   ENDSR
      *
      *====================================================*
      *  *PSSR  --  Program error handler                  *
      *====================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   EVAL      o_count = *ZEROS
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
