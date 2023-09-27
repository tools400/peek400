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
     FPEEKFLD   UF A E             DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     PREFIX(F_)
      *===============================================================*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK01
      /undefine internal_prototype
      *
      /COPY QCOPYLE,PPEEK02
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
     D NOF             S                   like(r§int4    ) inz
     D rc              S                   like(r§int4    ) inz
      *
     D PEEK02_NAME     S                   like(r§pgmCallN) inz
      *
     D IsFld512        S              1A   INZ(bFalse)
      *
     D FldCnt          S              8S 0
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK71
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK01          PI
     D  i_qFile                            const likeds(r§qObj)
     D  i_rcdFmt                           const like(r§fmt)
     D  o_rcdFmtID                               like(r§fmtId)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *---------------------------------------------------*
     C                   EXSR      First
      *---------------------------------------------------*
      *
      *  create list of database relation
     C                   CALLP     PEEK02(i_qFile: i_rcdFmt: '*CREATE': NOF
     C                                    : FLDL0100: o_rcdFmtID)
      *
     C                   EVAL      seqNbr = *ZEROS
     C                   EVAL      FldCnt = *ZEROS
     C                   EVAL      IsFld512 = bFalse
      *  read each entry
     C     1             DO        NOF
      *
     C                   CALLP     PEEK02(i_qFile: i_rcdFmt: '*READ': rc
     C                                    : FLDL0100: o_rcdFmtID)
      *
     C                   CLEAR                   FPEEKFLD
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
     C                   EVAL      F_IsTransc = bFalse
     C                   Else
     C                   Eval      F_Hidden = bFalse
     C                   If        f_hasCcsid(FLDL0100) = bTrue
     C                   Callp     Transcoder_toJobCcsid(FLDL0100.F1FDCC)
     C                   Callp     Transcoder_toFieldCcsid(FLDL0100.F1FDCC)
     C                   EVAL      F_IsTransc = bTrue
     C                   Else
     C                   EVAL      F_IsTransc = bFalse
     C                   Endif
     C                   Endif
      *
     C                   EXSR      CvtEDTCDE
      *
      *  Interner PEEK/400-Feldname
     C                   EVAL      FldCnt = FldCnt + 1
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
     C                   EVAL      F_FFD = FLDL0100
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
     C                   EVAL      o_msgID = 'USR0001'
     C                   EVAL      USR00011 = i_qFile.NAME
     C                   EVAL      USR00012 = i_qFile.LIB
     C                   EVAL      USR00013 = i_rcdFmt
     C                   EVAL      o_msgDta = USR0001
     C                   ELSE
     C     IsFld512      IFEQ      bTrue
     C                   EVAL      o_msgID = 'USR8123'
     C                   EVAL      o_msgDta = *BLANKS
     C                   ELSE
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
     C                   Endif
     C                   Endif
      *
     C                   EVAL      *INLR = '1'
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
     C                   EVAL      F_EdtCde = 'J'
     C     F_EdtCde      WHENEQ    '2'
     C                   EVAL      F_EdtCde = 'K'
     C     F_EdtCde      WHENEQ    '3'
     C                   EVAL      F_EdtCde = 'L'
     C     F_EdtCde      WHENEQ    '4'
     C                   EVAL      F_EdtCde = 'M'
     C     F_EdtCde      WHENEQ    'Z'
     C                   EVAL      F_EdtCde = 'L'
     C     F_EdtCde      WHENEQ    'X'
     C                   EVAL      F_EdtCde = 'L'
     C                   OTHER
      *  Keine Umsetzung des EDTCDE's
     C                   ENDSL
      *
      *  Mappen Edit Code - Keine Nullenunterdrückung
     C                   WHEN      SET_DspSgn = '2'
     C                   SELECT
     C     F_EdtCde      WHENEQ    '1'
     C                   EVAL      F_EdtCde = 'J'
     C     F_EdtCde      WHENEQ    '2'
     C                   EVAL      F_EdtCde = 'J'
     C     F_EdtCde      WHENEQ    '3'
     C                   EVAL      F_EdtCde = 'L'
     C     F_EdtCde      WHENEQ    '4'
     C                   EVAL      F_EdtCde = 'L'
      *
     C     F_EdtCde      WHENEQ    'B'
     C                   EVAL      F_EdtCde = 'A'
     C     F_EdtCde      WHENEQ    'D'
     C                   EVAL      F_EdtCde = 'C'
      *
     C     F_EdtCde      WHENEQ    'K'
     C                   EVAL      F_EdtCde = 'J'
     C     F_EdtCde      WHENEQ    'M'
     C                   EVAL      F_EdtCde = 'L'
      *
     C     F_EdtCde      WHENEQ    'O'
     C                   EVAL      F_EdtCde = 'N'
     C     F_EdtCde      WHENEQ    'Q'
     C                   EVAL      F_EdtCde = 'P'
      *
     C     F_EdtCde      WHENEQ    'Z'
     C                   EVAL      F_EdtCde = 'L'
     C     F_EdtCde      WHENEQ    'X'
     C                   EVAL      F_EdtCde = 'L'
      *
     C     F_EdtCde      WHENEQ    ' '
     C                   EVAL      F_EdtCde = SET_editCode
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
     C                   Callp     p_sndStsMg('USR8104': i_qFile)
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Los gehts'
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   EVAL      o_rcdFmtID = *BLANKS
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
     C                   EVAL      NOF = *ZEROS
      *
     C                   ENDSR
      *
      *====================================================*
      *  *INZSR --  Initialize program                     *
      *====================================================*
      *
     C     *INZSR        BEGSR
      *
     C                   Eval      PEEK02_NAME = f_pgmCallN('PEEK02')
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
