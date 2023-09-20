      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK10                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.09.96  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Abrufen der verfügbaren Satzformate über API's               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQFile  - Qualified file name                                *
      *             1 - 10:  file                                     *
      *            11 - 20:  library                                  *
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
      *      PEEK10 - Funktion (1)       create list                  *
      *                                                               *
      *  1   DO  XANZ                                                 *
      *      PEEK10 - Funktion (5)       read next entry              *
      *      ENDDO                                                    *
      *                                                               *
      *      PEEK10 - Funktion (4)       delete list (user space)     *
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
     D xQFile          S             20A
     D xFunk           S             10A
     D xAnz            S                   like(r§int4    )
     D xList           S            512A
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QUSCRTUS
     D                 DS
     D  SpaceName              1     20
     D   SpcName               1     10    INZ
     D   SpcLib               11     20    INZ
     D  SpaceAttr             21     30    INZ
     D  SpaceSize             31     34I 0 INZ
     D  SpaceInit             35     35    INZ
     D  SpaceAut              36     45    INZ
     D  SpaceDesc             46     95    INZ
      *
      *  Pointer for UserSpace
     D  SpacePtr       S               *
      *  Organisation of generic header
     D GenHeader       DS                  BASED(SpacePtr)
     D  Data                          1A   DIM(32767)
     D  OffsetHdr            117    120I 0
     D  OffsetLst            125    128I 0
     D  NumLstEnt            133    136I 0
     D  EntrySize            137    140I 0
     D  DataLen        C                   CONST(32767)
      *
      *  Pointer for UserSpace-ListData
     D  ListPtr        S               *
      *  Organisation of list data
     D List            DS                  BASED(ListPtr)
     D  ListData               1    512A
     D  LstDataLen     C                   CONST(512)
      *
     D  maxData        S                   like(r§int4    ) inz
      *
      *  declarations for QUSLFLD
     D                 DS
     D  DRFNME                 1     20
     D   DRFILE                1     10
     D   DRLIB                11     20
     D  DRFMT                 21     28
     D  DROVRR                41     41
      *
      *  API error reporting
      /COPY QCOPYLE,API_ERROR
      *
     D yCmd            S            256A
     D yCmdL           S             15P 5
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    xQFile
     C                   PARM                    xFunk
      *  Output
     C                   PARM                    xAnz
     C                   PARM                    xList
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     XFUNK         WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     XFUNK         WHENEQ    '*DELETE'
     C                   EXSR      Delete
     C     XFUNK         WHENEQ    '*READ'
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
     C                   EVAL      XANZ = *ZEROS
      *
     C                   EXSR      CHKOBJ
      *
      *  create user space
     C     *IN99         IFEQ      '1'
     C                   CALL      'QUSCRTUS'
     C                   PARM                    SpaceName
     C                   PARM      'TEMP'        SpaceAttr
     C                   PARM      32767         SpaceSize
     C                   PARM      ' '           SpaceInit
     C                   PARM      '*ALL'        SpaceAut
     C                   PARM      ' '           SpaceDesc
     C                   Endif
      *
      *  get available record formats
     C                   EVAL      DRFMT = 'RCDL0200'                           format
     C                   EVAL      DRFNME = XQFILE                              qualf.file
     C                   EVAL      DROVRR = '0'                                 override
      *
     C                   CALL      'QUSLRCD'
     C                   PARM                    SpaceName
     C                   PARM                    DRFMT
     C                   PARM                    DRFNME
     C                   PARM                    DROVRR
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      XANZ = *ZEROS
     C                   ELSE
      *  Ausrichten des UserSpace-Pointers
     C                   CALL      'QUSPTRUS'
     C                   PARM                    SpaceName
     C                   PARM                    SpacePtr
      *
     C                   EVAL      XANZ = NumLstEnt
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
     C                   EXSR      CHKOBJ
      *
     C     *IN99         IFEQ      '0'
      *
     C                   EVAL      YCMD = 'DLTUSRSPC USRSPC(' +
     C                                      %trim(SpcLib) + '/' +
     C                                      %trim(SpcName) +
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
     C                   EVAL      XLIST = *BLANKS
      *
     C     NumLstEnt     IFGT      *ZEROS
     C     OffsetLst     IFGE      maxData
      *   Ungültiger Wert in OffsetLst
     C                   EXSR      *PSSR
     C                   ELSE
      *
     C                   EVAL      ListPtr = %ADDR(Data(OffsetLst+1))
      *
     C                   EVAL      XLIST = ListData
     C                   EVAL      OffsetLst = OffsetLst + EntrySize
     C                   EVAL      NumLstEnt = NumLstEnt - 1
      *
     C                   EVAL      XANZ = NumLstEnt
     C                   Endif
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
     C                                      %trim(SpcLib) + '/' +
     C                                      %trim(SpcName) +
     C                                    ') OBJTYPE(*USRSPC)'
      *
     C                   CALL      'QCMDEXC'                            99
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
     C                   EVAL      SpcLib = 'QTEMP'
     C                   EVAL      SpcName = '§PEEK§'
      *
     C                   EVAL      maxData = DataLen - LstDataLen
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
     C                   EVAL      XANZ = *ZEROS
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
