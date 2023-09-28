      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK06                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.09.97  RADDATZ                                 *
      *                                                               *
      *  geändert : 11.10.06  für Version 2.4.1                       *
      *                       added support for  3I0 fields           *
      *                       added support for 20I0 fields           *
      *                                                               *
      *             29.07.20  Anzeigen Float Sonderwerte 'NaN' und    *
      *                       'Inf' eingebaut.                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Peek/400 - Konvertieren intern ==> extern m. Edit            *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  INPUT-Parameter:                                             *
      *  ================                                             *
      *                                                               *
      *  XData     - Data of FLDL0100                                 *
      *  XFormat   - Format name                                      *
      *  XSrcVar   - Source variable                                  *
      *  XQcmdexc  - Convert numeric data for QCMDEXC                 *
      *  XCvtCcsid - Convert string CCSID                             *
      *                                                               *
      *  OUTPUT-Parameter:                                            *
      *  =================                                            *
      *                                                               *
      *  XString   - Output string                                    *
      *  XStrLen   - Output string length                             *
      *  XMsgID    - MsgID                                            *
      *  XMsgDta   - Msg data                                         *
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
      *----------------------------------------------------*
      *  API - DATENSTRUKTUREN                             *
      *----------------------------------------------------*
      *
      *  declarations for Convert Edit Code: QECCVTEC
     D  EditMask       S            256A   INZ(*BLANKS)
     D  EditMaskLn     S                   INZ(*ZEROS)  LIKE(INT4_t)
     D  RcvVarLen      S                   INZ(*ZEROS)  LIKE(INT4_t)
     D  ZeroBalanc     S              1A   INZ(*BLANKS)
     D  EditCode       S              1A   INZ(*BLANKS)
     D  CurrInd        S              1A   INZ(*BLANKS)
     D  Precision      S                   INZ(*ZEROS)  LIKE(INT4_t)
     D  BinLength      S                   INZ(*ZEROS)  LIKE(INT4_t)
     D  Decimal        S                   INZ(*ZEROS)  LIKE(INT4_t)
      *
      *  additional
      *  declarations for Convert Edit Word: QECCVTEW
     D  EditWord       S            256A   INZ(*BLANKS)
     D  EditWordLn     S                   INZ(*ZEROS)  LIKE(INT4_t)
      *
      *  additional
      *  declarations for Edit: QECEDT
     D  CvtVar         S            256A   INZ(*BLANKS)
     D  CvtVarLen      S                   INZ(256)     LIKE(INT4_t)
     D  SrcVar         S                   INZ(*BLANKS) LIKE(i_srcVar)
     D  SrcVarCls      S             10A   INZ(*BLANKS)
     D  Float4         S              4F   BASED(pFloat)
     D  Float8         S              8F   BASED(pFloat)
     D  Float4Buf      S              4A   BASED(pFloat)
     D  Float8Buf      S              8A   BASED(pFloat)
     D  MaxFloat4      S             12P 4 INZ(*HIVAL)
     D  MaxFloat8      S             21P 4 INZ(*HIVAL)
     D  len            S             10I 0 INZ
      *
     D  TempStrLen     S             10I 0 inz
      *
     D  hTranscoder    S                   LIKE(hTranscoder_t ) INZ
      *
      *  helper fields to convert 3I0 and 20I0 fields
     D zonedBuffer     DS
     D  zoned3                        3S 0 inz   overlay(zonedBuffer)
     D  zoned5                        5S 0 inz   overlay(zonedBuffer)
     D  zoned10                      10S 0 inz   overlay(zonedBuffer)
     D  zoned20                      20S 0 inz   overlay(zonedBuffer)
      *
     D HEX_NULL        S                   like(rcdBuf_t) inz(*ALLx'00')
      *
     D SPCVAL_NAN_4    C                   x'7FC00000'
     D SPCVAL_NAN_8    C                   x'7FF8000000000000'
     D SPCVAL_INF_4    C                   x'7F800000'
     D SPCVAL_INF_8    C                   x'7FF0000000000000'
      *
     D SPCVAL_NAN      C                   '*NaN'
     D SPCVAL_INF      C                   '*Inf'
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK06
      /undefine internal_prototype
      *
      *  API error reporting
      /COPY QCOPYLE,API_ERROR
      *
      *  CPYNV API
      /COPY QCOPYLE,D_MI
      *
      *  Format FLDL0100
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      ********************************************************************
      *           Main  Control block                                    *
      ********************************************************************
      *
     D PEEK06          PI
     D  i_fldl0100                         const likeds(FLDL0100_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_srcVar                           const like(rcdBuf_t)
     D  i_qcmdexc                     1A   const
     D  i_cvtCcsid                    1A   const
     D  o_string                                 like(rcdBuf_t)
     D  o_strLen                                 like(int4_t)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *---------------------------------------------------*
      *
     C                   EVAL      o_string = ''
     C                   EVAL      o_strLen = 0
      *
     C                   MONITOR
      *
     C                   SELECT
     C                   WHEN      (i_rcdFmt = 'FLDL0100')
     C                   EXSR      W_FLDL0100
     C                   Endsl
      *
     C                   ON-ERROR
     C                   EVAL      o_string = ''
     C                   EVAL      o_strLen = 0
     C                   ENDMON
      *
     C                   RETURN
      *
      *====================================================*
      *  W_FLDL0100 -    Work with FLDL0100                *
      *====================================================*
      *
     C     W_FLDL0100    BEGSR
      *
     C                   EVAL      FLDL0100 = i_fldl0100
      *
      *  Erzwingen Edit Code, wenn die Aufbereitung für eine über
      *  QCMDEXC auszuführende Befehlszeile erfolgt.
     C                   IF        (i_qcmdexc = bTrue) and
     C                             (f_isNumFld(FLDL0100) = bTrue) and
     C                             (f_isFloatFld(FLDL0100) = bFalse)
     C                   EVAL      FLDL0100.F1EDTC = 'P'
     C                   EVAL      FLDL0100.F1EDWL = 0
     C                   EVAL      FLDL0100.F1EDWD = ''
     C                   ENDIF
      *
     C                   EVAL      EditCode = FLDL0100.F1EdtC
     C                   EVAL      EditWord = FLDL0100.F1EdWd
     C                   EVAL      CurrInd = ''
     C                   EVAL      EditWordLn = FLDL0100.F1EdWl
     C                   EVAL      SrcVarCls = FLDL0100.F1DTyp
      *
     C                   IF        (SrcVarCls = 'B')
      *
     C                   SELECT
     C                   WHEN      (f_buffLn(FLDL0100) = 1)
     C                   EVAL      Precision = 3
     C                   EVAL      BinLength = 1
     C                   WHEN      (f_buffLn(FLDL0100) = 2)
     C                   EVAL      Precision = 5
     C                   EVAL      BinLength = 2
     C                   WHEN      (f_buffLn(FLDL0100) = 4)
     C                   EVAL      Precision = 10
     C                   EVAL      BinLength = 4
     C                   OTHER
     C                   EVAL      Precision = 20
     C                   EVAL      BinLength = 8
     C                   ENDSL
      *
     C                   ELSE
      *
     C                   EVAL      Precision = FLDL0100.F1Digt
     C                   Endif
      *
     C                   EVAL      Decimal = FLDL0100.F1DecP
      *
     C                   SELECT
     C                   WHEN      (SrcVarCls = 'F')
     C                   Eval      len = f_rtvFld(srcVar: i_srcVar: FLDL0100)
     C                   Eval      pFLoat = %addr(srcVar)
      *         Float 4
     C                   If        (len = 4)
     C                   Select
     C                   When      (Float4Buf = SPCVAL_NAN_4)
     C                   Eval      o_string = SPCVAL_NAN
     C                   When      (Float4Buf = SPCVAL_INF_4)
     C                   Eval      o_string = SPCVAL_INF
     C                   Other
     C                   Eval      MaxFloat4 = *HIVAL
     C                   If        (%abs(Float4) <= MaxFloat4)
     C                   Eval      MaxFloat4 = Float4
     C                   Eval      o_string = %editc(MaxFloat4: 'P')
     C                   Else
     C                   Eval      o_string = %editflt(Float4)
     C                   Endif
     C                   Endsl
     C                   Eval      o_strLen = 14
     C                   Else
      *         Float 8
     C                   Select
     C                   When      (Float8Buf = SPCVAL_NAN_8)
     C                   Eval      o_string = SPCVAL_NAN
     C                   When      (Float8Buf = SPCVAL_INF_8)
     C                   Eval      o_string = SPCVAL_INF
     C                   Other
     C                   Eval      MaxFloat8 = *HIVAL
     C                   If        (%abs(Float8) <= MaxFloat8)
     C                   Eval      MaxFloat8 = Float8
     C                   Eval      o_string = %editc(MaxFloat8: 'P')
     C                   Else
     C                   Eval      o_string = %editflt(Float8)
     C                   Endif
     C                   Endsl
     C                   Eval      o_strLen = 23
     C                   Endif
      *
     C                   WHEN      (SrcVarCls = 'A' or SrcVarCls = 'G')
     C                   Eval      TempStrLen =
     C                                f_rtvFld(o_string: i_srcVar: FLDL0100)
      *  Do not convert if we prepare the *HEADLINE (see: PEEK05, yCvtCcsid)
     C                   If        f_hasCcsid(FLDL0100) = bTrue AND
     C                             i_cvtCcsid = bTrue
     C                   Eval      hTranscoder =
     C                               Transcoder_toJobCcsid(FLDL0100.F1FDCC)
     C                   Eval      o_strLen =
     C                                Transcoder_xlateBuffer(hTranscoder
     C                                                       : %addr(o_string)
     C                                                       : TempStrLen
     C                                                       : %size(o_string))
     C                   If        (TempStrLen > o_strLen)
     C                   Eval      %subst(o_string: o_strLen+1
     C                                    : TempStrLen - o_strLen) = ''
     C                   Endif
     C                   Else
     C                   If        (FLDL0100.F1NDBC > 0)
     C                   Eval      o_strLen = FLDL0100.F1NDBC
     C                   Else
     C                   Eval      o_strLen = TempStrLen
     C                   Endif
     C                   Endif
      *
     C                   WHEN      (SrcVarCls = 'B')
     C                   Callp     f_rtvFld(srcVar: i_srcVar: FLDL0100)
     C                   Callp       cpynv(f_NUM_Descr(T_Zoned: precision: 0)
     C                                     : %addr(zonedBuffer)
     C                                     : f_NUM_Descr(T_Signed: BinLength: 0)
     C                                     : %addr(srcVar))
     C                   EVAL      SrcVar = zonedBuffer
     C                   EVAL      SrcVarCls = 'S'
     C                   EXSR      Convert
     C                   WHEN      (SrcVarCls = 'P')
     C                   Callp     f_rtvFld(srcVar: i_srcVar: FLDL0100)
     C                   EXSR      Convert
     C                   WHEN      (SrcVarCls = 'S')
     C                   Callp     f_rtvFld(srcVar: i_srcVar: FLDL0100)
     C                   EXSR      Convert
     C                   OTHER
     C                   Eval      o_strLen =
     C                                f_rtvFld(o_string: i_srcVar: FLDL0100)
     C                   Endsl
      *
     C                   Endsr
      *
      *====================================================*
      *  Convert--  Convert to String                      *
      *====================================================*
      *
     C     Convert       BEGSR
      *
     C                   SELECT
     C                   WHEN      (SrcVarCls = 'B')
     C                   EVAL      SrcVarCls = '*BINARY'
     C                   WHEN      (SrcVarCls = 'P')
     C                   EVAL      SrcVarCls = '*PACKED'
     C                   WHEN      (SrcVarCls = 'S')
     C                   EVAL      SrcVarCls = '*ZONED'
     C                   Endsl
      *
     C                   IF        (EditWord <> '')
     C                   EXSR      CvtEdtWord
     C                   ELSE
     C                   EXSR      CvtEdtCode
     C                   Endif
      *
     C                   EVAL      CvtVarLen = RcvVarLen
      *
     C                   RESET                   §ErrorCode
      *
     C                   CALL      'QECEDT'
     C                   PARM                    CvtVar
     C                   PARM                    CvtVarLen
     C                   PARM                    SrcVar
     C                   PARM                    SrcVarCls
     C                   PARM                    Precision
     C                   PARM                    EditMask
     C                   PARM                    EditMaskLn
     C                   PARM                    ZeroBalanc
     C                   PARM                    §ErrorCode
      *
     C                   IF        §ERRAVAIL = 0
     C                   EVAL      o_string = %subst(CvtVar: 1: CvtVarLen)
     C                   ELSE
     C                   EVAL      o_string = %subst(HEX_NULL: 1: CvtVarLen)
     C                   ENDIF
      *
     C                   EVAL      o_strLen = CvtVarLen
      *
     C                   ENDSR
      *
      *====================================================*
      *  CvtEdtWord                                        *
      *====================================================*
      *
     C     CvtEdtWord    BEGSR
      *
     C                   CLEAR                   EditMask
     C                   CLEAR                   EditMaskLn
      *
     C                   CALL      'QECCVTEW'
     C                   PARM                    EditMask
     C                   PARM                    EditMaskLn
     C                   PARM                    RcvVarLen
     C                   PARM                    EditWord
     C                   PARM                    EditWordLn
     C                   PARM                    §ErrorCode
      *
     C                   ENDSR
      *
      *====================================================*
      *  CvtEdtCode                                        *
      *====================================================*
      *
     C     CvtEdtCode    BEGSR
      *
     C                   SELECT
      * A-D
     C                   WHEN      (EditCode >= 'A' and EditCode <= 'D')
      * J-Q
     C                   WHEN      (EditCode >= 'J' and EditCode <= 'Q')
      * Y-Z
     C                   WHEN      (EditCode >= 'Y' and EditCode <= 'Z')
      * 1-9
     C                   WHEN      (EditCode >= '1' and EditCode <= '9')
      * X
     C                   WHEN      (EditCode = 'X')
     C                   EVAL      EditCode = 'Z'
     C                   OTHER
     C                   EVAL      EditCode = 'L'
     C                   Endsl
      *
     C                   CLEAR                   EditMask
     C                   CLEAR                   EditMaskLn
      *
     C                   CALL      'QECCVTEC'
     C                   PARM                    EditMask
     C                   PARM                    EditMaskLn
     C                   PARM                    RcvVarLen
     C                   PARM                    ZeroBalanc
     C                   PARM                    EditCode
     C                   PARM                    CurrInd
     C                   PARM                    Precision
     C                   PARM                    Decimal
     C                   PARM                    §ErrorCode
      *
     C                   ENDSR
      *
