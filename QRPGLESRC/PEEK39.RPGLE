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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK39
      /undefine internal_prototype
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
      *  declarations for QDBLDB
      /COPY QCOPYLE,DBRL0200
      /COPY QCOPYLE,QDBLDBR
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
     D PEEK39          PI
     D  i_qFile                            const like(r§qObj)
     D  i_mbr                              const like(r§mbr)
     D  i_funk                             const like(r§option)
     D  o_anz                                    like(r§int4)
     D  o_list                                   likeds(DBRL0200_t)
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     i_funk        WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     i_funk        WHENEQ    '*DELETE'
     C                   EXSR      Delete
     C     i_funk        WHENEQ    '*READ'
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
     C                   EVAL      o_anz = 0
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
     C                   CALLP     QDBLDBR(SpaceName: 'DBRL0200'
     C                                     : i_qFile: i_mbr: '': §ErrorCode)
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
     C                   EVAL      o_anz = NumLstEnt
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
     C                   CLEAR                   o_list
      *
     C     NumLstEnt     IFGT      *ZEROS
     C     OffsetLst     IFGE      maxData
      *   Ungültiger Wert in OffsetLst
     C                   EXSR      CallUsAPI
     C                   ELSE
      *
     C                   EVAL      ListPtr = %ADDR(Data(OffsetLst+1))
      *
     C                   EVAL      o_list = ListData
     C                   EVAL      OffsetLst = OffsetLst + EntrySize
     C                   EVAL      NumLstEnt = NumLstEnt - 1
      *
     C                   EVAL      o_anz = NumLstEnt
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
     C                   EVAL      o_list = RtvData
     C                   EVAL      OffsetLst = OffsetLst + EntrySize
     C                   EVAL      NumLstEnt = NumLstEnt - 1
      *
     C                   EVAL      o_anz = NumLstEnt
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
     C                   EVAL      o_anz = 0
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
