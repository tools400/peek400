      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK18                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 24.10.97  Raddatz                                 *
      *  geändert : 27.04.99  für Version 2.1.0                       *
      *  geändert : 23.05.02  für Version 2.2.0                       *
      *                       fixed problem with 2B0 fields           *
      *  geändert : 23.03.04  für Version 2.2.2                       *
      *                       added support for  3I0 fields           *
      *                       added support for 20I0 fields           *
      *  geändert : 01.04.04  für Version 2.2.2                       *
      *                     added support for time format *HMS, *EUR  *
      *                     added support for date format *EUR        *
      *  geändert : 11.10.06  für Version 2.4.1                       *
      *                       added support for  3I0 key fields       *
      *                       added support for 20I0 key fields       *
      *  geändert:  29.07.20  RNX0100: Length or start position is    *
      *                       out of range ...                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Konvertieren: interne <==> externe Darstellung               *
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
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     PREFIX(F_)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK18
      /undefine internal_prototype
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0003
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8138
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D YBuffer         S            128A
     D YType           S              1A
     D YDatTimFmt      S                   like(FLDL0100_t.F1DTFM) inz
     D YSeparator      S                   like(FLDL0100_t.F1DTSP) inz
     D YMsgID          S              7A
     D YMsgDta         S            512A
      *
     D §Numeric        C                   CONST('1234567890')
      *
     D IsMinus         S              1A         INZ(bFalse)
      *
     D BL              S                   like(r§int4    ) inz
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D A1              S              1A         INZ(*BLANKS)
      *
      * Maximale Feldlänge liegt bei 30 Stellen wegen Bildschirmgroesse.
      * Siehe PEEK58, f_isNotAlw().
     D                 DS
     D zoned                         63S 0 inz
     D zoned_A                       63A   overlay(zoned: 1)
      *
     D                 DS
     D packed                        63P 0 inz
     D packed_A                      32A   overlay(packed: 1)
      *
     D                 DS
     D binary1                 1      1I 0 inz
     D binary1_A                      1A   overlay(binary1: 1)
      *
     D                 DS
     D binary2                 1      2I 0 inz
     D binary2_A                      2A   overlay(binary2: 1)
      *
     D                 DS
     D binary4                 1      4I 0 inz
     D binary4_A                      4A   overlay(binary4: 1)
      *
     D                 DS
     D binary8                 1      8I 0 inz
     D binary8_A                      8A   overlay(binary8: 1)
      *
     D len             S             10I 0 inz
      *
     D Float           S              8F   inz
     D Float4          S              4F   based(pFloat)
     D Float8          S              8F   based(pFloat)
      *
     D dsFloat         DS                  qualified inz
     D  float8                        8F
     D  float4                        4F   overlay(float8)
      *
     D hTranscoder     S                   like(hTranscoder_t ) inz
      *
     D SET§SignP       S                         LIKE(SET_SignP) INZ('+')
     D SET§SignM       S                         LIKE(SET_SignM) INZ('-')
      *
     D R_TgtValue      S                         LIKE(i_tgtValue) INZ(*BLANKS)
     D R_DateISO       S               D         DATFMT(*ISO)    INZ(*LOVAL )
     D R_TimeISO       S               T         TIMFMT(*ISO)    INZ(*LOVAL )
     D R_TimeStmp      S               Z                         INZ(*LOVAL )
     D R_DftSp         S                         LIKE(FLDL0100_t.F1DTSP) INZ
     D R_TimeBuf       S              8A                         INZ
     D R_DateBuf       S             10A                         INZ
      *
     D strPos          S                   like(r§int4    )
     D                                     inz
      *
     D PEEK36_NAME     S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,PPEEK36
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
      *    Converts a given buffer into the Job ccsid.
     D cvtToJobCcsid   pr            10i 0 extproc('cvtToJobCcsid')
     D  io_buffer                          like(r§rcdBuf)
     D  i_length                     10i 0 value
     D  i_ccsid                      10i 0 value
      *
      *    Converts a given buffer into the File ccsid.
     D cvtToFileCcsid  pr            10i 0 extproc('cvtToFileCcsid')
     D  io_buffer                          like(r§rcdBuf)
     D  i_length                     10i 0 value
     D  i_ccsid                      10i 0 value
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(r§bool) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK18          PI
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(r§fmt)
     D  i_buffer                                 like(r§rcdBuf)
     D  i_tgtFormat                  10A   const
     D  i_tgtValue                   10A   const
     D  o_buffer                                 like(r§rcdBuf)
     D  o_buffLen                                like (r§int4)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
     C                   EXSR      FIRST
      *
     C                   Eval      FLDL0100 = i_fldl0100
      *
     C                   Eval      o_buffer = *BLANKS
     C                   Eval      o_buffLen = *ZEROS
      *
     C                   SELECT
     C     i_tgtFormat   WHENEQ    '*EXTERN'
     C                   EXSR      ToExtern
     C     i_tgtFormat   WHENEQ    '*INTERN'
     C                   EXSR      ToIntern
     C     i_tgtFormat   WHENEQ    '*ZONED'
     C                   EXSR      ToZoned
     C     i_tgtFormat   WHENEQ    '*FLOAT'
     C                   EXSR      ToFloat
     C                   OTHER
     C                   Endsl
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    ToExtern      Zielformat:  externe Darstellung          *
      *============================================================*
      *
     C     ToExtern      BEGSR
      *
     C                   SELECT
     C                   WHEN      FLDL0100.F1DTyp = 'A'
     C                   EXSR      A_to_Ext
     C                   WHEN      FLDL0100.F1DTyp = 'G'
     C                   EXSR      G_to_Ext
     C                   WHEN      FLDL0100.F1DTyp = 'S'
     C                   EXSR      S_to_Ext
     C                   WHEN      FLDL0100.F1DTyp = 'B'
     C                   EXSR      B_to_Ext
     C                   WHEN      FLDL0100.F1DTyp = 'P'
     C                   EXSR      P_to_Ext
     C                   WHEN      FLDL0100.F1DTyp = 'F'
     C                   EXSR      F_to_Ext
      *
     C                   OTHER
     C                   EXSR      A_to_Ext
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    ToIntern      Zielformat:  interne Darstellung          *
      *============================================================*
      *
     C     ToIntern      BEGSR
      *
      *  Art des Schlüssel ermitteln ...
     C                   EXSR      GetKeyType
      *  Ascending key ...
     C     F_Desc        IFEQ      'A'
      *  ... Keine Umsetzung erforderlich
     C                   Eval      R_TgtValue = i_tgtValue
     C                   ELSE
      *  Descending key ...
     C     i_tgtValue    IFEQ      '*HIVAL'
     C     i_tgtValue    OREQ      '*LOVAL'
      *  ... *HIVAL ==> *LOVAL und umgekehrt
     C     i_tgtValue    IFEQ      '*HIVAL'
     C                   Eval      R_TgtValue = '*LOVAL'
     C                   ELSE
     C                   Eval      R_TgtValue = '*HIVAL'
     C                   Endif
     C                   ELSE
      *  ... Keine Umsetzung erforderlich
     C                   Eval      R_TgtValue = i_tgtValue
     C                   Endif
     C                   Endif
      *
     C                   SELECT
     C                   WHEN      FLDL0100.F1DTyp = 'A'
     C                   EXSR      A_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'G'
     C                   EXSR      G_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'S'
     C                   EXSR      S_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'B'
     C                   EXSR      B_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'P'
     C                   EXSR      P_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'L'
     C                   EXSR      L_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'T'
     C                   EXSR      T_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'Z'
     C                   EXSR      Z_to_Int
     C                   WHEN      FLDL0100.F1DTyp = 'F'
     C                   EXSR      F_to_Int
      *
     C                   OTHER
     C                   EXSR      A_to_Int
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    ToZoned       Zielformat:  Zoned-Format                 *
      *============================================================*
      *
     C     ToZoned       BEGSR
      *
     C                   Eval      FLDL0100.F1Digt = f_len(zoned_A)
      *
     C                   SELECT
     C                   WHEN      FLDL0100.F1DTyp = 'A'
     C                   EXSR      A_to_Zoned
     C                   WHEN      FLDL0100.F1DTyp = 'S'
     C                   EXSR      S_to_Zoned
     C                   WHEN      FLDL0100.F1DTyp = 'B'
     C                   EXSR      B_to_Zoned
     C                   WHEN      FLDL0100.F1DTyp = 'P'
     C                   EXSR      P_to_Zoned
      *
     C                   OTHER
     C                   EXSR      A_to_Zoned
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    ToFloat       Zielformat:  Float-Format                 *
      *============================================================*
      *
     C     ToFloat       BEGSR
      *
     C                   SELECT
     C                   WHEN      FLDL0100.F1DTyp = 'F'
     C                   EXSR      F_to_Float
      *
     C                   OTHER
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    A_to_Ext      alpha ==> externe Darstellung             *
      *============================================================*
      *
     C     A_to_Ext      BEGSR
      *
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      strPos = 3
     C                   Else
     C                   Eval      strPos = 1
     C                   Endif
      *
     C                   Eval      o_buffer =
     C                               %subst(i_buffer
     C                                      : strPos: f_buffLn(FLDL0100))
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
      *
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   Eval      o_buffLen =
     C                             cvtToJobCcsid(
     C                               o_buffer: o_buffLen: FLDL0100.F1FDCC)
     C                   Endif
      *
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    G_to_Ext      graphic => externe Darstellung            *
      *============================================================*
      *
     C     G_to_Ext      BEGSR
      *
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      strPos = 3
     C                   Else
     C                   Eval      strPos = 1
     C                   Endif
      *
     C                   Eval      o_buffer =
     C                               %subst(i_buffer
     C                                      : strPos: f_buffLn(FLDL0100))
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
      *
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   Eval      o_buffLen =
     C                             cvtToJobCcsid(
     C                               o_buffer: o_buffLen: FLDL0100.F1FDCC)
     C                   Endif
      *
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_to_Ext      Zoned ==> externe Darstellung             *
      *============================================================*
      *
     C     S_to_Ext      BEGSR
      *
     C                   EXSR      GetZoned
     C                   EXSR      ChgSign
     C                   EXSR      ZonedToOutBuf
     C                   EXSR      AddSign
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    B_to_Ext      Binary ==> externe Darstellung            *
      *============================================================*
      *
     C     B_to_Ext      BEGSR
      *
     C                   EXSR      GetBinary
     C                   EXSR      ChgSign
     C                   EXSR      ZonedToOutBuf
     C                   EXSR      AddSign
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    P_to_Ext      Packed ==> externe Darstellung            *
      *============================================================*
      *
     C     P_to_Ext      BEGSR
      *
     C                   EXSR      GetPacked
     C                   EXSR      ChgSign
     C                   EXSR      ZonedToOutBuf
     C                   EXSR      AddSign
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    F_to_Ext      Float  ==> externe Darstellung            *
      *============================================================*
      *
     C     F_to_Ext      BEGSR
      *
     C                   Eval      pFloat = %addr(i_buffer)
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      Float = FLoat4
     C                   EXSR      ChgSignFloat
     C                   Eval      Float4 = FLoat
     C                   Eval      o_buffer = %editflt(Float4)
     C                   Eval      o_buffLen = 14
     C                   ELSE
     C                   Eval      Float = FLoat8
     C                   EXSR      ChgSignFloat
     C                   Eval      Float8 = FLoat
     C                   Eval      o_buffer = %editflt(Float8)
     C                   Eval      o_buffLen = 23
     C                   ENDIF
      *
      *  Entfernen führendes Vorzeichen
     C                   Eval      o_buffer = %subst(o_buffer: 2)
     C                   Eval      o_buffLen = o_buffLen - 1
      *
     C                   EXSR      AddSign
     C                   EXSR      AddDlmtr
      *
     C                   ENDSR
      *
      *============================================================*
      *    A_to_Zoned    alpha ==> Zoned-Format                    *
      *============================================================*
      *
     C     A_to_Zoned    BEGSR
      *
     C                   Eval      Zoned = *ZEROS
     C                   EXSR      ZonedToOutBuf
      *
     C                   ENDSR
      *
      *============================================================*
      *    S_to_Zoned    Zoned ==> Zoned-Format                    *
      *============================================================*
      *
     C     S_to_Zoned    BEGSR
      *
     C                   EXSR      GetZoned
     C                   EXSR      ZonedToOutBuf
      *
     C                   ENDSR
      *
      *============================================================*
      *    B_to_Zoned    Binary ==> Zoned-Format                   *
      *============================================================*
      *
     C     B_to_Zoned    BEGSR
      *
     C                   EXSR      GetBinary
     C                   EXSR      ZonedToOutBuf
      *
     C                   ENDSR
      *
      *============================================================*
      *    P_to_Zoned    Packed ==> Zoned-Format                   *
      *============================================================*
      *
     C     P_to_Zoned    BEGSR
      *
     C                   EXSR      GetPacked
     C                   EXSR      ZonedToOutBuf
      *
     C                   ENDSR
      *
      *============================================================*
      *    ZonedToOutBuf Move zoned value to output buffer         *
      *============================================================*
      *
     C     ZonedToOutBuf Begsr
      *
     C                   Eval      x = f_len(zoned_A) - FLDL0100.F1Digt + 1
      *
     C                   Eval      o_buffLen = FLDL0100.F1DIGT
     C                   Eval      %subst(o_buffer: 1: o_buffLen) =
     C                                %subst(zoned_a: x)
      *
     C                   Endsr
      *
      *============================================================*
      *    F_to_Float    float ==> Float-Format                    *
      *============================================================*
      *
     C     F_to_Float    BEGSR
      *
     C                   Eval      Float = *ZEROS
     C                   EXSR      ExtrFloat
      *
     C                   ENDSR
      *
      *============================================================*
      *    ExtrFloat                                               *
      *============================================================*
      *
     C     ExtrFloat     Begsr
      *
     C                   Eval      pFloat = %addr(i_buffer)
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      Float = FLoat4
     C                   ELSE
     C                   Eval      Float = FLoat8
     C                   ENDIF
      *
     C                   Eval      o_buffer = %editflt(Float)
     C                   Eval      o_buffLen = 23
      *
     C                   Endsr
      *
      *============================================================*
      *    ChgSign       Prüfen auf negatives Vorzeichen           *
      *============================================================*
      *
     C     ChgSign       BEGSR
      *
     C     SET_SignX     IFEQ      bFalse
      *          ohne Vorzeichen ausgeben
     C                   Eval      IsMinus = bFalse
     C                   ELSE
     C     Zoned         IFLT      *ZEROS
     C                   Eval      IsMinus = bTrue
     C                   ELSE
     C                   Eval      IsMinus = bFalse
     C                   Endif
     C                   Endif
      *
     C     IsMinus       IFEQ      bTrue
     C                   MULT      -1            Zoned
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChgSignFloat  Prüfen auf negatives Vorzeichen           *
      *============================================================*
      *
     C     ChgSignFloat  BEGSR
      *
     C     SET_SignX     IFEQ      bFalse
      *          ohne Vorzeichen ausgeben
     C                   Eval      IsMinus = bFalse
     C                   ELSE
     C     Float         IFLT      *ZEROS
     C                   Eval      IsMinus = bTrue
     C                   ELSE
     C                   Eval      IsMinus = bFalse
     C                   Endif
     C                   Endif
      *
     C     IsMinus       IFEQ      bTrue
     C                   MULT      -1            Float
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    AddSign       hinzufügen von Vorzeichen                 *
      *============================================================*
      *
     C     AddSign       BEGSR
      *
     C     SET_SignX     IFEQ      bFalse
      *          ohne Vorzeichen ausgeben
     C                   ELSE
     C     IsMinus       IFEQ      bTrue
     C     SET§SignM     IFEQ      *BLANKS
     C                   Eval      o_buffer = %trimr(o_buffer) + ' '
     C                   ELSE
     C                   Eval      o_buffer = %trimr(o_buffer) + SET§SignM
     C                   Endif
     C                   Eval      o_buffLen = o_buffLen + 1
     C                   ELSE
     C     SET§SignP     IFEQ      *BLANKS
     C                   Eval      o_buffer = %trimr(o_buffer) + ' '
     C                   ELSE
     C                   Eval      o_buffer = %trimr(o_buffer) + SET§SignP
     C                   Endif
     C                   Eval      o_buffLen = o_buffLen + 1
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    AddDlmtr      hinzufügen des Delimeters                 *
      *============================================================*
      *
     C     AddDlmtr      BEGSR
      *
     C     SET_Dlmtr     IFEQ      *BLANKS
      *          ohne Delimeter ausgeben
     C                   ELSE
     C     o_buffLen     IFLT      §rcdBufLen
     C                   Eval      o_buffLen = o_buffLen + 1
     C                   Eval      %subst(
     C                               o_buffer: o_buffLen: 1) = SET_Dlmtr
     C                   ELSE
      *    Pufferbereich zu klein ...
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    A_to_Int      alpha ==> interne Darstellung             *
      *============================================================*
      *
     C     A_to_Int      BEGSR
      *
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      strPos = 3
     C                   Else
     C                   Eval      strPos = 1
     C                   Endif
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = *allx'00'
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = *allx'FF'
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   If        FLDL0100.F1NDBC > 0
     C                   Eval      o_buffLen = FLDL0100.F1NDBC
     C                   Endif
     C                   Eval      o_buffLen =
     C                               cvtToFileCcsid(
     C                                 i_buffer: o_buffLen: FLDL0100.F1FDCC)
     C                   Endif
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = %subst(i_buffer: 1: o_buffLen)
     C                   Other
     C                   Endsl
      *
      *  einfügen Längenangabe bei Feldern variabler Länge                                   R
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Callp     p_decToBin(o_buffer  :
     C                                        1           :
     C                                        2           :
     C                                        o_buffLen  )
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    G_to_Int      graphic => interne Darstellung            *
      *============================================================*
      *
     C     G_to_Int      BEGSR
      *
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      strPos = 3
     C                   Else
     C                   Eval      strPos = 1
     C                   Endif
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = *allx'00'
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = *allx'FF'
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   If        FLDL0100.F1NDBC > 0
     C                   Eval      o_buffLen = FLDL0100.F1NDBC
     C                   Endif
     C                   Eval      o_buffLen =
     C                               cvtToFileCcsid(
     C                                 i_buffer: o_buffLen: FLDL0100.F1FDCC)
     C                   Endif
     C                   Eval      %subst(o_buffer: strPos: o_buffLen)
     C                                = %subst(i_buffer: 1: o_buffLen)
     C                   Other
     C                   Endsl
      *
      *  einfügen Längenangabe bei Feldern variabler Länge
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Callp     p_decToBin(o_buffer  :
     C                                        1           :
     C                                        2           :
     C                                        o_buffLen  )
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    S_to_Int      Zoned ==> interne Darstellung             *
      *============================================================*
      *
     C     S_to_Int      BEGSR
      *
      *  umsetzen in gezonten Wert ...
     C                   EXSR      CvtToZoned
      *
      *  umsetzen gezont -> gezont ...
     C                   Eval      Zoned = Zoned
      *
      *  extrahieren gezonten Wert ...
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      x = f_len(zoned_A) - o_buffLen + 1
     C                   Eval      o_buffer = %subst(Zoned_A: x: o_buffLen)
      *
     C                   ENDSR
      *
      *============================================================*
      *    B_to_Int      Binary ==> interne Darstellung            *
      *============================================================*
      *
     C     B_to_Int      BEGSR
      *
     C                   SELECT
     C                   WHEN      f_buffln(FLDL0100) = 1
     C                   EXSR      B_to_Int1
     C                   WHEN      f_buffln(FLDL0100) = 2
     C                   EXSR      B_to_Int2
     C                   WHEN      f_buffln(FLDL0100) = 4
     C                   EXSR      B_to_Int4
     C                   WHEN      f_buffln(FLDL0100) = 8
     C                   EXSR      B_to_Int8
     C                   OTHER
     C                   CALLP     p_kill('Illegal buffer length: ' +
     C                                    %char(f_buffln(FLDL0100)))
     C                   ENDSL
      *
     C                   ENDSR
      *
      *============================================================*
      *    B_to_Int1     Binary ==> interne Darstellung 1-Byte     *
      *============================================================*
      *
     C     B_to_Int1     BEGSR
      *
     C                   SELECT
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      Binary1 = *LOVAL
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      Binary1 = *HIVAL
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Eval      Binary1 = Zoned
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(binary1_A: 1: o_buffLen)
      *
     C                   Endsr
      *
      *============================================================*
      *    B_to_Int2     Binary ==> interne Darstellung 2-Byte     *
      *============================================================*
      *
     C     B_to_Int2     BEGSR
      *
     C                   SELECT
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      Binary2 = *LOVAL
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      Binary2 = *HIVAL
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Eval      Binary2 = Zoned
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(binary2_A: 1: o_buffLen)
      *
     C                   Endsr
      *
      *============================================================*
      *    B_to_Int4     Binary ==> interne Darstellung 4-Byte     *
      *============================================================*
      *
     C     B_to_Int4     BEGSR
      *
     C                   SELECT
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      Binary4 = *LOVAL
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      Binary4 = *HIVAL
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Eval      Binary4 = Zoned
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(binary4_A: 1: o_buffLen)
      *
     C                   Endsr
      *
      *============================================================*
      *    B_to_Int8     Binary ==> interne Darstellung 8-Byte     *
      *============================================================*
      *
     C     B_to_Int8     BEGSR
      *
     C                   SELECT
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      Binary8 = *LOVAL
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      Binary8 = *HIVAL
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Eval      Binary8 = Zoned
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(binary8_A: 1: o_buffLen)
      *
     C                   Endsr
      *
      *============================================================*
      *    P_to_Int      Packed ==> interne Darstellung            *
      *============================================================*
      *
     C     P_to_Int      BEGSR
      *
      *  umsetzen in gezonten Wert ...
     C                   EXSR      CvtToZoned
      *
      *  umsetzen gezont -> gepacked ...
     C                   Eval      packed = zoned
      *
      *  extrahieren Binärwert ...
     C                   Eval      x = f_len(packed_a) - f_buffln(FLDL0100) + 1
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(packed_a: x: o_buffLen)
      *
     C                   ENDSR
      *
      *============================================================*
      *    F_to_Int      Float  ==> interne Darstellung            *
      *============================================================*
      *
     C     F_to_Int      BEGSR
      *
     C                   EXSR      CvtToFloat
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = dsFloat
      *
     C                   ENDSR
      *
      *============================================================*
      *    L_to_Int      Datum ==> interne Darstellung             *
      *============================================================*
      *
     C     L_to_Int      BEGSR
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      R_DateISO = *LOVAL
     C                   EXSR      dateToBuffer
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      R_DateISO = *HIVAL
     C                   EXSR      dateToBuffer
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   Eval      o_buffer = i_buffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(o_buffer:1:o_buffLen)
      *
      *  Wert überprüfen über PEEK36 ...
     C                   EXSR      ChkValue
      *
     C                   ENDSR
      *
      *============================================================*
      *    dateToBuffer  Übertragen und konvertieren Datumsfeld    *
      *                  nach Ausgabepuffer.                       *
      *============================================================*
      *
     C     dateToBuffer  BEGSR
      *
      *  Übertragen Zeitfeld gemäß Format ...
     C                   SELECT
      *  ... *EUR (dd.mm.yyyy)
     C                   WHEN      FLDL0100.F1DTFM = '*EUR'
     C                   Eval      R_DateBuf = %char(R_DateISO: *EUR)
     C                   Eval      R_DftSp = '.'
      *  ... *ISO (yyyy-mm-dd)
     C                   OTHER
     C                   Eval      R_DateBuf = %char(R_DateISO: *ISO)
     C                   Eval      R_DftSp = '-'
     C                   ENDSL
      *
     C                   IF        (FLDL0100.F1DTSP <> ' '    ) and
     C                             (FLDL0100.F1DTSP <> R_DftSp)
     C                   Eval      o_buffer =
     C                               %xlate(R_DftSp: FLDL0100.F1DTSP: R_DateBuf)
     C                   ELSE
     C                   Eval      o_buffer = R_DateBuf
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    T_to_Int      Zeit  ==> interne Darstellung             *
      *============================================================*
      *
     C     T_to_Int      BEGSR
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      R_TimeISO = *LOVAL
     C                   EXSR      timeToBuffer
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      R_TimeISO = *HIVAL
     C                   EXSR      timeToBuffer
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   Eval      o_buffer = i_buffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(o_buffer:1:o_buffLen)
      *
      *  Wert überprüfen über PEEK36 ...
     C                   EXSR      ChkValue
      *
     C                   ENDSR
      *
      *============================================================*
      *    timeToBuffer  Übertragen und konvertieren Zeitfeld      *
      *                  nach Ausgabepuffer.                       *
      *============================================================*
      *
     C     timeToBuffer  BEGSR
      *
      *  Übertragen Zeitfeld gemäß Format ...
     C                   SELECT
      *  ... *HMS (hh:mm:ss)
     C                   WHEN      FLDL0100.F1DTFM = '*HMS'
     C                   Eval      R_TimeBuf = %char(R_TimeISO: *HMS)
     C                   Eval      R_DftSp = ':'
      *  ... *EUR (hh.mm.ss)
     C                   WHEN      FLDL0100.F1DTFM = '*EUR'
     C                   Eval      R_TimeBuf = %char(R_TimeISO: *EUR)
     C                   Eval      R_DftSp = '.'
      *  ... *ISO (hh.mm.ss)
     C                   OTHER
     C                   Eval      R_TimeBuf = %char(R_TimeISO: *ISO)
     C                   Eval      R_DftSp = '.'
     C                   ENDSL
      *
     C                   IF        (FLDL0100.F1DTSP <> ' '    ) and
     C                             (FLDL0100.F1DTSP <> R_DftSp)
     C                   Eval      o_buffer =
     C                               %xlate(R_DftSp: FLDL0100.F1DTSP: R_TimeBuf)
     C                   ELSE
     C                   Eval      o_buffer = R_TimeBuf
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    Z_to_Int      Zeitstempel=> interne Darstellung         *
      *============================================================*
      *
     C     Z_to_Int      BEGSR
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      R_TimeStmp = *LOVAL
     C                   Eval      o_buffer = %char(R_TimeStmp: *ISO)
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      R_TimeStmp = *HIVAL
     C                   Eval      o_buffer = %char(R_TimeStmp: *ISO)
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   Eval      o_buffer = i_buffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      o_buffLen = f_buffLn(FLDL0100)
     C                   Eval      o_buffer = %subst(o_buffer:1:o_buffLen)
      *
      *  Wert überprüfen über PEEK36 ...
     C                   EXSR      ChkValue
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkValue      Prüfen Wert im Zeit-, Datums-,            *
      *                  oder Zeitstempelfeld                      *
      *============================================================*
      *
     C     ChkValue      BEGSR
      *
     C                   CALLP     PEEK36(o_buffer
     C                                    : FLDL0100.F1DTyp
     C                                    : FLDL0100.F1DTFM
     C                                    : FLDL0100.F1DTSP
     C                                    : YMsgID: YMsgDta)
     C     YMsgID        IFEQ      *BLANKS
      *   Alles in Ordnung ...
     C                   ELSE
     C                   Eval      o_msgID = YMsgID
     C                   Eval      o_msgDta = YMsgDta
     C                   GOTO      ENDE
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    CvtToZoned                                              *
      *============================================================*
      *
     C     CvtToZoned    BEGSR
      *
     C                   Eval      Zoned = *ZEROS
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      Zoned = *LOVAL
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      Zoned = *HIVAL
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *
      *  ... Vorzeichen
     C     SET_SignX     IFEQ      bFalse
      *            ohne Vorzeichen
     C                   ELSE
      *            mit Vorzeichen
      *      ... Vorzeichen extrahieren
     C                   Eval      x = FLDL0100.F1Digt + 1
     C     X             IFLE      §rcdBufLen
     C                   Eval      A1 = %subst(i_buffer: X: 1)
     C                   ELSE
     C                   Eval      A1 = *BLANKS
     C                   Endif
      *      ... auf definiertes Minus-Zeichen prüfen
     C     A1            IFEQ      SET§SignM
     C                   Eval      IsMinus = bTrue
     C                   ELSE
     C                   Eval      IsMinus = bFalse
     C                   Endif
     C                   Endif
      *
      *  ... Wert
     C                   Eval      x = f_len(zoned_A) - FLDL0100.F1Digt + 1
     C                   Eval      %subst(Zoned_A: x) =
     C                                %subst(i_buffer: 1: FLDL0100.F1Digt)
     C                   EVAL      Zoned_A = %xlate(' ':'0' : Zoned_A)
      *
      *  ... gültige numerische Daten prüfen
     C                   IF        (%check(§Numeric: Zoned_A) > 0)              = Fehler
     C                   Eval      o_msgID = 'USR8138'
     C                   Eval      USR81381 = FLDL0100.F1FNme
     C                   Eval      o_msgDta = USR8138
     C                   GOTO      ENDE
     C                   ELSE
      *               Alles klar
     C                   Endif
      *
      *  ... negativer Wert
     C     IsMinus       IFEQ      bTrue
     C                   MULT      -1            Zoned
     C                   ELSE
      *              positiver Wert
     C                   Endif
      *
     C                   OTHER
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    CvtToFloat                                              *
      *============================================================*
      *
     C     CvtToFloat    BEGSR
      *
     C                   Eval      Float = *ZEROS
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      dsFloat.float4 = *LOVAL
     C                   ELSE
     C                   Eval      dsFloat.float8 = *LOVAL
     C                   ENDIF
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      dsFloat.float4 = *HIVAL
     C                   ELSE
     C                   Eval      dsFloat.float8 = *HIVAL
     C                   ENDIF
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      x = 14
     C                   ELSE
     C                   Eval      x = 23
     C                   ENDIF
      *
      *  ... Vorzeichen
     C     SET_SignX     IFEQ      bFalse
      *            ohne Vorzeichen
     C                   ELSE
      *            mit Vorzeichen
      *      ... Vorzeichen extrahieren
     C     X             IFLE      §rcdBufLen
     C                   Eval      A1 = %subst(i_buffer: X: 1)
     C                   ELSE
     C                   Eval      A1 = *BLANKS
     C                   Endif
      *      ... auf definiertes Minus-Zeichen prüfen
     C     A1            IFEQ      SET§SignM
     C                   Eval      IsMinus = bTrue
     C                   ELSE
     C                   Eval      IsMinus = bFalse
     C                   Endif
     C                   Endif
      *
      *  ... gültige numerische Daten prüfen
     C                   IF        f_vldFloat(%subst(i_buffer: 1: x-1)) = bFalse
     C                   Eval      o_msgID = 'USR8138'
     C                   Eval      USR81381 = FLDL0100.F1FNme
     C                   Eval      o_msgDta = USR8138
     C                   GOTO      ENDE
     C                   ELSE
      *               Alles klar
     C                   Endif
      *
      *  ... Wert
     C                   Eval      Float = %float(%subst(i_buffer: 1: x-1))
      *
      *  ... negativer Wert
     C     IsMinus       IFEQ      bTrue
     C                   MULT      -1            FLoat
     C                   ELSE
      *              positiver Wert
     C                   Endif
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      dsFloat.float4 = Float
     C                   ELSE
     C                   Eval      dsFloat.float8 = Float
     C                   ENDIF
      *
     C                   OTHER
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetZoned      Umsetzen ZONED to ZONED                   *
      *============================================================*
      *
     C     GetZoned      BEGSR
      *
     C                   Eval      zoned = 0
      *
     C                   Eval      x = f_len(zoned_A) - f_buffLn(FLDL0100) + 1
      *
     C                   Eval      %subst(zoned_a: x) =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      Zoned = Zoned
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetBinary     Umsetzen BINARY to ZONED                  *
      *============================================================*
      *
     C     GetBinary     Begsr
      *
     C                   SELECT
     C                   WHEN      f_buffln(FLDL0100) = 1
     C                   EXSR      GetBinary1
     C                   WHEN      f_buffln(FLDL0100) = 2
     C                   EXSR      GetBinary2
     C                   WHEN      f_buffln(FLDL0100) = 4
     C                   EXSR      GetBinary4
     C                   WHEN      f_buffln(FLDL0100) = 8
     C                   EXSR      GetBinary8
     C                   OTHER
     C                   CALLP     p_kill('Illegal buffer length: ' +
     C                                    %char(f_buffln(FLDL0100)))
     C                   ENDSL
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetBinary1    Umsetzen BINARY to ZONED    1-Byte        *
      *============================================================*
      *
     C     GetBinary1    Begsr
      *
     C                   Eval      binary1 = 0
      *
     C                   Eval      binary1_A =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      zoned = binary1
      *
     C                   Endsr
      *
      *============================================================*
      *    GetBinary2    Umsetzen BINARY to ZONED    2-Byte        *
      *============================================================*
      *
     C     GetBinary2    Begsr
      *
     C                   Eval      binary2 = 0
      *
     C                   Eval      binary2_A =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      zoned = binary2
      *
     C                   Endsr
      *
      *============================================================*
      *    GetBinary4    Umsetzen BINARY to ZONED    4-Byte        *
      *============================================================*
      *
     C     GetBinary4    Begsr
      *
     C                   Eval      binary4 = 0
      *
     C                   Eval      binary4_A =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      zoned = binary4
      *
     C                   Endsr
      *
      *============================================================*
      *    GetBinary8    Umsetzen BINARY to ZONED    8-Byte        *
      *============================================================*
      *
     C     GetBinary8    Begsr
      *
     C                   Eval      binary8 = 0
      *
     C                   Eval      binary8_A =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      zoned = binary8
      *
     C                   Endsr
      *
      *============================================================*
      *    GetPacked     Umsetzen PACKED to ZONED                  *
      *============================================================*
      *
     C     GetPacked     Begsr
      *
     C                   Eval      packed = 0
      *
     C                   Eval      x = f_len(packed_a) - f_buffLn(FLDL0100) + 1
      *
     C                   Eval      %subst(packed_a: x) =
     C                                %subst(i_buffer: 1: f_buffLn(FLDL0100))
      *
     C                   Eval      zoned = packed
      *
     C                   Endsr
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
      *  *ACCESSKEY
     C                   Eval      SET0003 = f_getUsrSg('*ACCESSKEY')
      *
     C     SET_SignP     IFEQ      *BLANKS
     C                   Eval      SET§SignP = *BLANKS
     C                   ELSE
     C                   Eval      SET§SignP = SET_SignP
     C                   Endif
      *
     C     SET_SignM     IFEQ      *BLANKS
     C                   Eval      SET§SignM = '-'
     C                   ELSE
     C                   Eval      SET§SignM = SET_SignM
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetKeyType    Ermitteln, ob Schlüsselfeld und ob        *
      *                  Descending oder Ascending                 *
      *============================================================*
      *
     C     GetKeyType    BEGSR
      *
     C                   Eval      F_Field = FLDL0100.F1FNme
     C     F_Key         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
     C                   CLEAR                   FPEEKFLD
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Programm initialisieren
      ***                Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   Eval      o_msgID = *BLANKS
     C                   Eval      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         Begsr
      *
     C                   If        (isInzSr = bTrue)
     C                   Leavesr
     C                   Endif
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      PEEK36_NAME = f_pgmCallN('PEEK36')
      *
     C                   OPEN      PEEKFLD
      *
     C                   EXSR      GetUsrSetg
      *
     C                   ENDSR
      *
      *============================================================*
      *    Converts a given buffer intot he Job ccsid.             *
      *============================================================*
     P cvtToJobCcsid   b
     D                 pi            10i 0
     D  io_buffer                          like(r§rcdBuf)
     D  i_length                     10i 0 value
     D  i_ccsid                      10i 0 value
      *
     D tLength         s             10i 0
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     C                   Eval      hTranscoder = Transcoder_toJobCcsid(i_ccsid)
     C                   Eval      tLength =
     C                                Transcoder_xlateBuffer(hTranscoder
     C                                                       : %addr(io_buffer)
     C                                                       : i_length
     C                                                       :%size(io_buffer))
     C                   If        (i_length > tLength)
     C                   Eval      %subst(io_buffer
     C                                    : tLength+1
     C                                    : i_length-tLength) = ''
     C                   Endif
      *
     C                   Return    tLength
      *
     P                 e
      *
      *============================================================*
      *    Converts a given buffer into the File ccsid.            *
      *============================================================*
     P cvtToFileCcsid  b
     D                 pi            10i 0
     D  io_buffer                          like(r§rcdBuf)
     D  i_length                     10i 0 value
     D  i_ccsid                      10i 0 value
      *
     D tLength         s             10i 0
      * - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      *
     C                   Eval      hTranscoder =
     C                                Transcoder_toFieldCcsid(i_ccsid)
     C                   Eval      tLength =
     C                                Transcoder_xlateBuffer(hTranscoder
     C                                                       : %addr(io_buffer)
     C                                                       : i_length
     C                                                       :%size(io_buffer))
     C                   If        (i_length > tLength)
     C                   Eval      %subst(io_buffer
     C                                    : tLength+1
     C                                    : i_length-tLength) = *ALLx'00'
     C                   Endif
      *
     C                   Return    tLength
      *
     P                 e
      *
      *============================================================*
      *  Program error handler                                     *
      *============================================================*
      *
     P errorHandler    b
     D                 pi
     D i_condToken                         value likeds(cee_fc_t)
     D i_pCommArea                   10i 0 value
     D o_action                      10i 0
     D o_newCondToken                            likeds(cee_fc_t)
      /free

         dump;
         o_action = CEE_PERCOLATE;

      /end-free
     P                 e
      *
