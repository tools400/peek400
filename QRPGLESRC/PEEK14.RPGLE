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
     F                                     INFDS(workstn)
     F                                     SFILE(PBSFL:SFLREC)
      * Feldliste
     FPEEKFLDL0 IF   E           K DISK    USROPN
     F                                     RENAME(FPEEKFLD:FPEEKFLDL0)
     F                                     INFDS(Peek#00)
     F                                     PREFIX(F_)
     FPEEKFLD   IF   E           K DISK    USROPN
     F                                     INFDS(Peek#  )
     F                                     PREFIX(F_)
      * Für Einzelsatzzugriff zum reinen Lesen von Datensätzen
     D hFile04         DS                   likeds(hFile_t)
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
     D  IO_BuffFld                         like(rcdBuf_t)
      *
     D IO_NullMap      S                   like(nullMap_t)
     D                                     dim(NULL_MAP_SIZE)
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK14
      /undefine internal_prototype
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
     D yFKeys          S             18A   dim(32)
     D yNbrOfKeys      S                   like(int4_t)
     D yMsgID          S              7A
     D yMsgDta         S            512A
      *
     D YPgmCmd         S             10A
     D YCmdDta         S                   like(pgmCmdDt_t)
      *
     D YString         S                   LIKE(rcdBuf_t)
     D YStrLen         S                   like(int4_t)
      *
     D YDsp80          S              1A   INZ(*BLANKS)
     D YHeaderTyp      S             10A   INZ(*BLANKS)
     D YCopyRight      S            512A   INZ(*BLANKS)
     D yFldName        S                   like(fieldNme_t) inz
     D YFldInhalt      S                   LIKE(rcdBuf_t)
     D                                     INZ(*BLANKS)
     D yLength         S                   like(int4_t) inz
     D yProtect        S                   like(bool_t) inz(bTrue)
     D yIsUcs2         S                   like(int4_t) inz
      *
     D SflPage         S                   like(int4_t) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflLastRcd      S                   like(SflPage   ) inz
     D §NbrFKeys       C                   CONST(3)
      *
     D SfBot           S                   like(int4_t) inz
      *
     D IsRecord        S                   like(bool_t) inz(bFalse)
     D IsCvtChar       S                   like(bool_t) inz(bFalse)
      *
     D PEEK06_NAME     S                   like(pgmCallN_t) inz
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK32_NAME     S                   like(pgmCallN_t) inz
     D PEEK45_NAME     S                   like(pgmCallN_t) inz
     D PEEK64_NAME     S                   like(pgmCallN_t) inz
     D PEEK65_NAME     S                   like(pgmCallN_t) inz
      *
     D DotLine         S             40A   INZ(*ALL'.')
      *
     D X               S                   like(int4_t) inz
      *
     D TOTLIN          S                   like(int4_t)
     D                                     inz
     D rowCnt          S                   like(int4_t)
     D                                     inz
      *
     D Editor          S             10A   inz
      *
      /COPY QCOPYLE,PPEEK06
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK32
      /COPY QCOPYLE,PPEEK45
      /COPY QCOPYLE,PPEEK64
      /COPY QCOPYLE,PPEEK65
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      /COPY QCOPYLE,F_PEEK63
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK14          PI
     D  i_dsp80                            const like(dsp80_t)
     D  io_headerType                            like(headerType_t)
     D  i_copyright                        const like(copyRght_t)
     D  i_rcdNbr                           const like(rcdNbr_t)
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
     D  i_mbr                              const like(mbr_t)
     D  i_rcdFmt                           const like(fmt_t)
     D  i_function                         const like(function_t)
     D  i_commitLVL                        const like(bool_t)
     D  io_screenNbr                             like(int4_t)
     D  o_msgID                                  like(msgId_t)
     D  o_msgDta                                 like(msgDta_t)
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
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
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
     C                   Eval      cursorPosition.row =
     C                               workstn.csrPos / 256
     C                   Eval      cursorPosition.column =
     C                               %rem(workstn.csrPos: 256)
      *
      * - Löschen der Cursorposition
     C                   EVAL      CsrRow = *ZEROS
     C                   EVAL      CsrCol = *ZEROS
      *
      *  Seitennummer  berechnen
     C     SFLCSR        DIV       SflPageDDS    io_screenNbr
     C                   IF        SFLCSR = (SflPageDDS * io_screenNbr)
      *       keine Korrektur erforderlich
     C                   ELSE
     C                   EVAL      io_screenNbr = io_screenNbr + 1
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
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   Callp     p_sndPgmMg(YMsgID: YMsgDta: §§pgmName)
     C                   Eval      YMsgId = ''
     C                   Eval      YMsgDta = ''
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
     C                   Callp     p_wrongKey(workstn.aid: §§pgmName)
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
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   Callp     p_sndPgmMg('USR8204': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C     SFLCSR        CHAIN     PBSFL                              01
     C     *IN01         IFEQ      '1'
      *  Error: Unable to find record.
     C                   Callp     p_sndPgmMg('USR8120': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      F_Field = R$FNME
     C     F1KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Error: Unable to find record.
     C                   Callp     p_sndPgmMg('USR8120': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  Error: Editor not allowed. Field &1 is NULL.
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   CLEAR                   USR8220
     C                   Eval      USR82201 = FLDL0100.F1FNME
     C                   CALLP     p_sndPgmMg('USR8220': USR8220: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      YDsp80 = i_dsp80
     C                   EVAL      YHeaderTyp = io_headerType
     C                   EVAL      YCopyRight = i_copyright
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
     C                   Callp     p_sndPgmMg('USR8204': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C     SFLCSR        CHAIN     PBSFL                              01
     C     *IN01         IFEQ      '1'
      *  Error: Unable to find record.
     C                   Callp     p_sndPgmMg('USR8120': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      F_Field = R$FNME
     C     F1KEY         CHAIN     FPEEKFLD                           11
     C     *IN11         IFEQ      '1'
      *  Error: Unable to find record.
     C                   Callp     p_sndPgmMg('USR8120': '': §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  Error: Editor does not support data type of field &1.
     C                   IF        FLDL0100.F1DTYP <> 'A' and
     C                             FLDL0100.F1DTYP <> 'G'
     C                   CLEAR                   USR8221
     C                   Eval      USR82211 = FLDL0100.F1FNME
     C                   CALLP     p_sndPgmMg('USR8221': USR8221: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
      *  Error: Field &1 exceeds maximum length allowed for editor.
     C**                 IF        f_buffLn(FLDL0100) > 1024
     C**                 CLEAR                   USR8222
     C**                 Eval      USR82221 = FLDL0100.F1FNME
     C**                 CALLP     p_sndPgmMg('USR8222': USR8222: §§pgmName)
     C**                 LEAVESR
     C**                 ENDIF
      *
      *  Error: Editor not allowed. Field &1 is NULL.
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   CLEAR                   USR8220
     C                   Eval      USR82201 = FLDL0100.F1FNME
     C                   CALLP     p_sndPgmMg('USR8220': USR8220: §§pgmName)
     C                   LEAVESR
     C                   ENDIF
      *
     C                   EVAL      YDsp80 = i_dsp80
     C                   EVAL      YHeaderTyp = io_headerType
     C                   EVAL      YCopyRight = i_copyright
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
     C                   IF        f_buffLn(FLDL0100) > RCD_BUFF_LEN
     C                   CLEAR                   USR8206
     C                   Eval      USR82061 = RCD_BUFF_LEN
     C                   Callp     p_sndPgmMg('USR8206': USR8206: §§pgmName)
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
     C                   CALLP     PEEK45(i_dsp80: io_headerType: i_copyright
     C                                    : R$FNME: yFldInhalt: yLength
     C                                    : bTrue: yIsUcs2
     C                                    : YMsgID: YMsgDta)
     C                   Else
     C                   CALLP     PEEK64(i_dsp80: io_headerType: i_copyright
     C                                    : R$FNME: yFldInhalt: yLength
     C                                    : bTrue: yIsUcs2
     C                                    : YMsgID: YMsgDta)
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
     C                   EVAL      o_msgID = 'USR8100'
     C                   EVAL      USR81001 = YPgmCmd
     C                   EVAL      o_msgDta = USR8100
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
     C                   Eval      io_headerType =
     C                               f_nextHeaderType(io_headerType)
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
     C                   monitor
     C                   callp     PEEK65(i_rcdNbr
     C                                    : i_file: i_lib: i_mbr: i_rcdFmt
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C                   IF        YMsgID <> ''
     C                   Callp     p_sndPgmMg(YMsgID: YMsgDta: §§pgmName)
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
     C                   EVAL      o_msgID = 'USR8111'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   If        SFLREC = io_screenNbr * SflPageDDS +
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
     C                               %trimR(f_headline(
     C                                 io_headerType: FLDL0100)) + ' ' + DotLine
      *
      *      ... Markieren Schlüsselfelder
     C                   If        (F_KSeq <> 0)
     C                   EVAL      %subst($$TEXT: %len($$TEXT) - 1: 2) = ' >'
     C                   Else
     C                   EVAL      %subst($$TEXT: %len($$TEXT) - 1: 2) = ' :'
     C                   Endif
      *
      *  ... NULL erlaubt?
     C                   IF        FLDL0100.F1NALW = '1' and
     C                             IO_NullMap(FLDL0100.F1SEQ) = 1
     C                   EVAL      YString = f_msgText('TXT0127': '')
     C                   EVAL      YStrLen = %len(%trimR(YString))
     C                   ELSE
      *
     C                   monitor
      *  ... aufbereiten des Feldinhaltes
     C                   CALLP     PEEK06(FLDL0100: 'FLDL0100': IO_Buff
     C                                    : bFalse: bTrue
     C                                    : YString: YStrLen: YMsgID: YMsgDta)
      *
      *  ... Konvertieren nicht darstellbarer Zeichen
     C                   CALLP     PEEK32(YString: yStrLen: 0
     C                                    : yMsgID: yMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '0'
     C     IsCvtChar     IFEQ      bFalse
     C     YMsgID        IFNE      *BLANKS
     C                   EVAL      IsCvtChar = bTrue
     C                   Callp     p_sndPgmMg(YMsgID: YMsgDta: §§pgmName)
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
     C                   EVAL      YMsgID  = ''
     C                   EVAL      YMsgDta = ''
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
     C     i_dsp80       IFEQ      '0'
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
     C     i_function    WHENEQ    '*DELETE'
     C                   EVAL      *IN70 = '1'
     C     i_function    WHENEQ    '*DISPLAY'
     C                   EVAL      *IN75 = '1'
     C     i_function    WHENEQ    '*COPYEXT'
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
     C                                              : i_rcdNbr
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
     C                                      : i_file
     C                                      : i_lib
     C                                      : i_mbr
     C                                      : i_rcdFmt
     C                                      : 'rr, arrseq=Y, commit=N, +
     C                                         nullcap=Y, riofb=Y, secure=N, +
     C                                         ccsid=65535')
      ***                                      nullcap=Y, riofb=Y, secure=N')
      ***                                   : 'rr,arrseq=Y,nullcap=Y,riofb=Y')
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Kopffelder
     C                   EVAL      $$RCDN = i_rcdNbr
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
     C                   Callp     p_sndPgmMg('USR9999': i_copyright: §§pgmName)
      *
     C                   ENDSR
      *
      *====================================================*
      *  InzSr --  Initialize program                      *
      *====================================================*
      *
     C     InzSr         BEGSR
      *
     C                   IF        (isInzSr = bTrue)
     C                   Leavesr
     C                   ENDIF
      *
     C                   Eval      isInzSr = bTrue
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK06_NAME = f_pgmCallN('PEEK06')
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
     C                   Eval      PEEK32_NAME = f_pgmCallN('PEEK32')
     C                   Eval      PEEK45_NAME = f_pgmCallN('PEEK45')
     C                   Eval      PEEK64_NAME = f_pgmCallN('PEEK64')
     C                   Eval      PEEK65_NAME = f_pgmCallN('PEEK65')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': §NbrFKeys
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      scrnFKeys = %subarr(yFKeys: 1)
      *
     C                   Endsr
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
