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
      *  declarations for QUSRTVUS
     D  RtvData        S            512A
     D  SpcStrPos      S             10I 0
     D  SpcRtvLen      S             10I 0
      *
      *  declarations for QUSLOBJ
     D                 DS
     D  MBFNME                 1     20
     D   MBFILE                1     10
     D   MBLIB                11     20
     D  MBFMT                 21     28
     D  MBTYPE                31     40
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
     C                   Z-ADD     *ZEROS        XANZ
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
      *  Ausrichten des UserSpace-Pointers
     C                   CALL      'QUSPTRUS'
     C                   PARM                    SpaceName
     C                   PARM                    SpacePtr
      *
      *  get file format description
     C                   MOVEL     'OBJL0200'    MBFMT                          format
     C                   MOVEL     XQFILE        MBFNME                         qualf.file
     C                   MOVEL     '*FILE'       MBTYPE                         obj types
      *
     C                   CALL      'QUSLOBJ'
     C                   PARM                    SpaceName
     C                   PARM                    MBFMT
     C                   PARM                    MBFNME
     C                   PARM                    MBTYPE
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   Z-ADD     *ZEROS        NumLstEnt
     C                   Endif
      *
     C                   Z-ADD     NumLstEnt     XANZ
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
     C                   MOVEL(P)  'DLTUSR'      YCMD
     C                   CAT       'SPC':0       YCMD
     C                   CAT       'USR':1       YCMD
     C                   CAT       'SPC(':0      YCMD
     C                   CAT       SpcLib:0      YCMD
     C                   CAT       '/':0         YCMD
     C                   CAT       SpcName:0     YCMD
     C                   CAT       ')':0         YCMD
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
     C                   MOVE      *BLANKS       XLIST
      *
     C     NumLstEnt     IFGT      *ZEROS
     C     OffsetLst     IFGE      maxData
      *   Ungültiger Wert in OffsetLst
     C                   EXSR      CallUsAPI
     C                   ELSE
      *
     C                   EVAL      ListPtr = %ADDR(Data(OffsetLst+1))
      *
     C                   MOVEL(P)  ListData      XLIST
     C                   ADD       EntrySize     OffsetLst
     C                   SUB       1             NumLstEnt
      *
     C                   Z-ADD     NumLstEnt     XANZ
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
     C                   Z-ADD     EntrySize     SpcRtvLen
     C                   CALL      'QUSRTVUS'
     C                   PARM                    SpaceName
     C                   PARM                    SpcStrPos
     C                   PARM                    SpcRtvLen
     C                   PARM                    RtvData
      *
     C                   MOVEL(P)  RtvData       XLIST
     C                   ADD       EntrySize     OffsetLst
     C                   SUB       1             NumLstEnt
      *
     C                   Z-ADD     NumLstEnt     XANZ
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
     C                   MOVEL(P)  'CHKOBJ'      YCMD
     C                   CAT       'OBJ(':1      YCMD
     C                   CAT       SpcLib:0      YCMD
     C                   CAT       '/':0         YCMD
     C                   CAT       SpcName:0     YCMD
     C                   CAT       ')':0         YCMD
     C                   CAT       'OBJ':1       YCMD
     C                   CAT       'TYPE(':0     YCMD
     C                   CAT       '*USR':0      YCMD
     C                   CAT       'SPC':0       YCMD
     C                   CAT       ')':0         YCMD
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
     C                   MOVEL(P)  'QTEMP'       SpcLib
     C                   MOVEL(P)  '§PEEK§'      SpcName
      *
     C     DataLen       SUB       LstDataLen    maxData
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
     C                   Z-ADD     *ZEROS        XANZ
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
