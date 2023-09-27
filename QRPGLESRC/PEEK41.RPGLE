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
      *  XOption       - control of module function                   *
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
      *                            o_data = FILD0100                  *
      *                *BASED-ON - 1=OK                               *
      *                            0=Fehler                           *
      *                            o_data = BSPF0100                  *
      *                *KEY      - x=Anzahl Schlüsselfelder           *
      *                            o_data = ''                        *
      *                *READKEY  - x=Nr. des Schlüsselfeldes          *
      *                            o_data = KEYL0100                  *
      *                *READTEXT - x=Länge der Textbescheibung        *
      *                            o_data = description               *
      *                *SELECT   - x=Anzahl SELECT Einträge           *
      *                            o_data = ''                        *
      *                *READSEL  - x=Anzahl SELECT Einträge           *
      *                            o_data = SELL0100                  *
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
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,QDBRTVFD
      /COPY QCOPYLE,KEYL0100
      /COPY QCOPYLE,FILD0100
      /COPY QCOPYLE,SELL0100
      /COPY QCOPYLE,BSPF0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK41
      /undefine internal_prototype
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
     D RetQFile        DS                  likeds(r§qObj)
      *
      *  declarations for File definition header  (Qdb_Qdbfh), 1.9.3.2
     D pFileDefHd      S               *
      *
     D fileDefHd       DS                  likeds(Qdb_Qdbfh_t)
     D                                     based(pFileDefHd)
      *
     D lglFileSpcAttr  DS                  likeds(Qdb_Qdbflogl_t)
     D                                     based(pLglFileSpcAttr)
      *
      *  declarations for File Scope Array        (Qdb_Qdbfb), 1.9.3.20
     D pFileScpAy      S               *
     D §FileScpAy      C                   const(160)
      *
     D fileScope       DS                  likeds(Qdb_Qdbfb_t)
     D                                     based(pFileScpAy)
      *
      *  declarations for Key Specification Array (Qdb_Qdbfk), 1.9.3.23
     D pKeySpecAy      S               *
     D §KeySpecAy      C                   const( 32)
      *
     D keySpecAy       DS                  likeds(Qdb_Qdbfk_t)
     D                                     based(pKeySpecAy)
      *
      *  declarations for select/omit Specification Array (Qdb_Qdbfk), 1.9.3.21
     D pSelSpecAy      S               *
     D §SelSpecAy      C                   const( 32)
      *
     D selSpecAy       DS                  likeds(Qdb_Qdbfss_t)
     D                                     based(pSelSpecAy)
      *
     D pSelParmAy      S               *
      *
     D selParmAy       DS                  likeds(Qdb_Qdbfsp_t)
     D                                     based(pSelParmAy)
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
     D XPos            S                   like(r§int4    ) inz
     D R_VALU          S                   like(SELL0100_t.SOVALU) inz
      *
     D KEYL0100        DS                  likeds(KEYL0100_t) inz
     D FILD0100        DS                  likeds(FILD0100_t) inz
     D SELL0100        DS                  likeds(SELL0100_t) inz
     D BSPF0100        DS                  likeds(BSPF0100_t) inz
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
     D PEEK41          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_option                           const like(r§option)
     D  o_nbrOfEnt                               like(r§int4)
     D  o_data                      512A
      *
      *---------------------------------------------------*
      *
     C                   SELECT
     C     i_option      WHENEQ    '*CREATE'
     C                   EXSR      Create
     C     i_option      WHENEQ    '*BASED-ON'
     C                   EXSR      Based_On
     C     i_option      WHENEQ    '*KEY'
     C                   EXSR      Key
     C     i_option      WHENEQ    '*READKEY'
     C                   EXSR      ReadKey
     C     i_option      WHENEQ    '*READTEXT'
     C                   EXSR      ReadText
     C     i_option      WHENEQ    '*SELECT'
     C                   EXSR      Select
     C     i_option      WHENEQ    '*READSEL'
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
     C                   CALLP     QDBRTVFD(RcvVar: RcvVarLn: RetQFile
     C                                      : 'FILD0100': i_qFile: ''
     C                                      : '0': '*LCL': '*EXT'
     C                                      : §ErrorCode)
      *
     C     §ErrAvail     IFNE      *ZEROS
     C                   EVAL      o_nbrOfEnt = *ZEROS
     C                   ELSE
     C                   EVAL      o_nbrOfEnt = 1
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
     C     o_nbrOfEnt    IFLE      *ZEROS
      *  Fehler aufgetreten
      *  Datei/Bibliothek
     C                   EVAL      FILD0100.ATFILE = '*ERROR'
     C                   EVAL      FILD0100.ATLIB = '*ERROR'
     C                   ELSE
      *  restliche Felder füllen
      *  Datei/Bibliothek
     C                   EVAL      FILD0100.ATFILE = RetQFile.name
     C                   EVAL      FILD0100.ATLIB = RetQFile.lib
      *  Bit 2   - Qdbfhfpl - Type of file
      *                  D=Einheit, P=PF, L=LF, R=DDM PF, S=DDM LF
     C**                 EVAL      *in98 = %bitand(QdbfhflgH: x'20') = x'20'
     C**                 EVAL      OneByte = QdbfhflgH                          Key statement
     C**                 BITOFF    '0134567'     OneByte
     C**                 TESTB     '2'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(fileDefHd.QdbfhflgH: x'20') = x'20')
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
     C                   IF        (%bitand(fileDefHd.QdbfhflgH: x'08') = x'08')
      *                  EVAL      ATDTAT = '*SRC'
     C                   ELSE
      *                  EVAL      ATDTAT = '*DTA'
     C                   Endif
      *
      *  Dateiwartezeit - Qdbfwtfi
     C                   EVAL      FILD0100.ATWAIT = fileDefHd.Qdbfwtfi
      *
      *  Satzwartezeit  - Qdbfbrwt
     C                   EVAL      FILD0100.ATWATR = fileDefHd.Qdbfbrwt
      *
      *  Bit 0   - Qdbfhflc - level check
     C**                 EVAL      *in98 = %bitand(QdbfhflgL: x'80') = x'80'
     C**                 EVAL      OneByte = QdbfhflgL                          Level Check
     C**                 BITOFF    '1234567'     OneByte
     C**                 TESTB     '0'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(fileDefHd.QdbfhflgL: x'80') = x'80')
     C                   EVAL      FILD0100.ATLVLC = 'Y'
     C                   ELSE
     C                   EVAL      FILD0100.ATLVLC = 'N'
     C                   Endif
      *
      *  Textbeschreibung
     C                   EVAL      FILD0100.ATTXT = fileDefHd.Qdbfhtxt
      *
      *  Extern/Intern beschriebene Datei
      *  Bit 7   - Qdbfpgmd - program described file indicator
     C**                 EVAL      *in98 = %bitand(Qaaf2: x'0100') = x'0100'
     C**                 EVAL      OneByte = Qaaf2                              Key statement
     C**                 BITOFF    '0123456'     OneByte
     C**                 TESTB     '7'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(fileDefHd.Qaaf2: x'0100') = x'0100')
     C                   EVAL      FILD0100.ATFLS = 'Y'                         program
     C                   ELSE
     C                   EVAL      FILD0100.ATFLS = 'N'                         extern
     C                   Endif
      *
      *  Zugriffspfad
     C                   SELECT
     C                   WHEN      (fileDefHd.Qdbfpact = 'AR')
     C                   EVAL      FILD0100.ATACCP = 'A'
     C                   WHEN      (fileDefHd.Qdbfpact = 'KC' or
     C                              fileDefHd.Qdbfpact = 'KF' or
     C                              fileDefHd.Qdbfpact = 'KL' or
     C                              fileDefHd.Qdbfpact = 'KN' or
     C                              fileDefHd.Qdbfpact = 'KU')
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
     C                   IF        (%bitand(fileDefHd.QdbfhflgL: x'40') = x'40')
     C                   Eval      FILD0100.ATSELO = 'Y'
     C                   ELSE
     C                   Eval      FILD0100.ATSELO = 'N'
     C                   Endif
      *
      *  Logical File Attributes
     C                   If        (fileDefHd.Qdblfof > 0)
     C                   Eval      pLglFileSpcAttr =
     C                               pFileDefHd + fileDefHd.Qdblfof
     C                   Eval      isJoinFile =
     C                               %bitand(lglFileSpcAttr.Qlfa: x'20') = x'20'
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
     C                   Eval      FILD0100.ATNOFM = fileDefHd.Qdbflbnum
     C                   Endif
      *
      *  Anzahl Teildateien
     C                   Eval      FILD0100.ATNOMB = fileDefHd.Qdbfhmnum
      *
      *  Auxiliary storage pool ID
     C                   Eval      FILD0100.ATASP = fileDefHd.Qdbfasp
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
     C                   Eval      o_data = FILD0100
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
     C                   If        %check('0123456789': %trim(i_rcdFmt)) = 0
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
     C                   EVAL      BSPF0100.BFFILE = fileScope.Qdbfbf
     C                   EVAL      BSPF0100.BFLIB = fileScope.Qdbfbfl
     C                   EVAL      BSPF0100.BFRCDFMT = fileScope.Qdbft
     C                   EVAL      o_nbrOfEnt = 1
     C                   EVAL      o_data = BSPF0100
     C                   ELSE
      *  no key fields found ...
     C                   EVAL      o_nbrOfEnt = 0
     C                   EVAL      o_data = ''
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
     C                   EVAL      NbrOfKeyFd = fileScope.Qdbfbgky
     C                   EVAL      PosOfKeyFd = *ZEROS
     C                   ELSE
      *  no key fields found ...
     C                   EVAL      NbrOfKeyFd = *ZEROS
     C                   EVAL      PosOfKeyFd = *HIVAL
     C                   Endif
      *
     C                   EVAL      o_nbrOfEnt = NbrOfKeyFd
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
     C                   EVAL      Offset = Offset + fileScope.Qdbfksof
     C
     C                   EVAL      pKeySpecAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C                   CLEAR                   KEYL0100
      *  Jahrhundert
     C                   EVAL      KEYL0100.APRCEN = FILD0100.ATRCEN
      *  Datum
     C                   EVAL      KEYL0100.APRDAT = FILD0100.ATRDAT
      *  Uhrzeit
     C                   EVAL      KEYL0100.APRTIM = FILD0100.ATRTIM
      *  Datei
     C                   EVAL      KEYL0100.APFILE = FILD0100.ATFILE
      *  Bibliothek
     C                   EVAL      KEYL0100.APLIB = FILD0100.ATLIB
      *  Anzahl Schlüsselfelder
     C                   EVAL      KEYL0100.APNKYF = NbrOfKeyFd
      *  Feldname
     C                   EVAL      KEYL0100.APKEYF = keySpecAy.Qdbfkfld         Feldname
      *  Schlüsselfeldnummer
     C                   EVAL      KEYL0100.APKEYN = PosOfKeyFd + 1
      *  Dateiart
     C                   EVAL      KEYL0100.APFTYP = FILD0100.ATFTYP            file type
      *------------------------------------------*
      *  Dateiattribute:                         *
      *------------------------------------------*
      *  Zugriffspfadwartung
     C                   EVAL      KEYL0100.APMANT = fileDefHd.Qdbfkfdm
      *  Bit 0/1 - Reserved_1
      *  Bit 2   - Qdbfhfpl - Type of file
     C                   EVAL      KEYL0100.APFILA = FILD0100.ATFILA            physical
      *  Bit 3   - Reserved_2
      *  Bit 5   - Reserved_3
      *  Bit 6   - Qdbfhfky - Access path
     C**                 EVAL      *in98 = %bitand(QdbfhflgH: x'02') = x'02'
     C**                 EVAL      OneByte = QdbfhflgH                          Key statement
     C**                 BITOFF    '0123457'     OneByte
     C**                 TESTB     '6'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(fileDefHd.QdbfhflgH: x'02') = x'02')
      *  ... keyed
     C                   SELECT
      *      ... arrival sequence
     C                   WHEN      fileDefHd.Qdbfpact = 'AR'
     C                   EVAL      KEYL0100.APUNIQ = '*BLANKS'                  no unique key
     C                   EVAL      KEYL0100.APKEYO = '*BLANKS'                  no order
      *      ... keyed, no unique, FCFO order
     C                   WHEN      fileDefHd.Qdbfpact = 'KC'
     C                   EVAL      KEYL0100.APUNIQ = 'N'                        no unique key
     C                   EVAL      KEYL0100.APKEYO = 'C'                        FCFO oder
      *      ... keyed, no unique, FIFO order
     C                   WHEN      fileDefHd.Qdbfpact = 'KF'
     C                   EVAL      KEYL0100.APUNIQ = 'N'                        no unique key
     C                   EVAL      KEYL0100.APKEYO = 'F'                        FIFO order
      *      ... keyed, no unique, LIFO order
     C                   WHEN      fileDefHd.Qdbfpact = 'KL'
     C                   EVAL      KEYL0100.APUNIQ = 'N'                        no unique key
     C                   EVAL      KEYL0100.APKEYO = 'L'                        LIFO order
      *      ... keyed, no unique, no order
     C                   WHEN      fileDefHd.Qdbfpact = 'KN'
     C                   EVAL      KEYL0100.APUNIQ = 'N'                        no unique key
     C                   EVAL      KEYL0100.APKEYO = 'N'                        no order
      *      ... keyed, unique, FIFO order - see DSPFD
     C                   WHEN      fileDefHd.Qdbfpact = 'KU'
     C                   EVAL      KEYL0100.APUNIQ = 'Y'                        no unique key
     C                   EVAL      KEYL0100.APKEYO = 'N'                        FIFO order
      *
     C                   OTHER
     C                   Endsl
     C                   ELSE
      *  ... arrival sequence
     C                   EVAL      KEYL0100.APUNIQ = '*BLANKS'                  no unique key
     C                   EVAL      KEYL0100.APKEYO = '*BLANKS'                  no access path
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
     C                   IF        (%bitand(fileDefHd.Qaaf2H: x'01') = x'01')
     C                   EVAL      KEYL0100.APRIKY = 'P'                        primary key
     C                   ELSE
      *  Bit 0   - Qdbfpkey - primary key
     C**                 EVAL      *in98 = %bitand(Qaaf2L: x'80') = x'80'
     C**                 EVAL      OneByte = Qaaf2L                             Key statement
     C**                 BITOFF    '1234567'     OneByte
     C**                 TESTB     '0'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(fileDefHd.Qaaf2L: x'80') = x'80')
     C                   EVAL      KEYL0100.APRIKY = 'U'                        unique constr
     C                   ELSE
     C                   EVAL      KEYL0100.APRIKY = 'N'                        keine
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
     C                   IF        (%bitand(keySpecAy.Qdbfksq: x'80') = x'80')
     C                   EVAL      KEYL0100.APKSEQ = 'D'                        Descending
     C                   ELSE
     C                   EVAL      KEYL0100.APKSEQ = 'A'                        Ascending
     C                   Endif
      *  Bit 1/2 - Qdbfksn  - Numeric key field seq. indicator
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '034567'      OneByte
      *
     C                   SELECT
     C**   OneByte       WHENEQ    x'00'
     C                   WHEN      (keySpecAy.Qdbfksq = x'00')
     C                   EVAL      KEYL0100.APKSIN = 'N'                        Unsigned
     C**   OneByte       WHENEQ    x'20'
     C                   WHEN      (keySpecAy.Qdbfksq = x'20')
     C                   EVAL      KEYL0100.APKSIN = 'A'                        AbsVal
     C**   OneByte       WHENEQ    x'40'
     C                   WHEN      (keySpecAy.Qdbfksq = x'40')
     C                   EVAL      KEYL0100.APKSIN = 'S'                        Signed
     C                   OTHER
     C                   EVAL      KEYL0100.APKSIN = '?'                        unknown
     C                   Endsl
      *  Bit 3   - Reserved_60
      *  Bit 4   - Qdbfksac - Alternate collating seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'08') = x'08'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123567'     OneByte
     C**                 TESTB     '4'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(keySpecAy.Qdbfksq: x'08') = x'08')
     C                   EVAL      KEYL0100.APKASQ = 'Y'                        altern. seq.
     C                   ELSE
     C                   EVAL      KEYL0100.APKASQ = 'N'                        no alt. seq.
     C                   Endif
      *  Bit 5   - Qdbfkszf - Force zone  seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'04') = x'04'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123467'     OneByte
     C**                 TESTB     '5'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(keySpecAy.Qdbfksq: x'04') = x'04')
     C                   EVAL      KEYL0100.APKZD = 'Z'                         Zone
     C                   ELSE
      *  Bit 6   - Qdbfksdf - Force digit seq. indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'02') = x'02'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123457'     OneByte
     C**                 TESTB     '6'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(keySpecAy.Qdbfksq: x'02') = x'02')
     C                   EVAL      KEYL0100.APKZD = 'D'                         Digit
     C                   ELSE
     C                   EVAL      KEYL0100.APKZD = 'N'                         None
     C                   Endif
     C                   Endif
      *  Bit 7   - Qdbfkft  - external / internal name indicator
     C**                 EVAL      *in98 = %bitand(Qdbfksq: x'01') = x'01'
     C**                 EVAL      OneByte = Qdbfksq                            Key statement
     C**                 BITOFF    '0123456'     OneByte
     C**                 TESTB     '7'           OneByte                  99
     C**   *IN99         IFEQ      '1'
     C                   IF        (%bitand(keySpecAy.Qdbfksq: x'01') = x'01')
      ***                EVAL      'E'     z.Z. kein Feld vorhanden             external
     C                   ELSE
      ***                EVAL      'I'     z.Z. kein Feld vorhanden             internal
     C                   Endif
      *
     C                   EVAL      o_data = KEYL0100
     C                   EVAL      o_nbrOfEnt = PosOfKeyFd + 1
      *  pointer to next field
     C                   EVAL      PosOfKeyFd = PosOfKeyFd + 1
     C                   ELSE
     C                   EVAL      o_nbrOfEnt = *ZEROS
     C                   EVAL      o_data = *BLANKS
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
     C                   EVAL      NbrOfSlOm = fileScope.Qdbfsoon
     C                   EVAL      PosOfSlOm = *ZEROS
     C                   ELSE
      *  no select/omit statements found ...
     C                   EVAL      NbrOfSlOm = *ZEROS
     C                   EVAL      PosOfSlOm = *HIVAL
     C                   Endif
      *
     C                   EVAL      o_nbrOfEnt = NbrOfSlOm
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
     C                   EVAL      Offset = Offset + fileScope.Qdbfsoof
      *
     C                   EVAL      pSelSpecAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C                   CLEAR                   SELL0100
      *  Jahrhundert
     C                   EVAL      SELL0100.SORCEN = FILD0100.ATRCEN
      *  Datum
     C                   EVAL      SELL0100.SORDAT = FILD0100.ATRDAT
      *  Uhrzeit
     C                   EVAL      SELL0100.SORTIM = FILD0100.ATRTIM
      *  Datei
     C                   EVAL      SELL0100.SOFILE = FILD0100.ATFILE
      *  Bibliothek
     C                   EVAL      SELL0100.SOLIB = FILD0100.ATLIB
      *  Dateiart
     C                   EVAL      SELL0100.SOFTYP = FILD0100.ATFTYP
      *  Dateiattribut
     C                   EVAL      SELL0100.SOFILA = FILD0100.ATFILA
      *  Reserviert
     C                   EVAL      SELL0100.SOMXD = *BLANKS
      *  Dateiattribut
     C                   EVAL      SELL0100.SOFATR = FILD0100.ATFATR
      *  Systemname
     C                   EVAL      SELL0100.SOSYSN = FILD0100.ATSYSN
      *  ASP Zusatzspeicher
     C                   EVAL      SELL0100.SOASP = FILD0100.ATASP
      *  Reserviert
     C                   EVAL      SELL0100.SORES = *BLANKS
      *  Anzahl SELECT/OMIT Regeln
     C                   EVAL      SELL0100.SONRUL = NbrOfSlOm
      *  Satzformat
     C                   EVAL      SELL0100.SORFMT = fileScope.Qdbft
      *  SELECT/OMIT Regel
     C                   EVAL      SELL0100.SORULE = selSpecAy.Qdbfssso
      *  Vergleichoperator, z.B.:  EQ,NE,AL
     C                   EVAL      SELL0100.SOCOMP = selSpecAy.Qdbfssop
      *
      *  Wenn SELECT/OMIT-Parameter vorhanden sind, ...
     C                   IF        (selSpecAy.Qdbfsoso <= 0)
      *  ... es sind aber keine vorhanden
     C                   ELSE
      *  ... dann diese ermitteln und zurückliefern
      *
      *      ... Feldname
     C                   EVAL      SELL0100.SOFLD = selSpecAy.Qdbfssfn
      *      ... SELECT/OMIT Anzahl Vergleichswerte
     C                   EVAL      SELL0100.SONVAL = selSpecAy.Qdbfsspnum
      *
      *      ... Zeiger auf den ersten Wert setzen ...
     C                   EVAL      Offset = selSpecAy.Qdbfsoso
     C                   EVAL      pSelParmAy = %ADDR(RcvVarTab(Offset + 1))
      *
      *      ...  ermitteln SELECT/OMIT Wert und Wertlänge
     C                   DO        *HIVAL
      *
     C                   EVAL      LenOfSlOm = selParmAy.Qdbfspln - 20
      *
     C     LenOfSlOm     IFGE      1
     C     LenOfSlOm     ANDLE     32
     C                   EVAL      R_VALU =
     C                               %subst(selParmAy.Qdbfspvl: 1: LenOfSlOm)
     C                   ELSE
     C                   EVAL      R_VALU = ''
     C                   Endif
      *
      *      ... SELECT/OMIT Wert
     C                   IF        (SELL0100.SOVALU = '')
     C                   EVAL      SELL0100.SOVALU = R_VALU
     C                   ELSE
     C                   EVAL      SELL0100.SOVALU =
     C                               %trimr(SELL0100.SOVALU) + ' ' + R_VALU
     C                   Endif
      *      ... SELECT/OMIT Wertlänge
     C                   EVAL      SELL0100.SOVALL = LenOfSlOm
      *
      *      ... wenn weitere Werte vorhanden sind, ...
     C                   IF        (selParmAy.Qdbfspno <> 0)
      *          ... dann den Zeiger auf den nächsten Wert ausrichten
     C                   EVAL      Offset = selParmAy.Qdbfspno
     C                   EVAL      pSelParmAy = %ADDR(RcvVarTab(Offset + 1))
     C                   ELSE
      *          ... ansonsten die Verarbeitung beenden
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *  DYNSLT
     C                   EVAL      SELL0100.SODYNS = *BLANKS
      *  JREF Field
     C                   EVAL      SELL0100.SOFJVL = selSpecAy.Qdbfssfj
      *  JREF Parameter
     C                   EVAL      SELL0100.SOPJVL = *ZEROS
     C                   Endif
      *
     C                   EVAL      o_data = SELL0100
      *
     C                   EVAL      o_nbrOfEnt = PosOfSlOm + 1
      *  pointer to next field
     C                   EVAL      PosOfSlOm = PosOfSlOm + 1
     C                   ELSE
     C                   EVAL      o_nbrOfEnt = *ZEROS
     C                   EVAL      o_data = *BLANKS
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
     C                   EVAL      o_data = FILD0100.ATTXT
     C**   ' '           CHECKR    XData         XPos
     C                   EVAL      XPos = %checkr(' ': o_data)
     C                   EVAL      o_nbrOfEnt = XPos
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
     C                   EVAL      Offset = fileDefHd.Qdbfos
     C                   EVAL      Counter = fileDefHd.Qdbflbnum
      *
     C                   DOW       Counter > 0
     C                   EVAL      pFileScpAy = %ADDR(RcvVarTab(Offset + 1))
      *
     C                   IF        fileScope.Qdbft = i_rcdFmt or
     C                             i_rcdFmt = '*FIRST'
      *  Record format generic key field count ...
     C                   EVAL      IsFound = bTrue
     C                   LEAVE
     C                   ELSE
      *  No matching record format found ...
     C                   EVAL      Offset = Offset + §FileScpAy
     C                   EVAL      IsFound = bFalse
     C                   Endif
     C                   Eval      Counter = Counter - 1
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
     C                   If        mbrNbr < 1 or mbrNbr > fileDefhd.Qdbflbnum
     C                   Eval      IsFound = bFalse
     C                   Else
     C                   Eval      Offset = fileDefHd.Qdbfos +
     C                                      ((mbrNbr -1) * §FileScpAy)
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
     C                   EVAL      o_nbrOfEnt = *ZEROS
     C                   GOTO      ENDE
      *
     C                   ENDSR     '*CANCL'
      *
