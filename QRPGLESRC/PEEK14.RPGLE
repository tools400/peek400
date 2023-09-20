      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.2.0                               *
      *  Programm : PEEK14                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 08.10.97  Raddatz                                 *
      *  geändert : 21.07.99  Raddatz für Version 2.2                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Anzeigen Datensatz                                           *
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
     FPEEK14FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
     F                                     INFSR(*PSSR)
      * Feldliste
     FPEEKFLDL0 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL0)
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek#00)
     F                                     PREFIX(F_)
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek#  )
     F                                     PREFIX(F_)
      * Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
     D hFile04         DS                   likeds(r§hFile  )
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *
      *  Cursorposition                                    *
     D                 DS
     D  WScnCsrRow             1      4I 0
     D  WScnCsrCol             5      8I 0
      *----------------------------------------------------*
      *
     D IO_Buff         DS
     D  IO_BuffFld                         like(r§rcdBuf)
      *
     D IO_NullMap      S                   like(r§nullMap)
     D                                     dim(§nullMapSize)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100                                               Verarbeitung abgebr
      /COPY QCOPYLE,USR8206
      /COPY QCOPYLE,USR8220
      /COPY QCOPYLE,USR8221
      /COPY QCOPYLE,USR8222
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D FLDL0100        DS                  likeds(FLDL0100_t) inz
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek#00          DS
     D P0File                 83     92A
     D P0Library              93    102A
     D P0Member              129    138A
     D P0NbrOfRcd            156    159I 0
     D P0RcdNbr              397    400I 0
      *
     DPeek#            DS
     D P_File                 83     92A
     D P_Library              93    102A
     D P_Member              129    138A
     D P_NbrOfRcd            156    159I 0
     D P_RcdNbr              397    400I 0
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XHeaderTyp      S             10A
     D XCopyRight      S            512A
     D XRcdNbr         S                   LIKE(R§RcdNbr)
     D XFile           S             10A
     D XLibrary        S             10A
     D XMember         S             10A
     D XRcdFormat      S             10A
     D XFunction       S             10A
     D XCommitLVL      S              1A
     D XScreenNbr      S                   like(r§int4    )
     D XMsgID          S                   like(r§msgID   )
     D XMsgDta         S                   like(r§msgDta  )
      *
     D YData           S            512A   INZ(*BLANKS)
     D YFormat         S             10A
     D YSrcVar         S                   LIKE(r§rcdBuf)
     D                                     INZ(*BLANKS)
     D YPgmCall        S              1A   INZ(bFalse )
     D YCvtCcsid       S              1A   INZ(bTrue  )
     D YString         S                   LIKE(r§rcdBuf)
     D                                     INZ(*BLANKS)
     D YStrLen         S                   like(r§int4    ) inz
     D YCcsid          S                   like(r§int4    ) inz
     D YMsgID          S              7A   INZ(*BLANKS)
     D YMsgDta         S            512A   INZ(*BLANKS)
      *
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
      *
     D YScnAID         S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
      *Peek45/Peek64
     D YDsp80          S              1A   INZ(*BLANKS)
     D YHeaderTyp      S             10A   INZ(*BLANKS)
     D YCopyRight      S            512A   INZ(*BLANKS)
     D yFldName        S                   like(r§fieldNme) inz
     D YFldInhalt      S                   LIKE(r§rcdBuf)
     D                                     INZ(*BLANKS)
     D yLength         S                   like(r§int4    ) inz
     D yProtect        S                   like(r§bool    ) inz(bTrue)
     D yIsUcs2         S                   like(r§int4    ) inz
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *Peek65
     D YRcdNbr         S                   like(R§RcdNbr)
     D YFile           S                   like(R§FILE  )
     D YLibrary        S                   like(R§LIB   )
     D YMember         S                   like(R§MBR   )
     D YRcdFormat      S             10A
      *YMsgID          S                   like(r§msgID   )
      *YMsgDta         S                   like(r§msgDta  )
      *
     D SflPage         S                   like(r§int4    ) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflLastRcd      S                   like(SflPage   ) inz
     D §NbrFKeys       C                   CONST(3)
      *
     D SfBot           S                   like(r§int4    ) inz
      *
     D IsRecord        S                   like(r§bool    ) inz(bFalse)
     D IsCvtChar       S                   like(r§bool    ) inz(bFalse)
      *
     D BuffStart       S                   like(r§int4    ) inz
     D BuffEnd         S                   like(r§int4    ) inz
     D BuffPos         S                   like(r§int4    ) inz
      *
     D PEEK06          S                   like(r§pgmCallN) inz
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK32          S                   like(r§pgmCallN) inz
     D PEEK45          S                   like(r§pgmCallN) inz
     D PEEK64          S                   like(r§pgmCallN) inz
     D PEEK65          S                   like(r§pgmCallN) inz
      *
     D DotLine         S             40A   INZ(*ALL'.')
      *
     D X               S                   like(r§int4    ) inz
      *
     D TOTLIN          S                   like(r§int4    )
     D                                     inz
     D rowCnt          S                   like(r§int4    )
     D                                     inz
      *
     D Editor          S             10A   inz
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XDsp80
     C                   PARM                    XHeaderTyp
     C                   PARM                    XCopyRight
     C                   PARM                    XRcdNbr
     C                   PARM                    XFile
     C                   PARM                    XLibrary
     C                   PARM                    XMember
     C                   PARM                    XRcdFormat
     C                   PARM                    XFunction
     C                   PARM                    XCommitLVL
     C                   PARM                    XScreenNbr
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK06
     C     P_Peek06      PLIST
     C                   PARM                    YData
     C                   PARM                    YFormat
     C                   PARM                    YSrcVar
     C                   PARM                    YPgmCall
     C                   PARM                    YCvtCcsid
     C                   PARM                    YString
     C                   PARM                    YStrLen
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK23
     C     P_Peek23      PLIST
     C                   PARM                    yPgm
     C                   PARM                    yKey
     C                   PARM                    yPosF24
     C                   PARM                    yFKeys
     C                   PARM                    yNbrOfKeys
     C                   PARM                    yMsgID
     C                   PARM                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK21
     C     P_Peek21      PLIST
     C                   PARM                    YScnAID
     C                   PARM                    YPgm
     C                   PARM                    YPgmCmd
     C                   PARM                    YCmdDta
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK32
     C     P_Peek32      PLIST
     C                   PARM                    yString
     C                   PARM                    yStrLen
     C                   PARM                    yCcsid
     C                   PARM                    yMsgID
     C                   PARM                    yMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK45
     C     P_Peek45      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YHeaderTyp
     C                   PARM                    YCopyRight
     C                   PARM                    YFldName
     C                   PARM                    YFldInhalt
     C                   PARM                    YLength
     C                   PARM                    yProtect
     C                   PARM                    yIsUcs2
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK65
     C     P_Peek65      PLIST
     C                   PARM                    YRcdNbr
     C                   PARM                    YFile
     C                   PARM                    YLibrary
     C                   PARM                    YMember
     C                   PARM                    YRcdFormat
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL0
     C     F1KEY_L0      KLIST
     C                   KFLD                    F_FLDSEQ
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLD
     C     F1KEY         KLIST
     C                   KFLD                    F_FIELD
      *
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Prüfen Positionierung der Subfile
     C                   IF        (SFSANR <= 0)  or
     C                             (SFSANR > SflLastRcd)
     C                   EVAL      SFSANR = 1
     C                   Endif
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Modus: DROP/FOLD
     C                   EVAL      *IN86 = SFLMDE
      *
      *  Nachrichten anzeigen
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
      *  "Keine Sätze ..."
     C     *IN80         IFEQ      '0'
     C                   WRITE     PBLEER
     C                   Endif
      *
      *  Anzeigen der Befehlstasten
     C                   SELECT
     C                   When      (SFBOT = 2) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#2                                      BT-Tasten 2
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#3                                      BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#4                                      BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#5                                      BT-Tasten 4
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > §NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#6                                      BT-Tasten 4
     C                   OTHER
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   EVAL      SFBOT = 1
     C                   Endsl
      *
      *  Anzeige der Subfile
     C                   EXFMT     PBCTL
      *
      * - Berechnen Zeile/Spalte
     C     §ScnCsrPos    DIV       256           WScnCsrRow
     C                   MVR                     WScnCsrCol
      *
      * - Löschen der Cursorposition
     C                   EVAL      CsrRow = *ZEROS
     C                   EVAL      CsrCol = *ZEROS
      *
      *  Seitennummer  berechnen
     C     SFLCSR        DIV       SflPageDDS    XScreenNbr
     C                   IF        SFLCSR = (SflPageDDS * XScreenNbr)
      *       keine Korrektur erforderlich
     C                   ELSE
     C                   EVAL      XScreenNbr = XScreenNbr + 1
     C                   Endif
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Aktuelle Satz-Nr.
     C                   EVAL      SFSANR = SFLCSR
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   EVAL      YScnAID = §ScnAID
     C                   EVAL      YPgm = §§PgmName
     C                   CALL      PEEK21        P_Peek21
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ITER
     C                   Endif
      *
      *  Abfragen der Befehlstasten
     C                   SELECT
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'                                      ENDE
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'                                   AKTUALISIEREN
     C                   EXSR      ReadRcd
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F7  - Überschrift
     C     YPgmCmd       WHENEQ    '*HEADLINE'                                  Überschrift
     C                   EXSR      C_ChgHead
     C                   ITER
      *
      *  F9  - Hexeditor
     C     YPgmCmd       WHENEQ    '*HEXEDIT'                                   Hex-Editor
     C                   EXSR      C_FldHexEd
     C                   EXSR      KeepCsrPos
     C                   ITER
      *
      *  F10 - Feldeditor
     C     YPgmCmd       WHENEQ    '*STREDIT'                                   String-Editor
     C                   EXSR      C_FldStrEd
     C                   EXSR      KeepCsrPos
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'                                    ZURÜCK
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *   F17 - Anfang Datensatz
     C     YPgmCmd       WHENEQ    '*TOP'
     C                   EXSR      C_Top
     C                   ITER
      *   F18 - Ende Datensatz
     C     YPgmCmd       WHENEQ    '*BOT'
     C                   EXSR      C_Bot
     C                   ITER
      *
      *   F21 - Drucken Datensatz
     C     YPgmCmd       WHENEQ    '*PRINT'
     C                   EXSR      C_Print
     C                   ITER
      *
      *  F22 - Alle Datensätze verarbeiten
     C     YPgmCmd       WHENEQ    '*YESTOALL'                                  ZURÜCK
     C                   EXSR      C_AllRcds
     C                   LEAVE
      *
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
     C                   LEAVE
      *  Page up
     C     YPgmCmd       WHENEQ    '*PAGEUP'
      *  Page down
     C     YPgmCmd       WHENEQ    '*PAGEDOWN'
      *
     C                   OTHER
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(§scnAID: §§pgmName)
     C                   Iter
     C                   Endsl
      *
     C                   Enddo                                                  *HIVAL
      *
      *  Ende der Hauptschleife
      *---------------------------------------------------*
      *
      *  Programm verlassen
     C     ENDE          TAG
      *
     C                   CLOSE     PEEK14FM
     C                   CLOSE     PEEKFLD
     C                   CLOSE     PEEKFLDL0
     C                   CALLP     CIO_close(hFile04)
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EVAL      XMsgID = 'USR8112'
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_FldHexEd    F9 - Hexeditor                            *
      *============================================================*
      *
     C     C_FldHexEd    BEGSR
      *
      *  Error: No valid subfile record.
     C     SFLCSR        IFEQ      *ZEROS
     C                   EVAL      §MsgID = 'USR8204'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C     SFLCSR        CHAIN     PBSFL                              01
     C     *IN01         IFEQ      '1'
      *  Error: Unable to find record.
     C                   EVAL      §MsgID = 'USR8120'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      F_Field = R$FNME
     C     F1KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Error: Unable to find record.
     C                   EVAL      §MsgID = 'USR8120'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  Error: Editor not allowed. Field &1 is NULL.
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   CLEAR                   USR8220
     C                   Eval      §MsgID   = 'USR8220'
     C                   Eval      USR82201 = FLDL0100.F1FNME
     C                   Eval      §MsgDta  = USR8220
     C                   CALLP     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      YDsp80 = XDsp80
     C                   EVAL      YHeaderTyp = XHeaderTyp
     C                   EVAL      YCopyRight = XCopyRight
     C                   EVAL      YFldName = R$FNME
     C                   EVAL      yProtect = bTrue
     C                   EVAL      YMsgID = *BLANKS
     C                   EVAL      YMsgDta = *BLANKS
      *
     C                   EVAL      Editor = '*HEX'
     C                   EXSR      FromBuffer
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_FldStrEd    F10 - String-Editor                       *
      *============================================================*
      *
     C     C_FldStrEd    BEGSR
      *
      *  Error: No valid subfile record.
     C     SFLCSR        IFEQ      *ZEROS
     C                   EVAL      §MsgID = 'USR8204'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C     SFLCSR        CHAIN     PBSFL                              01
     C     *IN01         IFEQ      '1'
      *  Error: Unable to find record.
     C                   EVAL      §MsgID = 'USR8120'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      F_Field = R$FNME
     C     F1KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Error: Unable to find record.
     C                   EVAL      §MsgID = 'USR8120'
     C                   EVAL      §MsgDta = *BLANKS
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  Error: Editor does not support data type of field &1.
     C                   IF        FLDL0100.F1DTYP <> 'A' and
     C                             FLDL0100.F1DTYP <> 'G'
     C                   CLEAR                   USR8221
     C                   Eval      §MsgID   = 'USR8221'
     C                   Eval      USR82211 = FLDL0100.F1FNME
     C                   Eval      §MsgDta  = USR8221
     C                   CALLP     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
      *  Error: Field &1 exceeds maximum length allowed for editor.
     C**                 IF        f_buffLn(FLDL0100) > 1024
     C**                 CLEAR                   USR8222
     C**                 Eval      §MsgID   = 'USR8222'
     C**                 Eval      USR82221 = FLDL0100.F1FNME
     C**                 Eval      §MsgDta  = USR8222
     C**                 CALLP     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C**                 LEAVESR
     C**                 ENDIF
      *
      *  Error: Editor not allowed. Field &1 is NULL.
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   CLEAR                   USR8220
     C                   Eval      §MsgID   = 'USR8220'
     C                   Eval      USR82201 = FLDL0100.F1FNME
     C                   Eval      §MsgDta  = USR8220
     C                   CALLP     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      YDsp80 = XDsp80
     C                   EVAL      YHeaderTyp = XHeaderTyp
     C                   EVAL      YCopyRight = XCopyRight
     C                   EVAL      YFldName = R$FNME
     C                   EVAL      yProtect = bTrue
     C                   EVAL      YMsgID = *BLANKS
     C                   EVAL      YMsgDta = *BLANKS
      *
     C                   EVAL      Editor = '*STRING'
     C                   EXSR      FromBuffer
      *
     C                   ENDSR
      *
      *====================================================*
      *  FromBuffer - Übertragen Rohdaten aus IO-Puffer    *
      *====================================================*
      *
     C     FromBuffer    BEGSR
      *
     C                   IF        f_buffLn(FLDL0100) > §rcdBufLen
     C                   CLEAR                   USR8206
     C                   Eval      §MsgID   = 'USR8206'
     C                   Eval      USR82061 = §rcdBufLen
     C                   Eval      §MsgDta  = USR8206
     C                   ELSE
     C                   Callp     f_rtvFld(yFldInhalt: IO_Buff:
     C                                      FLDL0100: bFalse)
      *
     C                   Eval      yLength = f_curFldLn(IO_Buff: FLDL0100)
      *
     C                   If        (FLDL0100.F1UCS2 = '1')
     C                   Eval      yIsUcs2 = FLDL0100.F1FDCC
     C                   Else
     C                   Eval      yIsUcs2 = 0
     C                   Endif
      *
     C                   If        Editor = '*HEX'
     C                   CALL      PEEK45        P_Peek45
     C                   Else
     C                   CALL      PEEK64        P_Peek45
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_EndPgm      F3/F12 - Programm beenden                 *
      *============================================================*
      *
     C     C_EndPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      XMsgID = 'USR8100'
     C                   EVAL      USR81001 = YPgmCmd
     C                   EVAL      XMsgDta = USR8100
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C                   EVAL      F_Seq = *ZEROS
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_ChgHead     F7  - Umschalten der Überschrift          *
      *============================================================*
      *
     C     C_ChgHead     BEGSR
      *
     C                   Eval      XHeaderTyp = f_nextHeaderType(XHeaderTyp)
      *
     C                   EXSR      C_Refresh
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Top         F17 - Anfang der Subfile                  *
      *============================================================*
      *
     C     C_Top         BEGSR
      *
     C                   EVAL      SFSANR = 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Bot         F18 - Ende der Subfile                    *
      *============================================================*
      *
     C     C_Bot         BEGSR
      *
     C                   EVAL      SFSANR = SflLastRcd
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Print       F21 - Drucken Datensatz                   *
      *============================================================*
      *
     C     C_Print       BEGSR
      *
     C                   EVAL      YRcdNbr = XRcdNbr
     C                   EVAL      YFile = XFile
     C                   EVAL      YLibrary = XLibrary
     C                   EVAL      YMember = XMember
     C                   EVAL      YRcdFormat = XRcdFormat
     C                   EVAL      YMsgID = *BLANKS
     C                   EVAL      YMsgDta = *BLANKS
     C                   CALL      PEEK65        P_Peek65               99
      *
     C                   IF        YMsgID <> ''
     C                   EVAL      §MsgID  = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   EVAL      YMsgID  = ''
     C                   EVAL      YMsgDta = ''
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_AllRcds     F22 - Alle Datensätze verarbeiten         *
      *============================================================*
      *
     C     C_AllRcds     BEGSR
      *
     C                   EVAL      XMsgID = 'USR8111'
     C                   EVAL      XMsgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     C_MoreKeys    BEGSR
      *
     C                   EVAL      SFBOT = SFBOT + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBInit        Initialisieren der Subfile zur Anzeige    *
      *                  der nächsten Seite                        *
      *============================================================*
      *
     C     PBINIT        BEGSR
      *
     C                   EVAL      *IN89 = '0'
     C                   WRITE     MSGCTL
      *
     C                   EVAL      *IN80 = '0'                                  SFLDSP
     C                   EVAL      *IN81 = '1'                                  SFLDSPCTL
     C                   EVAL      *IN82 = '1'                                  SFLCLR
     C                   EVAL      *IN83 = '1'                                  SFLEND
     C                   WRITE     PBCTL
      *
     C                   EVAL      *IN82 = '0'                                  SFLCLR
      *
     C                   EVAL      SFLREC = *ZEROS
      *
     C                   EVAL      SflLastRcd = *ZEROS
      *
      *  Konvertieren nicht darstellbarer Zeichen
     C                   EVAL      IsCvtChar = bFalse
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C                   Eval      rowCnt  = 4
     C                   Eval      SFSANR  = 0
      *
     C                   Do        *hival
     C                   Read      FPEEKFLDL0                             83
     C                   If        *in83 = *on
     C                   Leave
     C                   Endif
      *
      *  Feldattribute
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  nicht erlaubte Feldtypen
     C                   If        f_isNotAlw(FLDL0100) = bTrue
     C                   Iter
     C                   Endif
      *
      *  Berechnen Anzahl Zeilen
     C                   Eval      totLin = f_nbrDspRw(FLDL0100)
      *
     C                   Exsr      syncLine
      *
      *  Ausgeben Feld
     C                   EVAL      X = 1
     C                   Exsr      PBFill
     C                   EVAL      *IN60 = '0'                                  DSPATR(ND)
      *
     C     X             DOWLE     YStrLen
     C     X             ANDLE     512
      *
     C                   EVAL      SFLRec = SFLRec + 1
     C     SFLRec        IFGT      9999
     C                   EVAL      *IN83 = '1'
     C                   LEAVE
     C                   Endif
      *
     C**                 SUBST (P) YString:X     $$DATA
     C                   Eval      $$DATA = %subst(YString: x)
     C                   Exsr      wrtPbSfl
     C                   EVAL      X = X + 35
     C                   Enddo
      *
     C                   Eval      rowCnt = rowCnt + totLin
      *
     C     SFLRec        IFGE      SflPage
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   ENDSR
      *
      *============================================================*
      *    wrtPbSfl      Schreiben Subfilesatz                     *
      *============================================================*
      *
     C     wrtPbSfl      BEGSR
      *
     C                   WRITE     PBSfl
     C                   EVAL      SflLastRcd = SflRec
     C                   EVAL      *IN60 = '1'                                  DSPATR(ND)
      *
     C                   If        SFLREC = XScreenNbr * SflPageDDS +
     C                                           1 - SflPageDDS
     C                   Eval      SFSANR = SFLREC
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    synCline      Synchronisieren wie Änderungsbildschirm   *
      *============================================================*
      *
     C     syncLine      BEGSR
      *
     C                   If        (rowCnt + totLin - 1) > 18
      *
     C     rowCnt        Do        18
     C                   Clear                   PBSFL
     C                   EVAL      SFLRec = SFLRec + 1
     C     SFLRec        IFGT      9999
     C                   EVAL      *IN83 = '1'
     C                   LEAVE
     C                   Endif
      *
     C                   Exsr      wrtPbSfl
     C                   Enddo
      *
     C                   Eval      rowCnt = 4
     C                   Endif
      *
     C                   Endsr
      *
      *============================================================*
      *    PBFill        Füllen Subfilesatz                        *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
      *      ... Feldname
     C                   EVAL      R$FNme = FLDL0100.F1FNme
      *
      *      ... überschreiben EDTCDE
     C     F_EDTCDE      IFNE      *BLANKS
     C                   EVAL      FLDL0100.F1EDTC = F_EDTCDE
     C                   ELSE
      *       Original EDITCODE verwenden
     C                   Endif
      *
      *      ... eintragen Überschrift
     C                   Eval      $$TEXT =
     C                                %trimR(f_headline(XHeaderTyp: FLDL0100)) +
     C                                ' ' + DotLine
      *
      *      ... Markieren Schlüsselfelder
     C                   If        (F_KSeq <> 0)
     C                   MOVE      ' >'          $$TEXT
     C                   Else
     C                   MOVE      ' :'          $$TEXT
     C                   Endif
      *
      *  ... NULL erlaubt?
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   EVAL      YString = f_msgText('TXT0127': '')
     C                   EVAL      YStrLen = %len(%trimR(YString))
     C                   ELSE
      *
      *  ... aufbereiten des Feldinhaltes
     C                   EVAL      YData = FLDL0100
     C                   EVAL      YFormat = 'FLDL0100'
     C                   EVAL      YSrcVar = IO_Buff
     C                   EVAL      YPgmCall = bFalse
     C                   EVAL      YCvtCcsid = bTrue
     C                   CALL      PEEK06        P_Peek06               99
      *
      *  ... Konvertieren nicht darstellbarer Zeichen
     C                   EVAL      yCcsid = *ZEROS
     C                   CALL      PEEK32        P_Peek32               99
     C     *IN99         IFEQ      '0'
     C     IsCvtChar     IFEQ      bFalse
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      IsCvtChar = bTrue
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
      *         keine Nachricht anstehend
     C                   Endif
     C                   ELSE
      *         Nachricht bereits gesendet
     C                   Endif
     C                   ELSE
      *         Fehler bei Programmaufruf
     C                   Endif
      *
      *  Ende: F1NALW
     C                   Endif
      *
      *  ... anzeigen Subfile
     C                   EVAL      *IN80 = '1'                                  SFLDSP
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       Begsr
      *
     C                   Eval      F_FLDSEQ = 0
     C     F1Key_L0      Setll     FPEEKFLDL0
      *
     C                   Endsr
      *
      *============================================================*
      *    KeepCsrPos    Beibehalten der Cursorposition            *
      *============================================================*
      *
     C     KeepCsrPos    BEGSR
      *
      *  Beibehalten der Cursorosition
     C                   EVAL      CsrRow = WScnCsrRow
     C                   EVAL      CsrCol = WScnCsrCol
      *
     C                   EVAL      CsrCol = CsrCol - POS
     C                   EVAL      CsrCol = CsrCol - 1
     C                   EVAL      CsrRow = CsrRow - ZEI
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
      *============================================================*
      *
     C     SetScreen     BEGSR
      *
     C     XDsp80        IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      ZEI = 1
     C                   EVAL      POS = 40
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 1
     C                   EVAL      POS = 7
     C                   Endif
      *
     C                   EVAL      SflPage = *HIVAL
     C                   EVAL      SflPageDDS = 15
      *
     C                   EVAL      %subarr(*in: 70: 10) = '0'
      *
     C                   SELECT
     C     XFunction     WHENEQ    '*DELETE'
     C                   EVAL      *IN70 = '1'
     C     XFunction     WHENEQ    '*DISPLAY'
     C                   EVAL      *IN75 = '1'
     C     XFunction     WHENEQ    '*COPYEXT'
     C                   EVAL      *IN79 = '1'
     C                   OTHER
      *              ????????????
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    ReadRcd       Einlesen des anzuzeigenden Satzes         *
      *============================================================*
      *
     C     ReadRcd       BEGSR
      *
     C                   IF        CIO_chainWithRRN(hFile04
     C                                              : XRcdNbr
     C                                              : bFalse
     C                                              : IO_Buff
     C                                              : IO_NullMap) = bFalse
     C                   EVAL      IsRecord = bFalse
     C                   ELSE
     C                   EVAL      IsRecord = bTrue
     C                   ENDIF
      *
     C                   ENDSR
      *
      *============================================================*
      *    First         Initialisierung                           *
      *============================================================*
      *
     C     First         BEGSR
      *
      * - Öffnen der Dateien
     C                   OPEN      PEEK14FM
     C                   OPEN      PEEKFLD
     C                   OPEN      PEEKFLDL0
     C                   CALLP     CIO_open(hFile04
     C                                      : xFile
     C                                      : xLibrary
     C                                      : xMember
     C                                      : xRcdFormat
     C                                      : 'rr, arrseq=Y, commit=N, +
     C                                         nullcap=Y, riofb=Y, secure=N, +
     C                                         ccsid=65535')
      ***                                      nullcap=Y, riofb=Y, secure=N')
      ***                                   : 'rr,arrseq=Y,nullcap=Y,riofb=Y')
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
      *
      * - Kopffelder
     C                   EVAL      $$RCDN = XRcdNbr
      *
      * - Darstellung der Subfile
     C                   EVAL      SflMde = '1'
      *
      * - Darstellung der Befehlstasten
     C                   EVAL      SfBot = 1
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Einlesen des anzuzeigenden Satzes
     C                   EXSR      ReadRcd
      *
      * - Subfile füllen
     C                   EVAL      F_Seq = *ZEROS
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
      * - Copyright
     C                   EVAL      §MsgID = 'USR9999'
     C                   EVAL      §MsgDta = XCopyRight
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
     C                   ENDSR
      *
      *============================================================*
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        Begsr
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK06 = f_pgmCallN('PEEK06')
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK32 = f_pgmCallN('PEEK32')
     C                   Eval      PEEK45 = f_pgmCallN('PEEK45')
     C                   Eval      PEEK64 = f_pgmCallN('PEEK64')
     C                   Eval      PEEK65 = f_pgmCallN('PEEK65')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = §NbrFKeys
     C                   Call      PEEK23        P_Peek23
     C                   Eval      scrnFKeys = %subarr(yFKeys: 1)
      *
     C                   Endsr
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
