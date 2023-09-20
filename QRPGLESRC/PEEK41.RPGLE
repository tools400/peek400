      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK41                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 31.12.1997  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Abrufen von Dateiinformationen einer Datei                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XQFile      - Qualified file name                            *
      *                  1 - 10:  file                                *
      *                 11 - 20:  library                             *
      *                                                               *
      *  XRcdFormat  - Record format name                             *
      *                                                               *
      *  XFunction     - control of module function                   *
      *     *CREATE    - retrieve file description         CREATE     *
      *     *BASED-ON  - retrieve based on phys. file      BASED_ON   *
      *     *KEY       - initiate key sequence to reutrn   KEY        *
      *     *READKEY   - read next entry                   READKEY    *
      *     *SELECT    - initiate s/o statement to return  SELECT     *
      *     *READSEL   - read next entry                   READSELECT *
      *     *READTEXT  - file description                  READTEXT   *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XNbrOfEnt   - number of entry (depedencies)                  *
      *                *CREATE   - 1=OK                               *
      *                            0=Fehler                           *
      *                *BASED-ON - 1=OK                               *
      *                            0=Fehler                           *
      *                *KEY      - x=Anzahl Schlüsselfelder           *
      *                *READKEY  - x=Nr. des Schlüsselfeldes          *
      *                *READTEXT - x=Länge der Textbescheibung        *
      *                                                               *
      *  XData       - entry                                          *
      *                parameter is supported using XFunc=5  (read)   *
      *                (must be splitted using a data structure)      *
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
     D xRcdFormat      S             10A
     D xFunction       S             10A
     D xNbrOfEnt       S                   like(r§int4    )
     D xData           S            512A
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for QDBRTVFD
     D                 DS
     D RcvVarTab                      1A   DIM(32000) INZ(*BLANKS)
     D RcvVar                  1  32000A   INZ(*BLANKS)
      *
     D RcvVarLn        S             10I 0 INZ(32000)
      *
     D RetQFile        DS
     D  RetFile                      10A   INZ(*BLANKS)
     D  RetLib                       10A   INZ(*BLANKS)
      *
     D FormatName      S              8A   INZ(*BLANKS)
      *
     D QFile           DS                  likeds(r§qobj)
      *
     D RcdFormat       S             10A   INZ(*BLANKS)
     D Override        S              1A   INZ(*BLANKS)
     D System          S             10A   INZ(*BLANKS)
     D FormatType      S             10A   INZ(*BLANKS)
      *
      *  declarations for File definition header  (Qdb_Qdbfh), 1.9.3.2
     D pFileDefHd      S               *
      *
     D FileDefHd       DS                  BASED(pFileDefHd)
     D  Qdbfyret               1      4I 0                                      ByteReturned
     D  Qdbfyavl               5      8I 0                                      ByteAvailable
     D  Qdbfhflg               9     10A                                        Attr Bytes
     D   QdbfhflgH                    1A   OVERLAY(Qdbfhflg:1)
     D   QdbfhflgL                    1A   OVERLAY(Qdbfhflg:2)
     D  Qdbflbnum             15     16I 0                                      NbrOfRcdFmts
     D  Qdbfkfdm              22     22A                                        NbrOfRcdFmts
     D  Qdbfwtfi              44     45I 0                                      file wait time
     D  Qdbfhmnum             48     49I 0                                      file wait time
     D  Qdbfbrwt              59     60I 0                                      rcd  wait time
     D  Qaaf                  61     61A
     D  Qaaf2                 68     69A
     D   Qaaf2H                       1A   OVERLAY(Qaaf2   :1)
     D   Qaaf2L                       1A   OVERLAY(Qaaf2   :2)
     D  Qdbfhtxt              85    134A
     D  Qdbfasp              204    205I 0                                      ASP AuxStgPool
     D  Qdbfos               317    320I 0                                      OffFilScpArry
     D  Qdbfpact             337    338A                                        OffFilScpArry
     D  Qdblfof              369    372I 0                                      OffLglFileSpcAttr
      *
     D LglFileSpcAttr  DS                  BASED(pLglFileSpcAttr)
     D  Qdbfoj                 1      4I 0
     D  Qlfa                  31     31A
     D  Qdbfjtyp              32     32A
      *
      *  declarations for File Scope Array        (Qdb_Qdbfb), 1.9.3.20
     D pFileScpAy      S               *
     D §FileScpAy      C                   const(160)
      *
     D FileScope       DS                  BASED(pFileScpAy)
     D  Reserved48             1     48A
     D  Qdbfbf                49     58A                                        phys.File
     D  Qdbfbfl               59     68A                                        - Library
     D  Qdbft                 69     78A                                        RcdFormatName
     D  Reserved49            79    115A
     D  Qdbfbgky             116    117I 0                                      RcdFmtGenKeyC
     D  Reserved50           118    119A
     D  Qdbfblky             120    121I 0                                      RcdFmtMaxKeyL
     D  Reserved51           122    123A
     D  Qdbffogl             124    125I 0                                      RcdFmtGenKeyL
     D  Reserved52           126    128A
     D  Qdbfsoon             129    130I 0                                      NbrSelOmtStmt
     D  Qdbfsoof             131    134I 0                                      OffSelOmtStmt
     D  Qdbfksof             135    138I 0                                      OffKeySpcArry
     D  Qdbfkyct             139    140I 0                                      RcdFmtFulKeyC
     D  Qdbfgenf             141    142I 0                                      GenKeyFldCount
     D  Qdbfodis             143    146I 0                                      OffDstFileSec
     D  Reserved53           147    160A
      *
      *  declarations for Key Specification Array (Qdb_Qdbfk), 1.9.3.23
     D pKeySpecAy      S               *
     D §KeySpecAy      C                   const( 32)
      *
     D KeySpecAy       DS                  BASED(pKeySpecAy)
     D  Qdbfkfld               1     10A                                        KeyFieldName
     D  Reserved59            11     13A
     D  Qdbfksq               14     14A                                        KeySeqAtrFlag
     D  Reserved60            15     32A
      *
      *  declarations for select/omit Specification Array (Qdb_Qdbfk), 1.9.3.21
     D pSelSpecAy      S               *
     D §SelSpecAy      C                   const( 32)
      *
     D SelSpecAy       DS                  BASED(pSelSpecAy)
     D  Reserved54             1      2A
     D  Qdbfssso               3      3A                                        StatementRule
     D  Qdbfssop               4      5A                                        Comparison
     D  Qdbfssfn               6     15A                                        FieldName
     D  Qdbfsspnum            16     17I 0                                      NbrOfParm
     D  Qsosaf                18     19A                                        AttrFlags
     D  Qdbfssfj              19     20I 0                                      JoinRefNbr
     D  Reserved56            21     28A
     D  Qdbfsoso              29     32I 0                                      Offs_S/O_Parm
      *
     D pSelParmAy      S               *
     D §SelParmAy      C                   const( 52)
      *
     D SelParmAy       DS                  BASED(pSelParmAy)
     D  Qdbfspno               1      4I 0                                      OffsNextParm
     D  Qdbfspln               5      6I 0                                      LenOf_S/O_Parm
     D  Qdbfspin               7      7A                                        AttrIndicator
     D  Qasopaf                8      8A                                        AttrFlags
     D  Qdbfsppj               9     10I 0                                      JoinRefNbr
     D  Reserved58            11     20A
     D  Qdbfspvl              21     52A                                        ParmCompValue
      *
      *  API error reporting
      /COPY QCOPYLE,API_ERROR
      *
     D Offset          S                   like(r§int4    ) inz
     D Counter         S                   like(r§int4    ) inz
     D mbrNbr          S                   like(r§int4    ) inz
     D NbrOfKeyFd      S                   like(r§int4    ) inz
     D PosOfKeyFd      S                   like(r§int4    ) inz
     D LenOfSlOm       S                   like(r§int4    ) inz
     D NbrOfSlOm       S                   like(r§int4    ) inz
     D PosOfSlOm       S                   like(r§int4    ) inz
     D**OneByte         S              1A   INZ(x'00'  )
     D XPos            S                   like(r§int4    ) inz
     D R_VALU          S                   like(SOVALU    ) inz
      *
      *  KEYL0100, my own API stucture
      /COPY QCOPYLE,KEYL0100
      *
      *  FILD0100, my own API stucture
     D FILD0100        DS                  likeds(FILD0100_t) inz
      /COPY QCOPYLE,FILD0100
      *
      *  SELL0100, my own API stucture
      /COPY QCOPYLE,SELL0100
      *
      *  BSPF0100, my own API stucture
      /COPY QCOPYLE,BSPF0100
      *
      *  Boolean variables & constants
     D isFound         S                   like(r§bool    ) inz(bFalse)
     D isJoinFile      S                   like(r§bool    ) inz(bFalse)
      *
      *----------------------------------------------------*
      *  Aktuelle Datum und Uhrzeit
     D A_TIME          DS                  qualified
     D  time                   1     14  0
     D  ATIM                   1      6  0
     D  ADAT                   7     14  0
     D  TAG                    7      8  0
     D  MON                    9     10  0
     D  JAHR                  11     14  0
      *
      *  ... und rückwärts
     D V_TIME          DS
     D  V_ATIM                 1      6  0
     D  V_ADAT                 7     14  0
     D  V_ADA6                 9     14  0
     D  V_JAHR                 7     10  0
     D  V_MON                 11     12  0
     D  V_TAG                 13     14  0
      *
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
      *  Input
     C                   PARM                    xQFile
     C                   PARM                    xRcdFormat
     C                   PARM                    xFunction
      *  Output
     C                   PARM                    xNbrOfEnt
     C                   PARM                    xData
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     XFunction     WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     XFunction     WHENEQ    '*BASED-ON'
     C                   EXSR      Based_On
     C     XFunction     WHENEQ    '*KEY'
     C                   EXSR      Key
     C     XFunction     WHENEQ    '*READKEY'
     C                   EXSR      ReadKey
     C     XFunction     WHENEQ    '*READTEXT'
     C                   EXSR      ReadText
     C     XFunction     WHENEQ    '*SELECT'
     C                   EXSR      Select
     C     XFunction     WHENEQ    '*READSEL'
     C                   EXSR      ReadSelect
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
      *  Akt. Datum & Zeit ermitteln
     C                   EXSR      GetTime
      *
      *  retrieve file description
     C                   EVAL      FormatName = 'FILD0100'                      format
     C                   EVAL      QFile = XQFile                               qualf.file
     C                   EVAL      RcdFormat = *BLANKS                          record form.
     C                   EVAL      Override = '0'                               override
     C                   EVAL      System = '*LCL'
     C                   EVAL      FormatType = '*EXT'                          format typ
      *
     C                   CALL      'QDBRTVFD'
     C                   PARM                    RcvVar
     C                   PARM                    RcvVarLn
     C                   PARM                    RetQFile
     C                   PARM                    FormatName
     C                   PARM                    QFile
     C                   PARM                    RcdFormat
     C                   PARM                    Override
     C                   PARM                    System
     C                   PARM                    FormatType                     format typ
     C                   PARM                    §ErrorCode
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      XNbrOfEnt = *ZEROS
     C                   ELSE
     C                   EVAL      XNbrOfEnt = 1
     C                   EVAL      pFileDefHd = %ADDR(RcvVarTab(1))
     C                   Endif
      *
     C                   EXSR      API_Crt
      *
     C                   ENDSR
      *
      *====================================================*
      *  API_Crt    Fill API-structure for CREATE          *
      *====================================================*
      *
     C     API_Crt       BEGSR
      *
     C                   CLEAR                   FILD0100
      *  Jahrhundert
     C     V_JAHR        IFEQ      19
     C                   EVAL      FILD0100.ATRCEN = '0'
     C                   ELSE
     C                   EVAL      FILD0100.ATRCEN = '1'
     C                   Endif
      *  Datum
     C                   EVAL      FILD0100.ATRDAT = %char(V_ADA6)
      *  Uhrzeit
     C                   EVAL      FILD0100.ATRTIM = %char(V_ATIM)
      *
     C     XNbrOfEnt     IFLE      *ZEROS
      *  Fehler aufgetreten
      *  Datei/Bibliothek
     C                   EVAL      FILD0100.ATFILE = '*ERROR'
     C                   EVAL      FILD0100.ATLIB = '*ERROR'
     C                   ELSE
      *  restliche Felder füllen
      *  Datei/Bibliothek
     C                   EVAL      FILD0100.ATFILE = RetFile
     C                   EVAL      FILD0100.ATLIB = RetLib
      *  Bit 2   - Qdbfhfpl - Type of file
      *                  D=Einheit, P=PF, L=LF, R=DDM PF, S=DDM LF
     C**                 EVAL      *in98 = %bitand(QdbfhflgH: x'20') = x'20'
     C**                 EVAL      OneByte = QdbfhflgH                          Key statement
     C**                 BITOFF    '0134567'     OneByte
     C**                 TESTB     '2'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(QdbfhflgH: x'20') = x'20')
     C                   EVAL      FILD0100.ATFILA = '*LGL'                     logical
     C                   EVAL      FILD0100.ATFTYP = 'L'
     C                   ELSE
     C                   EVAL      FILD0100.ATFILA = '*PHY'                     physical
     C                   EVAL      FILD0100.ATFTYP = 'P'
     C                   Endif
      *
      *  Bit 4   - Qdbfhfsu - file type (FILETYPE)
     C**                 EVAL      *in98 = %bitand(QdbfhflgH: x'08') = x'08'
     C**                 EVAL      OneByte = QdbfhflgH                          Key statement
     C**                 BITOFF    '0123567'     OneByte
     C**                 TESTB     '4'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(QdbfhflgH: x'08') = x'08')
      *                  EVAL      ATDTAT = '*SRC'
     C                   ELSE
      *                  EVAL      ATDTAT = '*DTA'
     C                   Endif
      *
      *  Dateiwartezeit - Qdbfwtfi
     C                   EVAL      FILD0100.ATWAIT = Qdbfwtfi
      *
      *  Satzwartezeit  - Qdbfbrwt
     C                   EVAL      FILD0100.ATWATR = Qdbfbrwt
      *
      *  Bit 0   - Qdbfhflc - level check
     C**                 EVAL      *in98 = %bitand(QdbfhflgL: x'80') = x'80'
     C**                 EVAL      OneByte = QdbfhflgL                          Level Check
     C**                 BITOFF    '1234567'     OneByte
     C**                 TESTB     '0'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(QdbfhflgL: x'80') = x'80')
     C                   EVAL      FILD0100.ATLVLC = 'Y'
     C                   ELSE
     C                   EVAL      FILD0100.ATLVLC = 'N'
     C                   Endif
      *
      *  Textbeschreibung
     C                   EVAL      FILD0100.ATTXT = Qdbfhtxt
      *
      *  Extern/Intern beschriebene Datei
      *  Bit 7   - Qdbfpgmd - program described file indicator
     C**                 EVAL      *in98 = %bitand(Qaaf2: x'0100') = x'0100'
     C**                 EVAL      OneByte = Qaaf2                              Key statement
     C**                 BITOFF    '0123456'     OneByte
     C**                 TESTB     '7'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qaaf2: x'0100') = x'0100')
     C                   EVAL      FILD0100.ATFLS = 'Y'                         program
     C                   ELSE
     C                   EVAL      FILD0100.ATFLS = 'N'                         extern
     C                   Endif
      *
      *  Zugriffspfad
     C                   SELECT
     C     Qdbfpact      WHENEQ    'AR'
     C                   EVAL      FILD0100.ATACCP = 'A'
     C     Qdbfpact      WHENEQ    'KC'
     C     Qdbfpact      OREQ      'KF'
     C     Qdbfpact      OREQ      'KL'
     C     Qdbfpact      OREQ      'KN'
     C     Qdbfpact      OREQ      'KU'
     C                   EVAL      FILD0100.ATACCP = 'K'
     C                   OTHER
     C                   EVAL      FILD0100.ATACCP = '?'
     C                   Endsl
      *
      *  Select/Omit Angaben
      *  Bit 1   - Qdbfkfso - select/omit
     C**                 EVAL      *in98 = %bitand(QdbfhflgL: x'40') = x'40'
     C**                 EVAL      OneByte = QdbfhflgL                          Key statement
     C**                 BITOFF    '0234567'     OneByte
     C**                 TESTB     '1'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(QdbfhflgL: x'40') = x'40')
     C                   Eval      FILD0100.ATSELO = 'Y'
     C                   ELSE
     C                   Eval      FILD0100.ATSELO = 'N'
     C                   Endif
      *
      *  Logical File Attributes
     C                   If        (Qdblfof > 0)
     C                   Eval      pLglFileSpcAttr = pFileDefHd + Qdblfof
     C                   Eval      isJoinFile = %bitand(Qlfa: x'20') = x'20'
     C                   Else
     C                   Eval      isJoinFile = bFalse
     C                   Endif
      *
      *  Join logical file
     C                   If        (isJoinFile = bTrue)
     C                   Eval      FILD0100.ATJOIN = 'Y'
     C                   Else
     C                   Eval      FILD0100.ATJOIN = 'N'
     C                   Endif
      *
      *  Anzahl Satzformate
     C                   If        (FILD0100.ATJOIN = 'Y')
     C                   Eval      FILD0100.ATNOFM = 1
     C                   Else
     C                   Eval      FILD0100.ATNOFM = Qdbflbnum
     C                   Endif
      *
      *  Anzahl Teildateien
     C                   Eval      FILD0100.ATNOMB = Qdbfhmnum
      *
      *  Auxiliary storage pool ID
     C                   Eval      FILD0100.ATASP = Qdbfasp
      *
      *  nicht unterstützt:
     C                   Eval      FILD0100.ATMXDD = ''
     C                   Eval      FILD0100.ATMXDC = ''
     C                   Eval      FILD0100.ATMXDB = ''
     C                   Eval      FILD0100.ATFATR = ''
     C                   Eval      FILD0100.ATSYSN = ''
     C                   Eval      FILD0100.ATSHAR = ''
     C                   Eval      FILD0100.ATFCCN = ''
     C                   Eval      FILD0100.ATFCDT = ''
     C                   Eval      FILD0100.ATFCTM = ''
     C                   Eval      FILD0100.ATICAP = ''
     C                   Eval      FILD0100.ATAQDV = ''
     C                   Eval      FILD0100.ATMXDV = 0
     C                   Eval      FILD0100.ATSPOL = ''
     C                   Eval      FILD0100.ATNODV = 0
     C                   Eval      FILD0100.ATUBL  = 0
     C                   Eval      FILD0100.ATIDTA = ''
     C                   Eval      FILD0100.ATCSEQ = ''
      *
     C                   Endif
      *
     C                   Eval      XData = FILD0100
      *
     C                   ENDSR
      *
      *====================================================*
      *  Based_On-  set pointer to matching                *
      *             file scope entry of based-on           *
      *====================================================*
      *
     C     Based_On      BEGSR
      *
     C                   If        %check('0123456789': %trim(XRcdFormat)) = 0
     C***                Eval      mbrNbr = %dec(%trim(XRcdFormat): 10: 0)
     C***                EXSR      FindMbr
     C                   EXSR      *PSSR
     C                   Else
     C                   EXSR      FindRcdFmt
     C                   Endif
      *
     C     IsFound       IFEQ      bTrue
      *  store number of key fields ...
     C                   CLEAR                   BSPF0100
     C                   EVAL      BFFILE = Qdbfbf
     C                   EVAL      BFLIB = Qdbfbfl
     C                   EVAL      BFRCDFMT = Qdbft
     C                   EVAL      XNbrOfEnt = 1
     C                   EVAL      XData = BSPF0100
     C                   ELSE
      *  no key fields found ...
     C                   EVAL      XNbrOfEnt = 0
     C                   EVAL      XData = ''
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  Key    --  set pointer to matching                *
      *             file scope entry of key fields         *
      *====================================================*
      *
     C     Key           BEGSR
      *
     C                   EXSR      FindRcdFmt
     C     IsFound       IFEQ      bTrue
      *  store number of key fields ...
     C                   EVAL      NbrOfKeyFd = Qdbfbgky
     C                   EVAL      PosOfKeyFd = *ZEROS
     C                   ELSE
      *  no key fields found ...
     C                   EVAL      NbrOfKeyFd = *ZEROS
     C                   EVAL      PosOfKeyFd = *HIVAL
     C                   Endif
      *
     C                   EVAL      XNbrOfEnt = NbrOfKeyFd
      *
     C                   ENDSR
      *
      *====================================================*
      *  ReadKey --  read key entry one by one             *
      *====================================================*
      *
     C     ReadKey       BEGSR
      *
     C     PosOfKeyFd    IFLT      NbrOfKeyFd
      *
     C     PosOfKeyFd    MULT      §KeySpecAy    Offset
     C                   EVAL      Offset = Offset + Qdbfksof
     C
     C                   EVAL      pKeySpecAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C                   CLEAR                   KEYL0100
      *  Jahrhundert
     C                   EVAL      APRCEN = FILD0100.ATRCEN
      *  Datum
     C                   EVAL      APRDAT = FILD0100.ATRDAT
      *  Uhrzeit
     C                   EVAL      APRTIM = FILD0100.ATRTIM
      *  Datei
     C                   EVAL      APFILE = FILD0100.ATFILE
      *  Bibliothek
     C                   EVAL      APLIB = FILD0100.ATLIB
      *  Anzahl Schlüsselfelder
     C                   EVAL      APNKYF = NbrOfKeyFd
      *  Feldname
     C                   EVAL      APKEYF = Qdbfkfld                            Feldname
      *  Schlüsselfeldnummer
     C                   EVAL      APKEYN = PosOfKeyFd + 1
      *  Dateiart
     C                   EVAL      APFTYP = FILD0100.ATFTYP                     file type
      *------------------------------------------*
      *  Dateiattribute:                         *
      *------------------------------------------*
      *  Zugriffspfadwartung
     C                   EVAL      APMANT = Qdbfkfdm
      *  Bit 0/1 - Reserved_1
      *  Bit 2   - Qdbfhfpl - Type of file
     C                   EVAL      APFILA = FILD0100.ATFILA                     physical
      *  Bit 3   - Reserved_2
      *  Bit 5   - Reserved_3
      *  Bit 6   - Qdbfhfky - Access path
     C**                 EVAL      *in98 = %bitand(QdbfhflgH: x'02') = x'02'
     C**                 EVAL      OneByte = QdbfhflgH                          Key statement
     C**                 BITOFF    '0123457'     OneByte
     C**                 TESTB     '6'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(QdbfhflgH: x'02') = x'02')
      *  ... keyed
     C                   SELECT
      *      ... arrival sequence
     C     Qdbfpact      WHENEQ    'AR'
     C                   EVAL      APUNIQ = '*BLANKS'                           no unique key
     C                   EVAL      APKEYO = '*BLANKS'                           no order
      *      ... keyed, no unique, FCFO order
     C     Qdbfpact      WHENEQ    'KC'
     C                   EVAL      APUNIQ = 'N'                                 no unique key
     C                   EVAL      APKEYO = 'C'                                 FCFO oder
      *      ... keyed, no unique, FIFO order
     C     Qdbfpact      WHENEQ    'KF'
     C                   EVAL      APUNIQ = 'N'                                 no unique key
     C                   EVAL      APKEYO = 'F'                                 FIFO order
      *      ... keyed, no unique, LIFO order
     C     Qdbfpact      WHENEQ    'KL'
     C                   EVAL      APUNIQ = 'N'                                 no unique key
     C                   EVAL      APKEYO = 'L'                                 LIFO order
      *      ... keyed, no unique, no order
     C     Qdbfpact      WHENEQ    'KN'
     C                   EVAL      APUNIQ = 'N'                                 no unique key
     C                   EVAL      APKEYO = 'N'                                 no order
      *      ... keyed, unique, FIFO order - see DSPFD
     C     Qdbfpact      WHENEQ    'KU'
     C                   EVAL      APUNIQ = 'Y'                                 no unique key
     C                   EVAL      APKEYO = 'N'                                 FIFO order
      *
     C                   OTHER
     C                   Endsl
     C                   ELSE
      *  ... arrival sequence
     C                   EVAL      APUNIQ = '*BLANKS'                           no unique key
     C                   EVAL      APKEYO = '*BLANKS'                           no access path
     C                   Endif
      *  Bit 7   - Reserved_4
      *
      *------------------------------------------*
      *  Additional attribute flags              *
      *------------------------------------------*
      *  Bit 7   - Qdbfpkey - primary key
     C**                 EVAL      *in98 = %bitand(Qaaf2H: x'01') = x'01'
     C**                 EVAL      OneByte = Qaaf2H                             Key statement
     C**                 BITOFF    '0123456'     OneByte
     C**                 TESTB     '7'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qaaf2H: x'01') = x'01')
     C                   EVAL      APRIKY = 'P'                                 primary key
     C                   ELSE
      *  Bit 0   - Qdbfpkey - primary key
     C**                 EVAL      *in98 = %bitand(Qaaf2L: x'80') = x'80'
     C**                 EVAL      OneByte = Qaaf2L                             Key statement
     C**                 BITOFF    '1234567'     OneByte
     C**                 TESTB     '0'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qaaf2L: x'80') = x'80')
     C                   EVAL      APRIKY = 'U'                                 unique constr
     C                   ELSE
     C                   EVAL      APRIKY = 'N'                                 keine
     C                   Endif
     C                   Endif
      *
      *------------------------------------------*
      *  Schlüsselfeldattribute:                 *
      *------------------------------------------*
      *  Bit 0   - Qdbfksad - Ascending/Descending indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'80') = x'80'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '1234567'     OneByte
     C**                 TESTB     '0'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qdbfksq: x'80') = x'80')
     C                   EVAL      APKSEQ = 'D'                                 Descending
     C                   ELSE
     C                   EVAL      APKSEQ = 'A'                                 Ascending
     C                   Endif
      *  Bit 1/2 - Qdbfksn  - Numeric key field seq. indicator
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '034567'      OneByte
      *
     C                   SELECT
     C**   OneByte       WHENEQ    x'00'
     C                   WHEN      (Qdbfksq = x'00')
     C                   EVAL      APKSIN = 'N'                                 Unsigned
     C**   OneByte       WHENEQ    x'20'
     C                   WHEN      (Qdbfksq = x'20')
     C                   EVAL      APKSIN = 'A'                                 AbsVal
     C**   OneByte       WHENEQ    x'40'
     C                   WHEN      (Qdbfksq = x'40')
     C                   EVAL      APKSIN = 'S'                                 Signed
     C                   OTHER
     C                   EVAL      APKSIN = '?'                                 unknown
     C                   Endsl
      *  Bit 3   - Reserved_60
      *  Bit 4   - Qdbfksac - Alternate collating seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'08') = x'08'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123567'     OneByte
     C**                 TESTB     '4'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qdbfksq: x'08') = x'08')
     C                   EVAL      APKASQ = 'Y'                                 altern. seq.
     C                   ELSE
     C                   EVAL      APKASQ = 'N'                                 no alt. seq.
     C                   Endif
      *  Bit 5   - Qdbfkszf - Force zone  seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'04') = x'04'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123467'     OneByte
     C**                 TESTB     '5'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qdbfksq: x'04') = x'04')
     C                   EVAL      APKZD = 'Z'                                  Zone
     C                   ELSE
      *  Bit 6   - Qdbfksdf - Force digit seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'02') = x'02'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123457'     OneByte
     C**                 TESTB     '6'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qdbfksq: x'02') = x'02')
     C                   EVAL      APKZD = 'D'                                  Digit
     C                   ELSE
     C                   EVAL      APKZD = 'N'                                  None
     C                   Endif
     C                   Endif
      *  Bit 7   - Qdbfkft  - external / internal name indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'01') = x'01'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123456'     OneByte
     C**                 TESTB     '7'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(Qdbfksq: x'01') = x'01')
      ***                EVAL      'E'     z.Z. kein Feld vorhanden             external
     C                   ELSE
      ***                EVAL      'I'     z.Z. kein Feld vorhanden             internal
     C                   Endif
      *
     C                   EVAL      XDATA = KEYL0100
     C                   EVAL      XNbrOfEnt = PosOfKeyFd + 1
      *  pointer to next field
     C                   EVAL      PosOfKeyFd = PosOfKeyFd + 1
     C                   ELSE
     C                   EVAL      XNbrOfEnt = *ZEROS
     C                   EVAL      XData = *BLANKS
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  SELECT --  set pointer to matching                *
      *             file scope entry of select & omit      *
      *====================================================*
      *
     C     SELECT        BEGSR
      *
     C                   EXSR      FindRcdFmt
     C     IsFound       IFEQ      bTrue
      *  store number of select/omit statements ...
     C                   EVAL      NbrOfSlOm = Qdbfsoon
     C                   EVAL      PosOfSlOm = *ZEROS
     C                   ELSE
      *  no select/omit statements found ...
     C                   EVAL      NbrOfSlOm = *ZEROS
     C                   EVAL      PosOfSlOm = *HIVAL
     C                   Endif
      *
     C                   EVAL      XNbrOfEnt = NbrOfSlOm
      *
     C                   ENDSR
      *
      *====================================================*
      *  ReadSelect  read select/omit one by one           *
      *====================================================*
      *
     C     ReadSelect    BEGSR
      *
     C     PosOfSlOm     IFLT      NbrOfSlOm
      *
      *  Set pointer to select/omit specification entry
     C     PosOfSlOm     MULT      §SelSpecAy    Offset
     C                   EVAL      Offset = Offset + Qdbfsoof
      *
     C                   EVAL      pSelSpecAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C                   CLEAR                   SELL0100
      *  Jahrhundert
     C                   EVAL      SORCEN = FILD0100.ATRCEN
      *  Datum
     C                   EVAL      SORDAT = FILD0100.ATRDAT
      *  Uhrzeit
     C                   EVAL      SORTIM = FILD0100.ATRTIM
      *  Datei
     C                   EVAL      SOFILE = FILD0100.ATFILE
      *  Bibliothek
     C                   EVAL      SOLIB = FILD0100.ATLIB
      *  Dateiart
     C                   EVAL      SOFTYP = FILD0100.ATFTYP
      *  Dateiattribut
     C                   EVAL      SOFILA = FILD0100.ATFILA
      *  Reserviert
     C                   EVAL      SOMXD = *BLANKS
      *  Dateiattribut
     C                   EVAL      SOFATR = FILD0100.ATFATR
      *  Systemname
     C                   EVAL      SOSYSN = FILD0100.ATSYSN
      *  ASP Zusatzspeicher
     C                   EVAL      SOASP = FILD0100.ATASP
      *  Reserviert
     C                   EVAL      SORES = *BLANKS
      *  Anzahl SELECT/OMIT Regeln
     C                   EVAL      SONRUL = NbrOfSlOm
      *  Satzformat
     C                   EVAL      SORFMT = Qdbft
      *  SELECT/OMIT Regel
     C                   EVAL      SORULE = Qdbfssso
      *  Vergleichoperator, z.B.:  EQ,NE,AL
     C                   EVAL      SOCOMP = Qdbfssop
      *
      *  Wenn SELECT/OMIT-Parameter vorhanden sind, ...
     C     Qdbfsoso      IFLE      *ZEROS
      *  ... es sind aber keine vorhanden
     C                   ELSE
      *  ... dann diese ermitteln und zurückliefern
      *
      *      ... Feldname
     C                   EVAL      SOFLD = Qdbfssfn
      *      ... SELECT/OMIT Anzahl Vergleichswerte
     C                   EVAL      SONVAL = Qdbfsspnum
      *
      *      ... Zeiger auf den ersten Wert setzen ...
     C                   EVAL      Offset = Qdbfsoso
     C                   EVAL      pSelParmAy = %ADDR(RcvVarTab(Offset + 1))
      *
      *      ...  ermitteln SELECT/OMIT Wert und Wertlänge
     C                   DO        *HIVAL
      *
     C                   EVAL      LenOfSlOm = Qdbfspln - 20
      *
     C     LenOfSlOm     IFGE      1
     C     LenOfSlOm     ANDLE     32
     C                   EVAL      R_VALU = %subst(Qdbfspvl: 1: LenOfSlOm)
     C                   ELSE
     C                   EVAL      R_VALU = *BLANKS
     C                   Endif
      *
      *      ... SELECT/OMIT Wert
     C     SOVALU        IFEQ      *BLANKS
     C                   EVAL      SOVALU = R_VALU
     C                   ELSE
     C                   EVAL      SOVALU = %trimr(SOVALU) + ' ' + R_VALU
     C                   Endif
      *      ... SELECT/OMIT Wertlänge
     C                   EVAL      SOVALL = LenOfSlOm
      *
      *      ... wenn weitere Werte vorhanden sind, ...
     C     Qdbfspno      IFNE      *ZEROS
      *          ... dann den Zeiger auf den nächsten Wert ausrichten
     C                   EVAL      Offset = Qdbfspno
     C                   EVAL      pSelParmAy = %ADDR(RcvVarTab(Offset + 1))
     C                   ELSE
      *          ... ansonsten die Verarbeitung beenden
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *  DYNSLT
     C                   EVAL      SODYNS = *BLANKS
      *  JREF Field
     C                   EVAL      SOFJVL = Qdbfssfj
      *  JREF Parameter
     C                   EVAL      SOPJVL = *ZEROS
     C                   Endif
      *
     C                   EVAL      XDATA = SELL0100
      *
     C                   EVAL      XNbrOfEnt = PosOfSlOm + 1
      *  pointer to next field
     C                   EVAL      PosOfSlOm = PosOfSlOm + 1
     C                   ELSE
     C                   EVAL      XNbrOfEnt = *ZEROS
     C                   EVAL      XData = *BLANKS
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  ReadText--  read description of file              *
      *====================================================*
      *
     C     ReadText      BEGSR
      *
      *  Textbeschreibung
     C                   EVAL      XData = FILD0100.ATTXT
     C**   ' '           CHECKR    XData         XPos
     C                   EVAL      XPos = %checkr(' ': XData)
     C                   EVAL      XNbrOfEnt = XPos
      *
     C                   ENDSR
      *
      *====================================================*
      *  FindRcdFmt  find matching record format           *
      *====================================================*
      *
     C     FindRcdFmt    BEGSR
      *
     C                   EVAL      IsFound = bFalse
     C                   EVAL      Offset = Qdbfos
      *
     C     1             DO        Qdbflbnum     Counter
     C                   EVAL      pFileScpAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C     Qdbft         IFEQ      XRcdFormat
     C     XRcdFormat    OREQ      '*FIRST'
      *  Record format generic key field count ...
     C                   EVAL      IsFound = bTrue
     C                   LEAVE
     C                   ELSE
      *  No matching record format found ...
     C                   EVAL      Offset = Offset + §FileScpAy
     C                   EVAL      IsFound = bFalse
     C                   Endif
     C                   Enddo
      *
     C                   ENDSR
      *
      *====================================================*
      *  FindMbr     find member by number                 *
      *====================================================*
      *
     C     FindMbr       BEGSR
      *
     C                   If        mbrNbr < 1 or mbrNbr > Qdbflbnum
     C                   Eval      IsFound = bFalse
     C                   Else
     C                   Eval      Offset = Qdbfos + ((mbrNbr -1) * §FileScpAy)
     C                   EVAL      pFileScpAy = %ADDR(RcvVarTab(Offset + 1))
     C                   Eval      IsFound = bTrue
     C                   Endif
      *
     C                   ENDSR
      *
      *====================================================*
      *  GetTime -- Aktuelle Uhrzeit und Datum ermitteln   *
      *====================================================*
      *
     C     GetTime       BEGSR
      *
     C                   TIME                    A_TIME.time
      *
      *  Konv. nach Verarbeitungsdaten
     C                   EVAL      V_ATIM = A_TIME.ATIM
     C                   EVAL      V_TAG = A_TIME.TAG
     C                   EVAL      V_MON = A_TIME.MON
     C                   EVAL      V_JAHR= A_TIME.JAHR
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialisierung                        *
      *====================================================*
      *
     C     *INZSR        BEGSR
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
     C                   EVAL      XNbrOfEnt = *ZEROS
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
