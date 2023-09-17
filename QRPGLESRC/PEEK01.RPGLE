      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK01                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 26.09.97  Raddatz                                 *
      *  geändert : 27.04.99  für Version 2.1.0                       *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Dokumentation:                                               *
      *                                                               *
      *  Erstellen einer Satzformatbeschreibung in der Datei PEEKFLD  *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEKFLD   UF A E             DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F_)
      *===============================================================*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---FLDL0100-----------------------------------------*
      *  list API format FLDL0100
      *  (data structure can be used within the calling program
      *  to splitt XLIST into its units. See PEEK02_DMO)
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Copystrecken für Nachrichtenaufbau---------------*
      /COPY QCOPYLE,USR0001
      /COPY QCOPYLE,USR8104
      *----------------------------------------------------*
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0001
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
     D seqNbr          S                   LIKE(F_Seq) INZ(0)
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D PEEK02          S                   like(r§pgmCallN) inz
      *
     D IsFld512        S              1A   INZ(bFalse)
      *
     D FldCnt          S              8S 0
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
     D xFmt            S                   like(r§fmt)
     D xRcdFmtID       S                   like(r§fmtId)
      *
      * Peek02
     D yQFile          S             20A   inz
     D yFmt            S             10A   inz
     D yFunk           S             10A   inz
     D yAnz            S                   like(r§int4    ) inz
     D yList           S            512A   inz
     D yRcdFmtID       S                   like(r§fmtId) inz
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XQFILE           20
     C                   PARM                    XFMT
     C                   PARM                    XRCDFMTID
      *
     C                   PARM                    XMsgID            7
     C                   PARM                    XMsgDta         512
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  create list of database relation
     C                   MOVEL(P)  XQFILE        YQFILE
     C                   MOVEL(P)  XFMT          YFMT
     C                   MOVEL(P)  '*CREATE'     YFUNK
     C                   Z-ADD     *ZEROS        YANZ
     C                   MOVEL(P)  *BLANKS       YLIST
     C                   CALL      PEEK02
     C                   PARM                    yQFile
     C                   PARM                    yFmt
     C                   PARM                    yFunk
     C                   PARM                    yAnz
     C                   PARM                    yList
     C                   PARM                    yRcdFmtID
      *
     C                   MOVEL(P)  yRcdFmtID     xRcdFmtID
      *
     C                   Z-ADD     YANZ          NOF              15 0
      *
     C                   Z-ADD     *ZEROS        seqNbr
     C                   Z-ADD     *ZEROS        FldCnt
     C                   MOVEL (P) bFalse        IsFld512
      *  read each entry
     C     1             DO        NOF
      *
     C                   MOVEL(P)  '*READ'       YFUNK
     C                   CALL      PEEK02
     C                   PARM                    YQFILE
     C                   PARM                    YFMT
     C                   PARM                    YFUNK
     C                   PARM                    YANZ
     C                   PARM                    YLIST
      *
     C                   CLEAR                   FPEEKFLD
      *
     C                   MOVEL (P) YLIST         FLDL0100
      *
     C                   EVAL      F_FORMAT = 'FLDL0100'
     C                   EVAL      F_FIELD = FLDL0100.F1FNME
     C                   EVAL      seqNbr = seqNbr + 1
     C                   EVAL      F_FldSeq = seqNbr
     C                   EVAL      F_Seq = seqNbr
     C                   EVAL      F_KSeq = 0
     C                   EVAL      F_Color = SET_ClmCol
     C                   EVAL      F_MarkCol = bFalse
     C                   EVAL      F_MaxSize = *HIVAL
     C                   EVAL      F_EDTCDE = FLDL0100.F1EDTC
      *
     C                   Eval      F_UnKnown = f_isNotAlw(FLDL0100)
     C                   If        F_UnKnown = bTrue
     C                   Eval      F_Hidden = bTrue
     C                   MOVEL (P) bFalse        F_IsTransc
     C                   Else
     C                   Eval      F_Hidden = bFalse
     C                   If        f_hasCcsid(FLDL0100) = bTrue
     C                   Callp     Transcoder_toJobCcsid(FLDL0100.F1FDCC)
     C                   Callp     Transcoder_toFieldCcsid(FLDL0100.F1FDCC)
     C                   MOVEL (P) bTrue         F_IsTransc
     C                   Else
     C                   MOVEL (P) bFalse        F_IsTransc
     C                   Endif
     C                   Endif
      *
     C                   EXSR      CvtEDTCDE
      *
      *  Interner PEEK/400-Feldname
     C                   ADD       1             FldCnt
     C                   IF        FldCnt = 0
     C                   LEAVE
     C                   Endif
      *
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   EVAL      FLDL0100.F1VFLD = 'V_' + %editc(FldCnt: 'X')
     C                   Else
     C                   EVAL      FLDL0100.F1VFLD = 'P_' + %editc(FldCnt: 'X')
     C                   Endif
      *
      *  Anzeigereihenfolge
     C                   EVAL      FLDL0100.F1SEQ = seqNbr
      *
      *  UCS-2 Feld
     C                   Eval      FLDL0100.F1UCS2 = (FLDL0100.F1DTYP = 'G')
      *
     C                   MOVEL (P) FLDL0100      F_FFD
      *
     C                   WRITE     FPEEKFLD
      *
     C                   Eval      isFld512 = f_isToLong(FLDL0100)
     C                   Enddo
      *
      *  delete list
      ***                MOVEL(P)  '*DELETE'     YFUNK
      ***                CALL      PEEK02
      ***                PARM                    YQFILE
      ***                PARM                    YFMT
      ***                PARM                    YFUNK
      ***                PARM                    YANZ
      ***                PARM                    YLIST
      *
      *---------------------------------------------------*
      *  Ende Programm
      *
     C     ENDE          TAG
      *
     C     NOF           IFEQ      *ZEROS
     C                   MOVEL (P) 'USR0001'     XMsgID
     C     10            SUBST (P) XQFile:1      USR00011
     C     10            SUBST (P) XQFile:11     USR00012
     C                   MOVEL (P) XFMT          USR00013
     C                   MOVEL (P) USR0001       XMsgDta
     C                   ELSE
     C     IsFld512      IFEQ      bTrue
     C                   MOVEL (P) 'USR8123'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   ELSE
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
     C                   Endif
     C                   Endif
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *============================================================*
      *    CvtEDTCDE     Konvertieren des EDTCDE's in einen        *
      *                  EDTCDE mit Vorzeichen                     *
      *============================================================*
      *
     C     CvtEDTCDE     BEGSR
      *
     C                   IF        f_isNumFld(FLDL0100) = bFalse
     C                   LEAVESR
     C                   ENDIF
      *
     C                   IF        f_isFloatFld(FLDL0100) = bTrue
     C                   LEAVESR
     C                   ENDIF
      *
     C                   SELECT
      *  Keine Umsetzung der EDTCDE's
     C                   WHEN      SET_DspSgn = '0'
      *
      *  Mappen Edit Code
     C                   WHEN      SET_DspSgn = '1'
     C                   SELECT
     C     F_EdtCde      WHENEQ    '1'
     C                   MOVEL (P) 'J'           F_EdtCde
     C     F_EdtCde      WHENEQ    '2'
     C                   MOVEL (P) 'K'           F_EdtCde
     C     F_EdtCde      WHENEQ    '3'
     C                   MOVEL (P) 'L'           F_EdtCde
     C     F_EdtCde      WHENEQ    '4'
     C                   MOVEL (P) 'M'           F_EdtCde
     C     F_EdtCde      WHENEQ    'Z'
     C                   MOVEL (P) 'L'           F_EdtCde
     C     F_EdtCde      WHENEQ    'X'
     C                   MOVEL (P) 'L'           F_EdtCde
     C                   OTHER
      *  Keine Umsetzung des EDTCDE's
     C                   ENDSL
      *
      *  Mappen Edit Code - Keine Nullenunterdrückung
     C                   WHEN      SET_DspSgn = '2'
     C                   SELECT
     C     F_EdtCde      WHENEQ    '1'
     C                   MOVEL (P) 'J'           F_EdtCde
     C     F_EdtCde      WHENEQ    '2'
     C                   MOVEL (P) 'J'           F_EdtCde
     C     F_EdtCde      WHENEQ    '3'
     C                   MOVEL (P) 'L'           F_EdtCde
     C     F_EdtCde      WHENEQ    '4'
     C                   MOVEL (P) 'L'           F_EdtCde
      *
     C     F_EdtCde      WHENEQ    'B'
     C                   MOVEL (P) 'A'           F_EdtCde
     C     F_EdtCde      WHENEQ    'D'
     C                   MOVEL (P) 'C'           F_EdtCde
      *
     C     F_EdtCde      WHENEQ    'K'
     C                   MOVEL (P) 'J'           F_EdtCde
     C     F_EdtCde      WHENEQ    'M'
     C                   MOVEL (P) 'L'           F_EdtCde
      *
     C     F_EdtCde      WHENEQ    'O'
     C                   MOVEL (P) 'N'           F_EdtCde
     C     F_EdtCde      WHENEQ    'Q'
     C                   MOVEL (P) 'P'           F_EdtCde
      *
     C     F_EdtCde      WHENEQ    'Z'
     C                   MOVEL (P) 'L'           F_EdtCde
     C     F_EdtCde      WHENEQ    'X'
     C                   MOVEL (P) 'L'           F_EdtCde
      *
     C     F_EdtCde      WHENEQ    ' '
     C                   MOVEL (P) SET_editCode  F_EdtCde
     C                   ENDSL
      *
     C                   ENDSL
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
     C                   Eval      SET0001 = f_getUsrSg('*DSPATTR' )
      *
     C                   ENDSR
      *
      *====================================================*
      *  First  --  Initialize program                     *
      *====================================================*
      *
     C     First         BEGSR
      *
      * - Meldung
     C                   Callp     p_sndStsMg('USR8104': XQFile)
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Los gehts'
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   MOVEL (P) *BLANKS       XRcdFmtID
      *
     C     1             SETLL     FPEEKFLD
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLD                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   DELETE    FPEEKFLD
     C                   Enddo
      *
     C                   Z-ADD     *ZEROS        NOF
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK02 = f_pgmCallN('PEEK02')
      *
     C                   OPEN      PEEKFLD
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
     C                   RETURN
      *
     C                   ENDSR     '*CANCL'
      *
      *---Versenden von Nachrichten------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
