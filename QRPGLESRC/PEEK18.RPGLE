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
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F_)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
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
     D XData           S            512A
     D XFormat         S             10A
     D XBuffer         S                   like(r§rcdBuf  )
     D XTgtFormat      S             10A
     D XTgtValue       S             10A
     D XOutBuffer      S                   like(r§rcdBuf  )
     D XOutBuffTb      S              1A   based(ptrXBuffTb)
     D                                     dim(§rcdBufLen)
     D XOutBuffLn      S                   like(r§int4    )
     D XMsgID          S              7A
     D XMsgDta         S            512A
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
     D R_TgtValue      S                         LIKE(XTgtValue) INZ(*BLANKS)
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
     D PEEK36          S                   like(r§pgmCallN) inz
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
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XData
     C                   PARM                    XFormat
     C                   PARM                    XBuffer
     C                   PARM                    XTgtFormat
     C                   PARM                    XTgtValue
     C                   PARM                    XOutBuffer
     C                   PARM                    XOutBuffLn
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK36
     C     P_Peek36      PLIST
     C                   PARM                    YBuffer
     C                   PARM                    YType
     C                   PARM                    YDatTimFmt
     C                   PARM                    YSeparator
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F_KEY         KLIST
     C                   KFLD                    F_Field
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   MOVEL (P) XData         FLDL0100
      *
     C                   MOVEL (P) *BLANKS       XOutBuffer
     C                   Z-ADD     *ZEROS        XOutBuffLn
      *
     C                   SELECT
     C     XTgtFormat    WHENEQ    '*EXTERN'
     C                   EXSR      ToExtern
     C     XTgtFormat    WHENEQ    '*INTERN'
     C                   EXSR      ToIntern
     C     XTgtFormat    WHENEQ    '*ZONED'
     C                   EXSR      ToZoned
     C     XTgtFormat    WHENEQ    '*FLOAT'
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
     C                   MOVEL (P) XTgtValue     R_TgtValue
     C                   ELSE
      *  Descending key ...
     C     XTgtValue     IFEQ      '*HIVAL'
     C     XTgtValue     OREQ      '*LOVAL'
      *  ... *HIVAL ==> *LOVAL und umgekehrt
     C     XTgtValue     IFEQ      '*HIVAL'
     C                   MOVEL (P) '*LOVAL'      R_TgtValue
     C                   ELSE
     C                   MOVEL (P) '*HIVAL'      R_TgtValue
     C                   Endif
     C                   ELSE
      *  ... Keine Umsetzung erforderlich
     C                   MOVEL (P) XTgtValue     R_TgtValue
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
     C                   Eval      xOutBuffer =
     C                               %subst(xBuffer: strPos: f_buffLn(FLDL0100))
      *
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
      *
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   Eval      xOutBuffLn =
     C                             cvtToJobCcsid(
     C                               xOutBuffer: xOutBuffLn: FLDL0100.F1FDCC)
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
     C                   Eval      xOutBuffer =
     C                               %subst(xBuffer: strPos: f_buffLn(FLDL0100))
      *
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
      *
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   Eval      xOutBuffLn =
     C                             cvtToJobCcsid(
     C                               xOutBuffer: xOutBuffLn: FLDL0100.F1FDCC)
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
     C                   EVAL      pFloat = %addr(xBuffer)
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      Float = FLoat4
     C                   EXSR      ChgSignFloat
     C                   Eval      Float4 = FLoat
     C                   EVAL      XOutBuffer = %editflt(Float4)
     C                   Eval      XOutBuffLn = 14
     C                   ELSE
     C                   Eval      Float = FLoat8
     C                   EXSR      ChgSignFloat
     C                   Eval      Float8 = FLoat
     C                   EVAL      XOutBuffer = %editflt(Float8)
     C                   Eval      XOutBuffLn = 23
     C                   ENDIF
      *
      *  Entfernen führendes Vorzeichen
     C                   EVAL      XOutBuffer = %subst(XOutBuffer: 2)
     C                   Eval      XOutBuffLn = XOutBuffLn - 1
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
     C                   Z-ADD     *ZEROS        Zoned
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
     C                   Eval      xOutBuffLn = FLDL0100.F1DIGT
     C                   Eval      %subst(xOutBuffer: 1: xOutBuffLn) =
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
     C                   Z-ADD     *ZEROS        Float
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
     C                   EVAL      pFloat = %addr(xBuffer)
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   Eval      Float = FLoat4
     C                   ELSE
     C                   Eval      Float = FLoat8
     C                   ENDIF
      *
     C                   EVAL      XOutBuffer = %editflt(Float)
     C                   Eval      XOutBuffLn = 23
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
     C                   MOVEL (P) bFalse        IsMinus
     C                   ELSE
     C     Zoned         IFLT      *ZEROS
     C                   MOVEL (P) bTrue         IsMinus
     C                   ELSE
     C                   MOVEL (P) bFalse        IsMinus
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
     C                   MOVEL (P) bFalse        IsMinus
     C                   ELSE
     C     Float         IFLT      *ZEROS
     C                   MOVEL (P) bTrue         IsMinus
     C                   ELSE
     C                   MOVEL (P) bFalse        IsMinus
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
     C                   CAT   (P) ' ':1         XOutBuffer
     C                   ELSE
     C                   CAT   (P) SET§SignM:0   XOutBuffer
     C                   Endif
     C                   ADD       1             XOutBuffLn
     C                   ELSE
     C     SET§SignP     IFEQ      *BLANKS
     C                   CAT   (P) ' ':1         XOutBuffer
     C                   ELSE
     C                   CAT   (P) SET§SignP:0   XOutBuffer
     C                   Endif
     C                   ADD       1             XOutBuffLn
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
     C     XOutBuffLn    IFLT      §rcdBufLen
     C                   ADD       1             XOutBuffLn
     C                   Z-ADD     XOutBuffLn    BL
     C                   MOVEL (P) SET_Dlmtr     XOutBuffTb(BL)
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
     C                   Eval      XOutBuffLn = f_buffLn(FLDL0100)
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = *allx'00'
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = *allx'FF'
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   If        FLDL0100.F1NDBC > 0
     C                   Eval      xOutBuffLn = FLDL0100.F1NDBC
     C                   Endif
     C                   Eval      XOutBuffLn =
     C                               cvtToFileCcsid(
     C                                 xBuffer: xOutBuffLn: FLDL0100.F1FDCC)
     C                   Endif
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = %subst(xBuffer: 1: XOutBuffLn)
     C                   Other
     C                   Endsl
      *
      *  einfügen Längenangabe bei Feldern variabler Länge                                   R
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Callp     p_decToBin(xOutBuffer  :
     C                                        1           :
     C                                        2           :
     C                                        XOutBuffLn  )
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
     C                   Eval      XOutBuffLn = f_buffLn(FLDL0100)
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = *allx'00'
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = *allx'FF'
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   If        f_hasCcsid(FLDL0100) = bTrue
    R ***                          AND f_mustCvtCcsid() = bTrue
     C                   If        FLDL0100.F1NDBC > 0
     C                   Eval      xOutBuffLn = FLDL0100.F1NDBC
     C                   Endif
     C                   Eval      XOutBuffLn =
     C                               cvtToFileCcsid(
     C                                 xBuffer: xOutBuffLn: FLDL0100.F1FDCC)
     C                   Endif
     C                   Eval      %subst(xOutBuffer: strPos: XOutBuffLn)
     C                                = %subst(xBuffer: 1: XOutBuffLn)
     C                   Other
     C                   Endsl
      *
      *  einfügen Längenangabe bei Feldern variabler Länge
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Callp     p_decToBin(xOutBuffer  :
     C                                        1           :
     C                                        2           :
     C                                        XOutBuffLn  )
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
     C                   Z-ADD     Zoned         Zoned
      *
      *  extrahieren gezonten Wert ...
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      x = f_len(zoned_A) - xOutBuffLn + 1
     C                   Eval      xOutBuffer = %subst(Zoned_A: x: xOutBuffLn)
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
     C                   EXSR      *PSSR
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
     C                   Z-ADD     *LOVAL        Binary1
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Z-ADD     *HIVAL        Binary1
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Z-ADD     Zoned         Binary1
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(binary1_A: 1: xOutBuffLn)
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
     C                   Z-ADD     *LOVAL        Binary2
    R ***                Z-ADD     Binary2       Zoned
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Z-ADD     *HIVAL        Binary2
    R ***                Z-ADD     Binary2       Zoned
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Z-ADD     Zoned         Binary2
    R ***                Z-ADD     Binary2       Zoned
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(binary2_A: 1: xOutBuffLn)
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
     C                   Z-ADD     *LOVAL        Binary4
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Z-ADD     *HIVAL        Binary4
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Z-ADD     Zoned         Binary4
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(binary4_A: 1: xOutBuffLn)
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
     C                   Z-ADD     *LOVAL        Binary8
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Z-ADD     *HIVAL        Binary8
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *  ... umsetzen in gezonten Wert
     C                   EXSR      CvtToZoned
     C                   Z-ADD     Zoned         Binary8
     C                   Other
     C                   Endsl
      *
      *  extrahieren Binärwert ...
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(binary8_A: 1: xOutBuffLn)
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
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(packed_a: x: xOutBuffLn)
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
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = dsFloat
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
     C                   MOVEL     *LOVAL        R_DateISO
     C                   EXSR      dateToBuffer
    R ***                MOVEL (P) R_DateISO     XOutBuffer
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   MOVEL     *HIVAL        R_DateISO
     C                   EXSR      dateToBuffer
    R ***                MOVEL (P) R_DateISO     XOutBuffer
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   MOVEL (P) XBuffer       XOutBuffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(xOutBuffer:1:xOutBuffLn)
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
     C     *EUR          MOVEL (P) R_DateISO     R_DateBuf
     C                   EVAL      R_DftSp = '.'
      *  ... *ISO (yyyy-mm-dd)
     C                   OTHER
     C                   MOVEL (P) R_DateISO     R_DateBuf
     C                   EVAL      R_DftSp = '-'
     C                   ENDSL
      *
     C                   IF        (FLDL0100.F1DTSP <> ' '    ) and
     C                             (FLDL0100.F1DTSP <> R_DftSp)
     C**   R_DftSp:F1DTSPXLATE     R_DateBuf     XOutBuffer
     C                   EVAL      XOutBuffer =
     C                               %xlate(R_DftSp: FLDL0100.F1DTSP: R_DateBuf)
     C                   ELSE
     C                   MOVEL (P) R_DateBuf     XOutBuffer
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
     C                   MOVEL     *LOVAL        R_TimeISO
     C                   EXSR      timeToBuffer
    R ***                MOVEL (P) R_TimeISO     XOutBuffer
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   MOVEL     *HIVAL        R_TimeISO
     C                   EXSR      timeToBuffer
    R ***                MOVEL (P) R_TimeISO     XOutBuffer
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   MOVEL (P) XBuffer       XOutBuffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(xOutBuffer:1:xOutBuffLn)
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
     C     *HMS          MOVEL (P) R_TimeISO     R_TimeBuf
     C                   EVAL      R_DftSp = ':'
      *  ... *EUR (hh.mm.ss)
     C                   WHEN      FLDL0100.F1DTFM = '*EUR'
     C     *EUR          MOVEL (P) R_TimeISO     R_TimeBuf
     C                   EVAL      R_DftSp = '.'
      *  ... *ISO (hh.mm.ss)
     C                   OTHER
     C                   MOVEL (P) R_TimeISO     R_TimeBuf
     C                   EVAL      R_DftSp = '.'
     C                   ENDSL
      *
     C                   IF        (FLDL0100.F1DTSP <> ' '    ) and
     C                             (FLDL0100.F1DTSP <> R_DftSp)
     C**   R_DftSp:F1DTSPXLATE     R_TimeBuf     XOutBuffer
     C                   EVAL      XOutBuffer =
     C                               %xlate(R_DftSp: FLDL0100.F1DTSP: R_TimeBuf)
     C                   ELSE
     C                   MOVEL (P) R_TimeBuf     XOutBuffer
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    Z_to_Int      Stempel=> interne Darstellung             *
      *============================================================*
      *
     C     Z_to_Int      BEGSR
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   MOVEL     *LOVAL        R_TimeStmp
     C                   MOVEL (P) R_TimeStmp    XOutBuffer
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   MOVEL     *HIVAL        R_TimeStmp
     C                   MOVEL (P) R_TimeStmp    XOutBuffer
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   MOVEL (P) XBuffer       XOutBuffer
     C                   OTHER
     C                   Endsl
      *
     C                   Eval      xOutBuffLn = f_buffLn(FLDL0100)
     C                   Eval      xOutBuffer = %subst(xOutBuffer:1:xOutBuffLn)
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
     C                   eval      YBuffer = XOutBuffer
     C                   eval      YType = FLDL0100.F1DTyp
     C                   eval      YDatTimFmt = FLDL0100.F1DTFM
     C                   eval      YSeparator = FLDL0100.F1DTSP
     C                   CALL      PEEK36        P_Peek36
     C     YMsgID        IFEQ      *BLANKS
      *   Alles in Ordnung ...
     C                   ELSE
     C                   MOVEL (P) YMsgID        XMsgID
     C                   MOVEL (P) YMsgDta       XMsgDta
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
     C                   Z-ADD     *ZEROS        Zoned
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   Z-ADD     *LOVAL        Zoned
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   Z-ADD     *HIVAL        Zoned
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
      *
      *  ... Vorzeichen
     C     SET_SignX     IFEQ      bFalse
      *            ohne Vorzeichen
     C                   ELSE
      *            mit Vorzeichen
      *      ... Vorzeichen extrahieren
     C**   F1Digt        ADD       1             X
     C                   EVAL      x = FLDL0100.F1Digt + 1
     C     X             IFLE      §rcdBufLen
     C     1             SUBST (P) XBuffer:X     A1
     C                   ELSE
     C                   MOVEL (P) *BLANKS       A1
     C                   Endif
      *      ... auf definiertes Minus-Zeichen prüfen
     C     A1            IFEQ      SET§SignM
     C                   MOVEL (P) bTrue         IsMinus
     C                   ELSE
     C                   MOVEL (P) bFalse        IsMinus
     C                   Endif
     C                   Endif
      *
      *  ... Wert
     C                   Eval      x = f_len(zoned_A) - FLDL0100.F1Digt + 1
     C                   Eval      %subst(Zoned_A: x) =
     C                                %subst(XBuffer: 1: FLDL0100.F1Digt)
     C     ' ':'0'       XLATE     Zoned_A       Zoned_A
      *
      *  ... gültige numerische Daten prüfen
     C     §Numeric      CHECK     Zoned_A                                99
     C     *IN99         IFEQ      '1'                                          = Fehler
     C                   EVAL      XMsgID = 'USR8138'
     C                   EVAL      USR81381 = FLDL0100.F1FNme
     C                   EVAL      XMsgDta = USR8138
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
     C                   Z-ADD     *ZEROS        Float
      *
     C                   SELECT
      *  kleinester Wert ...
     C     R_TgtValue    WHENEQ    '*LOVAL'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   EVAL      dsFloat.float4 = *LOVAL
     C                   ELSE
     C                   EVAL      dsFloat.float8 = *LOVAL
     C                   ENDIF
      *  größter Wert ...
     C     R_TgtValue    WHENEQ    '*HIVAL'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   EVAL      dsFloat.float4 = *HIVAL
     C                   ELSE
     C                   EVAL      dsFloat.float8 = *HIVAL
     C                   ENDIF
      *  aktueller Wert ...
     C     R_TgtValue    WHENEQ    '*CURRENT'
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   EVAL      x = 14
     C                   ELSE
     C                   EVAL      x = 23
     C                   ENDIF
      *
      *  ... Vorzeichen
     C     SET_SignX     IFEQ      bFalse
      *            ohne Vorzeichen
     C                   ELSE
      *            mit Vorzeichen
      *      ... Vorzeichen extrahieren
     C     X             IFLE      §rcdBufLen
     C     1             SUBST (P) XBuffer:X     A1
     C                   ELSE
     C                   MOVEL (P) *BLANKS       A1
     C                   Endif
      *      ... auf definiertes Minus-Zeichen prüfen
     C     A1            IFEQ      SET§SignM
     C                   MOVEL (P) bTrue         IsMinus
     C                   ELSE
     C                   MOVEL (P) bFalse        IsMinus
     C                   Endif
     C                   Endif
      *
      *  ... gültige numerische Daten prüfen
     C                   IF        f_vldFloat(%subst(xBuffer: 1: x-1)) = bFalse
     C                   EVAL      XMsgID = 'USR8138'
     C                   EVAL      USR81381 = FLDL0100.F1FNme
     C                   EVAL      XMsgDta = USR8138
     C                   GOTO      ENDE
     C                   ELSE
      *               Alles klar
     C                   Endif
      *
      *  ... Wert
     C                   Eval      Float = %float(%subst(xBuffer: 1: x-1))
      *
      *  ... negativer Wert
     C     IsMinus       IFEQ      bTrue
     C                   MULT      -1            FLoat
     C                   ELSE
      *              positiver Wert
     C                   Endif
      *
     C                   IF        f_buffLn(FLDL0100) = 4
     C                   EVAL      dsFloat.float4 = Float
     C                   ELSE
     C                   EVAL      dsFloat.float8 = Float
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                   EXSR      *PSSR
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                                %subst(xBuffer: 1: f_buffLn(FLDL0100))
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
     C                   MOVEL (P) *BLANKS       SET§SignP
     C                   ELSE
     C                   MOVEL (P) SET_SignP     SET§SignP
     C                   Endif
      *
     C     SET_SignM     IFEQ      *BLANKS
     C                   MOVEL (P) '-'           SET§SignM
     C                   ELSE
     C                   MOVEL (P) SET_SignM     SET§SignM
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
     C                   EVAL      F_Field = FLDL0100.F1FNme
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
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   Eval      ptrXBuffTb = %addr(xOutBuffer)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK36 = f_pgmCallN('PEEK36')
      *
     C                   OPEN      PEEKFLD
      *
     C                   EXSR      GetUsrSetg
      *
     C                   ENDSR
      *
      *============================================================*
      *    *PSSR         Fehlerbehandlung                          *
      *============================================================*
      *
     C     *PSSR         BEGSR
      *
     C                   DUMP
      *
     C                   ENDSR     '*CANCL'
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
