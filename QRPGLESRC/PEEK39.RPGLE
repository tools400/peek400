      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK39                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 20.03.98  RADDATZ                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Ermitteln Datenbankrelationen                     *
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
      *      PEEK39 - Funktion (1)       create list                  *
      *                                                               *
      *  1   DO  XANZ                                                 *
      *      PEEK39 - Funktion (5)       read next entry              *
      *      ENDDO                                                    *
      *                                                               *
      *      PEEK39 - Funktion (4)       delete list (user space)     *
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
     D xMbr            S             10A
     D xFunk           S             10A
     D xAnz            S                   like(r§int4    )
     D xList           S            512A
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Externe Protoypen--------------------------------*
      *
     D size_t          S             10U 0 based(pDummy)
      *
      *  qsort -- Sort Array
     D qsort           PR              *                       extproc('qsort')
     D  memPtr                         *   value
     D  numElem                            value  like(size_t)
     D  width                              value  like(size_t)
     D  pSortFunc                      *   value  procptr
      *
      *---Interne Protoypen--------------------------------*
      *
      *  Sort List Entries by Name                         *
     D sortByName      PR            10I 0
     D  i_pKey                         *   value
     D  i_pElm                         *   value
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
      *  declarations for QUSRTVUS
     D  RtvData        S            512A
     D  SpcStrPos      S             10I 0
     D  SpcRtvLen      S             10I 0
      *
      *  declarations for QDBLDBR
     D                 DS
     D  DRQFile                1     20    INZ
     D   DRFile                1     10
     D   DRLib                11     20
     D  DRMbr          S             10A   INZ
     D  DRFormat       S              8A   INZ
     D  DRRcdFmt       S             10A   INZ
      *
      *  API error reporting
      /COPY QCOPYLE,API_ERROR
      *
     D yCmd            S            256A   inz
     D yCmdL           S             15P 5 inz
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    xQFile
     C                   PARM                    xMbr
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
      *  get database relations
     C                   EVAL      DRFormat = 'DBRL0200'                        format
     C                   EVAL      DRQFile = XQFile                             qualf.filename
     C                   EVAL      DRMbr = XMbr                                 file member
      *
     C                   CALL      'QDBLDBR'
     C                   PARM                    SpaceName                      User space
     C                   PARM                    DRFormat                       Format name
     C                   PARM                    DRQFile                        qualf.filename
     C                   PARM                    DRMbr                          file member
     C                   PARM                    DRRcdFmt                       Record format
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      NumLstEnt = *ZEROS
     C                   ELSE
      *  Ausrichten des UserSpace-Pointers
     C                   CALL      'QUSPTRUS'
     C                   PARM                    SpaceName
     C                   PARM                    SpacePtr
      *
      *  Sortieren nach Dateinamen
     C                   CALLP     qSort(SpacePtr + OffsetLst
     C                                   : NumLstEnt: EntrySize
     C                                   : %paddr(sortByName))
     C                   Endif
      *
     C                   EVAL      XANZ = NumLstEnt
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
     C                   EXSR      CallUsAPI
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
      *  CallUsAPI  Abrufen Werte aus UserSpace mittels API*
      *====================================================*
      *
     C     CallUsAPI     BEGSR
      *
     C     NumLstEnt     IFGT      *ZEROS
      *
     C                   EVAL      SpcStrPos = OffsetLst+1
      *
     C                   EVAL      SpcRtvLen = EntrySize
     C                   CALL      'QUSRTVUS'
     C                   PARM                    SpaceName
     C                   PARM                    SpcStrPos
     C                   PARM                    SpcRtvLen
     C                   PARM                    RtvData
      *
     C                   EVAL      XLIST = RtvData
     C                   EVAL      OffsetLst = OffsetLst + EntrySize
     C                   EVAL      NumLstEnt = NumLstEnt - 1
      *
     C                   EVAL      XANZ = NumLstEnt
      *
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
      *====================================================*
      *  Sort List Entries by Name                         *
      *====================================================*
     P sortByName      B
     D sortByName      PI            10I 0
     D  i_pKey                         *   value
     D  i_pElm                         *   value
      *
     D key             DS                  qualified   based(i_pKey)
     D  depFile               31     40A
     D  depLib                41     50A
     D  depMbr                51     60A
      *
     D elm             DS                  likeds(key) based(i_pElm)
      * - - - - - - - - - - - - - - - - - - - - - - - - - -
      /FREE

         select;
         when (key.depLib < elm.depLib);
            return -1;
         when (key.depLib > elm.depLib);
            return 1;
         other;
            select;
            when (key.depFile < elm.depFile);
               return -1;
            when (key.depFile > elm.depFile);
               return 1;
            other;
               return 0;
            endsl;
         endsl;

      /END-FREE
      *
     P sortByName      E
      *
