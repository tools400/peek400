      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK20                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 27.10.97    Raddatz                               *
      *  geändert : 27.04.99    2.1.0                                 *
      *  geändert : 01.04.2004  2.2.2   Fixed problem that ybuffer    *
      *                                 was not cleared correclty     *
      *                                 for data/time/timestamp       *
      *                                 fields.                       *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Erstellen internen Aufsetzschlüssel                          *
      *                                                               *
      *===============================================================*
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
     FPEEKFLDL2 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL2)
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F2)
     F                                     INFDS(Peek_L2_DS)
      *
     FPEEKFLDL0 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL0)
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F2)
     F                                     INFDS(Peek_L0_DS)
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
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek_L0_DS       DS
     D P0File                 83     92A
     D P0Library              93    102A
     D P0Member              129    138A
     D P0RcdNbr              397    400I 0
      *
     DPeek_L2_DS       DS
     D P2File                 83     92A
     D P2Library              93    102A
     D P2Member              129    138A
     D P2RcdNbr              397    400I 0
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XKeyVal         S                   like(r§keyBuf  )
     D XIO_Buffer      S                   like(r§rcdBuf  )
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D yIO_Buff        DS
     D yIO_BuffTb                     1A   DIM(§rcdBufLen) inz
      *
     D YData           S            512A   INZ(*BLANKS)
     D YFormat         S             10A   INZ(*BLANKS)
     D YBuffer         S                   like(r§rcdBuf  ) inz
     D YTgtFormat      S             10A   INZ(*BLANKS)
     D YTgtValue       S             10A   INZ(*BLANKS)
     D YOutBuffer      S                   like(r§rcdBuf  ) inz
     D YOutBuffLn      S                   like(r§int4    ) inz
     D YMsgID          S              7A   INZ(*BLANKS)
     D YMsgDta         S            512A   INZ(*BLANKS)
      *
      *** IsNumeric       S              1A   INZ(bFalse)
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
     D inpKeyLen       S             10I 0                  inz(-1)
      *
     D BP              S                   like(r§int4    ) inz
     D KP              S                   like(r§int4    ) inz
     D LEN2            DS                  qualified
     D  INTEGER                1      2I 0 inz
     D  ALPHA                  1      2A
      *
     D PEEK18          S                   like(r§pgmCallN) inz
      *
     D Wrk_KeyVal      S                   LIKE(XKeyVal) INZ(*BLANKS)
      *
     D DftVal          S             30A   INZ(*BLANKS)
     D DftValLen       S                   like(r§int4    ) inz
     D Idx             S                   like(r§int4    ) inz
      *
     D §Time_A         C                   CONST('00.00.00')
     D §Date_A         C                   CONST('0001-01-01')
     D §Tstmp_A        C                   CONST('0001-01-01-00.00.00.000000')
      *
     D §Time_D         C                   CONST('23.59.59')
     D §Date_D         C                   CONST('9999-12-31')
     D §Tstmp_D        C                   CONST('9999-12-31-23.59.59.999999')
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XKeyVal
     C                   PARM                    XIO_Buffer
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK18
     C     P_Peek18      PLIST
     C                   PARM                    YData
     C                   PARM                    YFormat
     C                   PARM                    YBuffer
     C                   PARM                    YTgtFormat
     C                   PARM                    YTgtValue
     C                   PARM                    YOutBuffer
     C                   PARM                    YOutBuffLn
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL2
     C     F2KEY_L2      KLIST
     C                   KFLD                    F2KSEQ
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL0
     C     F1KEY_L0      KLIST
     C                   KFLD                    F2FLDSEQ
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
     C                   EVAL      XIO_Buffer = ''
      *
     C                   Eval      yIO_BuffTb(*) = ''
     C                   EVAL      BP = 1
     C                   EVAL      KP = 1
      *
     C                   SELECT
     C     XKeyVal       WHENEQ    '*PHIVAL'
     C                   EVAL      Wrk_KeyVal = '*HIVAL'
     C                   EXSR      BuildPseud
      *
     C     XKeyVal       WHENEQ    '*PLOVAL'
     C                   EVAL      Wrk_KeyVal = '*LOVAL'
     C                   EXSR      BuildPseud
      *
     C     XKeyVal       WHENEQ    '*HIVAL'
     C                   EVAL      Wrk_KeyVal = '*HIVAL'
     C                   EXSR      BuildKey
      *
     C     XKeyVal       WHENEQ    '*LOVAL'
     C                   EVAL      Wrk_KeyVal = '*LOVAL'
     C                   EXSR      BuildKey
      *
     C                   OTHER
     C                   EVAL      inpKeyLen = %len(%trimR(XKeyVal))
     C                   EVAL      Wrk_KeyVal = XKeyVal
     C                   EXSR      BuildKey
      *
     C                   ENDSL
      *
     C                   EVAL      XIO_Buffer = yIO_Buff
      *
     C     ENDE          TAG
      *
     C                   RETURN
      *
      *============================================================*
      *    BuildKey      Erstellen internen Aufsetzschlüssel       *
      *============================================================*
      *
     C     BuildKey      BEGSR
      *
     C                   EVAL      F2KSeq = 1
     C     F2KEY_L2      SETLL     FPEEKFLDL2
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL2                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      Intern
     C     BP            IFGT      §rcdBufLen
     C                   LEAVE
     C                   ENDIF
      *
     C                   IF        (inpKeyLen > 0 and KP > inpKeyLen)
     C                   EVAL      Wrk_KeyVal = '*LOVAL'
     C                   EVAL      inpKeyLen = -1
     C                   ENDIF
      *
     C                   ENDDO
      *
     C                   ENDSR
      *
      *============================================================*
      *    BuildPseud    Erstellen internes Satzformat             *
      *============================================================*
      *
     C     BuildPseud    BEGSR
      *
     C                   EVAL      F2FldSeq = *ZEROS
     C     F1KEY_L0      SETLL     FPEEKFLDL0
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL0                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      Intern
     C     BP            IFGT      §rcdBufLen
     C                   LEAVE
     C                   Endif
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    Intern        Formataufbereitung                        *
      *============================================================*
      *
     C     Intern        BEGSR
      *
     C                   EVAL      FLDL0100 = F2FFD
      *
     C                   EVAL      YData = F2FFD
     C                   EVAL      YFormat = F2Format
      *
     C     Wrk_KeyVal    IFEQ      '*LOVAL'
     C     Wrk_KeyVal    OREQ      '*HIVAL'
     C                   EVAL      YTgtValue = Wrk_KeyVal
     C                   CLEAR                   YBuffer
     C                   ELSE
     C                   EVAL      YTgtValue = '*CURRENT'
      *
     C                   select
     C                   when      FLDL0100.F1DTyp = 'S' or                     Zoned
     C                             FLDL0100.F1DTyp = 'B' or                     Binary
     C                             FLDL0100.F1DTyp = 'P'                        Packed
     C                   eval      Y = FLDL0100.F1Digt
     C                   when      FLDL0100.F1DTyp = 'F'                        Float
     C                   if        FLDL0100.F1FLen = 4
     C                   eval      Y = 14
     C                   else
     C                   eval      Y = 23
     C                   endif
     C                   other
     C                   if        (FLDL0100.F1DTyp = 'G')
     C                   eval      Y = FLDL0100.F1NDBC
     C                   else
     C                   eval      Y = FLDL0100.F1FLen
     C                   endif
     C                   endsl
      *
      *  ... Länge +1 wegen nachgestelltem Vorzeichen
      *      grundsätzlich, ob mit oder ohne Vorzeichen
      *      Vorzeichen wird in PEEK18 ausgewertet
     C                   If        (f_isNumFld(FLDL0100) = bTrue)
     C                   EVAL      Y = Y + 1
     C                   Endif
      *
     C                   EVAL      X = KP + Y
     C                   EVAL      X = X - 1
     C                   IF        f_isVarLen(FLDL0100) = bTrue
     C                   EVAL      X = X + 2
     C                   EVAL      Y = Y - 2
     C                   ENDIF
      *
     C     X             IFLE      §keyBufLen
     C     Y             SUBST (P) Wrk_KeyVal:KP YBuffer
     C                   ELSE
     C                   SUBST (P) Wrk_KeyVal:KP YBuffer
     C                   Endif
      *
 B02R ***                IF        f_isVarLen(FLDL0100)  = bTrue
    R ***                EVAL      LEN2.INTEGER = Y
    R ***                EVAL      YBuffer = LEN2.ALPHA + YBuffer
 E02R ***                ENDIF
      *
     C                   Endif
      *
      *  ... Aufbereiten Datums-, Zeit- und
      *      Zeitstempelfelder
     C                   Select
      *      ... Time
     C                   When      FLDL0100.F1DTyp = 'T'
     C                   If        F2Desc = 'D'
     C                   Eval      DftVal = §Time_D
     C                   Eval      DftValLen = f_len(§Time_D)
     C                   Else
     C                   Eval      DftVal = §Time_A
     C                   Eval      DftValLen = f_len(§Time_A)
     C                   Endif
     C                   Exsr      ChkValue
      *      ... Date
     C                   When      FLDL0100.F1DTyp = 'L'
     C                   If        F2Desc = 'D'
     C                   Eval      DftVal = §Date_D
     C                   Eval      DftValLen = f_len(§Date_D)
     C                   Else
     C                   Eval      DftVal = §Date_A
     C                   Eval      DftValLen = f_len(§Date_A)
     C                   Endif
     C                   Exsr      ChkValue
      *      ... Timestamp
     C                   When      FLDL0100.F1DTyp = 'Z'
     C                   If        F2Desc = 'D'
     C                   Eval      DftVal = §Tstmp_D
     C                   Eval      DftValLen = f_len(§Tstmp_D)
     C                   Else
     C                   Eval      DftVal = §Tstmp_A
     C                   Eval      DftValLen = f_len(§Tstmp_A)
     C                   Endif
     C                   Exsr      ChkValue
      *      ... alle anderen Datentypen
     C                   Other
      *          werden nicht vorgeprüft
      *          und vervollständigt
     C                   Endsl
      *
     C                   EVAL      YTgtFormat = '*INTERN'
     C                   CALL      PEEK18        P_Peek18
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      XMsgID = YMsgID
     C                   EVAL      XMsgDta = YMsgDta
     C                   GOTO      ENDE
     C                   Endif
      *
     C                   IF        f_isVarLen(FLDL0100) = bTrue
     C                   EVAL      YOutBuffLn = YOutBuffLn + 2
     C                   ENDIF
      *
     C     1             DO        YOutBuffLn    Y
     C     1             SUBST (P) YOutBuffer:Y  yIO_BuffTb(BP)
     C                   EVAL      BP = BP + 1
     C     BP            IFGT      §rcdBufLen
     C                   LEAVE
     C                   Endif
     C                   Enddo
      *
     C     BP            IFGT      §rcdBufLen
      *             Puffer zu Ende
     C                   ELSE
      *  Neue Startposition in Wrk_KeyVal
     C                   If        (f_isNumFld(FLDL0100) = bTrue) and
     C                             (f_isFloatFld(FLDL0100) = bFalse)
      *  ... bei numerischen Werten
     C                   eval      KP = KP + FLDL0100.F1Digt
      *      ... wegen nachgestelltem Vorzeichen
     C     SET_SignX     IFNE      bFalse                                       = bTrue
     C                   eval      KP = KP + 1
     C                   ELSE
      *          keine Korrektur erforderlich
     C                   Endif
     C                   ELSE
      *  ... bei alpha-numerischen Werten
     C                   IF        (FLDL0100.F1DTyp = 'G')
     C                   eval      KP = KP + FLDL0100.F1NDBC
     C                   ELSE
     C                   eval      KP = KP + FLDL0100.F1FLen
     C                   ENDIF
     C                   Endif
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   EVAL      KP = KP - 2
     C                   Endif
     C                   Endif
      *
      *  Delimeter ...
     C     SET_Dlmtr     IFNE      *BLANKS
     C                   EVAL      KP = KP + 1
     C                   ELSE
      *          keine Korrektur erforderlich
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ChkValue      Prüfen und vervollständigen Datums-,      *
      *                  Zeit- und Zeitstempelfelder               *
      *============================================================*
      *
     C     ChkValue      BEGSR
      *
     C     1             Do        DftValLen     Idx
      *
     C                   If        %subst(yBuffer: Idx: 1) = ' '
     C                   Eval      %subst(yBuffer: Idx: 1) =
     C                                %subst(DftVal: Idx: 1)
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
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
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK18 = f_pgmCallN('PEEK18')
      *
     C                   OPEN      PEEKFLDL0
     C                   OPEN      PEEKFLDL2
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
