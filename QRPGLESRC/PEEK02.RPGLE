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
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     D xQFile          S             20A
     D xRFmt           S             10A
     D xOption         S             10A
     D xAnz            S                   like(r§int4    )
     D xRcdFmtID       S                   like(r§fmtId   )
     D xListE          S            512A
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
      *
      *  Organisation of generic header
     D GenHeader       DS                  BASED(SpacePtr)  QUALIFIED
     D  sizeHeader            65     68I 0
     D  release_Level         69     72A
     D  format                72     80A
     D  api_used              81     90A
     D  crtDateTime           91    103A
     D  infStatus            104    104A
     D  sizeUsed             105    108I 0
     D  OffsetInp            109    112I 0
     D  sizeInz              113    116I 0
     D  OffsetHdr            117    120I 0
     D  sizeHdr              121    124I 0
     D  OffsetLst            125    128I 0
     D  sizeLst              129    132I 0
     D  NumLstEnt            133    136I 0
     D  EntrySize            137    140I 0
     D  DataLen        C                   CONST(32767)
      *
      *  Input parameter section of List Fields (QUSLFLD) API
     D inputParm       DS                  qualified based(pInputParm)
     D  usrSpcName             1     10A
     D  usrSpcLib             11     20A
     D  format                21     28A
     D  file                  29     38A
     D  lib                   39     48A
     D  rcdFmt                49     58A
     D  override              59     59A
      *
      *  Header section of List Fields (QUSLFLD) API
     D header          DS                  qualified based(pHeader)
     D  fileUsed               1     10A
     D  libUsed               11     20A
     D  type                  21     30A
     D  rcdFmt                31     40A
     D  rcdLen                41     44I 0
     D  rcdFmtID              45     57A
     D  rcdTextDesc           58    107A
     D  reserved_1           108    108A
     D  rcdTextCcsid         109    112I 0
     D  varLenFldInd         113    113A
     D  grphFldInd           114    114A
     D  datTimFldInd         115    115A
     D  nullFldInd           116    116A
      *
      *  Pointer for UserSpace-ListData
     D  ListPtr        S               *
      *  Organisation of list data
     D List            DS                  BASED(ListPtr)
     D  ListData               1    512A
     D  LstDataLen     C                   CONST(512)
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
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    xQFile
     C                   PARM                    xRFmt
     C                   PARM                    xOption
      *  Output
     C                   PARM                    xAnz
     C                   PARM                    xListE
     C                   PARM                    xRcdFmtId
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     xOption       WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     xOption       WHENEQ    '*DELETE'
     C                   EXSR      Delete
     C     xOption       WHENEQ    '*READ'
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
     C                   Z-ADD     *ZEROS        xAnz
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
     C                   MOVEL     'FLDL0100'    DRFMT                          format
     C                   MOVEL     xQFile        DRFNME                         qualf.file
     C                   MOVEL     xRFmt         DRRCDF                         record form.
     C                   MOVEL     '0'           DROVRR                         override
      *
     C                   CALL      'QUSLFLD'
     C                   PARM                    SpaceName
     C                   PARM                    DRFMT
     C                   PARM                    DRFNME
     C                   PARM                    DRRCDF
     C                   PARM                    DROVRR
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      GenHeader.numLstEnt = 0
     C                   Endif
      *
     C                   EVAL      pInputParm = SpacePtr + GenHeader.OffsetInp
     C                   EVAL      pHeader = SpacePtr + GenHeader.OffsetHdr
      *
     C                   EVAL      xAnz = GenHeader.NumLstEnt
     C                   EVAL      xRcdFmtID = Header.rcdFmtID
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
     C                   MOVE      *BLANKS       xListE
      *
     C                   IF        GenHeader.numLstEnt > *ZEROS
      **   OffsetLst     IFGE      maxData     TODO: remove this code
      *   Ungültiger Wert in OffsetLst
      **                 EXSR      CallUsAPI
      **                 ELSE
      *
     C                   EVAL      ListPtr = SpacePtr + GenHeader.OffsetLst
      *
     C                   EVAL      xListE = ListData
     C                   EVAL      GenHeader.OffsetLst += GenHeader.EntrySize
     C                   EVAL      GenHeader.NumLstEnt -= 1
      *
     C                   EVAL      xAnz = GenHeader.NumLstEnt
      **                 Endif
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
      *                                                            TODO: remove this code
     C     CallUsAPI     BEGSR
      *
      **   NumLstEnt     IFGT      *ZEROS
      *
      **                 EVAL      SpcStrPos = OffsetLst+1
      *
      **                 Z-ADD     EntrySize     SpcRtvLen
      **                 CALL      'QUSRTVUS'
      **                 PARM                    SpaceName
      **                 PARM                    SpcStrPos
      **                 PARM                    SpcRtvLen
      **                 PARM                    RtvData
      *
      **                 MOVEL(P)  RtvData       xListE
      **                 ADD       EntrySize     OffsetLst
      **                 SUB       1             NumLstEnt
      *
      **                 Z-ADD     NumLstEnt     xAnz
      *
      **                 ELSE
      *   Ungültiger Wert in NumLstEnt
      **                 EXSR      *PSSR
      **                 Endif
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
      **   DataLen       SUB       LstDataLen    maxData           TODO: remove this code
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
     C                   Z-ADD     *ZEROS        xAnz
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
