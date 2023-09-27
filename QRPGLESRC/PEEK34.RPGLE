      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.5.0                               *
      *  Programm : PEEK34                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 22.12.1997  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Layout                                                       *
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
     FPEEK34FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
     F                                     INFSR(*PSSR)
      * Arbeitsdatei nach Anzeigefolge
     FPEEKWRK   UF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Work_00_DS)
     F                                     PREFIX(W_)
      * Arbeitsdatei nach Eingangsfolge
     FPEEKWRK_  UF A F 1024        DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Work_01_DS)
      * Feldliste nach Sequenzfolge
     FPEEKFLDL1 UF   E           K DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek_01_DS)
     F                                     RENAME(FPEEKFLD:FPEEKFLDL1)
     F                                     PREFIX(F_)
      * Feldliste nach Eingangsfolge
     FPEEKFLD   UF   E             DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek_00_DS)
     F                                     PREFIX(F_)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,D_INFDS
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK34
      /undefine internal_prototype
      *
      *---Variablendefinition ShortCmd---------------------*
      /COPY QCOPYLE,ShortCmd_D
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8136                                               Feld nicht gefunden
      /COPY QCOPYLE,USR8209                                               Feld nicht gefunden
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
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK25
      /COPY QCOPYLE,PPEEK35
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     D DS_PEEKWRK    E DS          1024    EXTNAME(PEEKWRK) INZ
     D                                     PREFIX(W_)
      *
     DWork_00_DS       DS                  likeds(r§infds)
     DWork_01_DS       DS                  likeds(r§infds)
     DPeek_00_DS       DS                  likeds(r§infds)
     DPeek_01_DS       DS                  likeds(r§infds)
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
      *---Arbeitsdatenbereich für PEEKWRK------------------*
      /COPY QCOPYLE,WRK0001
      *----------------------------------------------------*
      *
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
     D YField          S             10A   INZ(*BLANKS)
      *
     D YColorAttr      S              1A   INZ(*BLANKS)
      *
     D SflPage         S                   like(r§int4    ) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflNbrRcd       S                   like(SflPage   ) inz
     D NbrFKeys        C                   CONST(3)
      *
     D SfBot           S                   like(r§int4    ) inz
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
      *
     D IsSflError      S              1A   INZ(bFalse)
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
      *IsVarLen        S              1A   INZ(bFalse)
      *IsDecimal       S              1A   INZ(bFalse)
      *IsEditcode      S              1A   INZ(bFalse)
     D IsBatch         S              1A   INZ(bFalse)
      *
     D PEEK21_NAME     S                   like(r§pgmCallN) inz
     D PEEK23_NAME     S                   like(r§pgmCallN) inz
     D PEEK25_NAME     S                   like(r§pgmCallN) inz
     D PEEK35_NAME     S                   like(r§pgmCallN) inz
      *
     D R_Field         S                   INZ(*BLANKS) LIKE(##Field)
     D R_Seq           S                   INZ(*ZEROS ) LIKE(F_Seq  )
     D LstField        S                   INZ(*BLANKS) LIKE(##Field)
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     D PEEK34          PI
     D  i_dsp80                            const like(r§dsp80)
     D  i_copyright                        const like(r§copyRght)
     D  i_function                         const like(r§option)
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKWRK
     C     W0KEY         KLIST
     C                   KFLD                    W_Key
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL1
     C     F1Key         KLIST
     C                   KFLD                    F_Seq
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
     C     SFSANR        IFLE      *ZEROS
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
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#2                                      BT-Tasten 2
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#3                                      BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#4                                      BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#5                                      BT-Tasten 4
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   WRITE     PBBOT#6                                      BT-Tasten 4
     C                   OTHER
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   EVAL      SFBOT = 1
     C                   Endsl
      *
      *  Anzeige der Subfile
     C                   EXFMT     PBCTL
     C                   EVAL      *IN70 = '0'
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Aktuelle Satz-Nr.
     C     SFLCSR        IFGT      *ZEROS
     C                   EVAL      SFSANR = SFLCSR
     C                   Endif
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(§ScnAID: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
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
     C     YPgmCmd       WHENEQ    '*EXIT'
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F3  - Sichern & beenden
     C     YPgmCmd       WHENEQ    '*SAVE_EXIT'
     C                   EXSR      C_Enter
     C     IsSflError    IFEQ      bFalse
     C                   EXSR      C_SaveExit
     C                   LEAVE
     C                   ENDIF
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F11 - Float Keys
     C     YPgmCmd       WHENEQ    '*FLOATKEYS'
     C                   EXSR      C_FloatKey
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F16 - Suchen
     C     YPgmCmd       WHENEQ    '*SEARCH'
     C                   EXSR      C_Search
     C                   ITER
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
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
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
     C     IsBatch       IFEQ      bFalse
     C                   CLOSE     PEEK34FM
     C                   ELSE
      *  PEEK34FM war nie offen!
     C                   Endif
      *
     C                   CLOSE     PEEKFLDL1
     C                   CLOSE     PEEKFLD
      *
     C                   CLOSE     PEEKWRK
     C                   CLOSE     PEEKWRK_
     C                   EXSR      ClrPeekWrk
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      VReadC
      *
     C     ##Field       IFNE      *BLANKS
     C                   EXSR      C_Search
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Search      F16 - Suchen                              *
      *============================================================*
      *
     C     C_Search      BEGSR
      *
     C     ##Field       IFNE      *BLANKS
     C                   EVAL      LstField = ##Field
     C                   EVAL      ##Field = *BLANKS
     C                   Endif
      *
     C     LstField      IFEQ      *BLANKS
     C                   EVAL      *IN70 = '1'
     C                   CLEAR                   USR8209
     C                   EVAL      §MsgID = 'USR8209'
     C                   EVAL      §MsgDta = USR8209
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToField
     C     IsNewPos      IFEQ      bTrue
     C                   EVAL      SFSANR = Wrk_SFSANR
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PosToField    Subfile neu positionieren                 *
      *============================================================*
      *
     C     PosToField    BEGSR
      *
     C     LstField      IFNE      R_Field
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstField      IFEQ      *BLANKS
     C                   EVAL      IsNewPos = bFalse
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchField
     C     IsFound       IFEQ      bFalse
     C                   EVAL      IsNewPos = bFalse
     C                   CLEAR                   USR8136
     C                   EVAL      §MsgID = 'USR8136'
     C                   EVAL      USR81361 = LstField                          Feldname
     C                   EVAL      §MsgDta = USR8136
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EVAL      IsNewPos = bTrue
     C                   Endif
     C                   Endif
      *
     C                   EVAL      R_Field = LstField
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchField     Suchen Feld in Subfile                    *
      *============================================================*
      *
     C     SrchField     BEGSR
      *
     C     *IN80         IFEQ      '0'
     C                   EVAL      IsFound = bFalse
     C                   ELSE
      *
     C                   EVAL      IsFound = bFalse
     C                   Eval      LstNbrRcd = LstNbrRcd + 1
      *
     C     LstNbrRcd     DO        SflNbrRcd     SflRec
     C     SflRec        CHAIN     PBSFL                              1111
     C     *IN11         IFEQ      '1'
     C                   EVAL      IsFound = bFalse
     C                   LEAVE
     C                   Endif
      *
     C                   IF        LstField =
     C                             %subst($$FNME: 1:(f_scan(' ':
     C                                               LstField) - 1))
     C                   EVAL      IsFound = bTrue
     C                   LEAVE
     C                   ELSE
     C     SFPAU         IFNE      *BLANKS
      *  ... Satz geändert
     C                   EXSR      VSfpauChg
     C                   ELSE
      *  ... Satz nicht geändert
     C                   EXSR      VSfpauClr
     C                   Endif
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSFL
     C                   ITER
     C                   Endif
      *
     C                   Enddo
      *
     C     IsFound       IFEQ      bTrue
     C                   EVAL      Wrk_SFSANR = SflRec
     C                   Eval      LstNbrRcd = SflRec
     C                   ELSE
     C                   EVAL      Wrk_SFSANR = *ZEROS
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    SrchInit      Initialisieren Suchfunktion               *
      *============================================================*
      *
     C     SrchInit      BEGSR
      *
     C                   Eval      LstField  = ' '
     C                   Eval      LstNbrRcd = 0
     C                   Eval      R_Field   = LstField
      *
     C                   ENDSR
      *
      *============================================================*
      *    VReadC        Verarbeiten der Subfileauswahlen          *
      *============================================================*
      *
     C     VReadC        BEGSR
      *
     C                   EVAL      IsSflError = bFalse
      *
     C     *IN80         IFEQ      '0'
      *   keine Einträge in Subfile vorhanden ...
     C                   ELSE
      *
     C     1             DO        SflNbrRcd
     C                   READC     PBSFL                                  1111
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C     SflRec        CHAIN     PBSFL                              11
      *
     C                   EXSR      SflBzoff
      *
      *  Cursorpositionierung ...
     C     IsSflError    IFEQ      bFalse
     C                   EVAL      SflCsr = SflRec
     C                   ELSE
      *  Subfile nicht neu positionieren
     C                   Endif
      *
      *  Linksbündig setzen ...
     C                   EVAL      SFPAU = %triml(SFPAU)
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C                   CALLP     PEEK21('#' + SFPAU: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
      *  Fehlermeldung ...
     C                   EVAL      §MsgID = 'USR8110'
     C                   EVAL      §MsgDta = SFPAU
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSfl
     C                   EVAL      IsSflError = bTrue
     C                   ITER
     C                   Endif
      *
      *----------------------------*
      *  Ausführen SFL-Befehl ...  *
      *----------------------------*
     C                   EVAL      Sfl_Cmd = YPgmCmd
      *
     C                   SELECT
     C     Sfl_Cmd       WHENEQ    '*NONE'
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   EVAL      §MsgID = 'USR8110'
     C                   EVAL      USR81101 = YPgmCmd
     C                   EVAL      §MsgDta = USR8110
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSfl
     C                   EVAL      IsSflError = bTrue
     C                   ITER
     C                   Endsl
      *
      *----------------------------*
      *  Verarbeiten               *
      *  Datensatzänderungen       *
      *----------------------------*
     C                   EXSR      GetColor
     C                   EXSR      FillRecord
      *  Prüfen, Datensatz ...
     C                   monitor
     C                   callp     PEEK35(RecordNbr: WRK0001: yField
     C                                    : YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *  ... Fehler beim Programmaufruf
     C     *IN99         IFEQ      '1'
     C                   EXSR      VSfpauErr
     C                   ELSE
      *  ... Programaufruf war OK
     C     YMsgID        IFEQ      *BLANKS
      *      ... Prüfung ist OK
     C                   EXSR      VPos
     C                   EXSR      VSfpauClr
     C                   ELSE
      *      ... Fehler bei der Prüfung
     C                   EXSR      VPosCsr
     C                   EXSR      VSfpauErr
     C                   EVAL      *IN85 = '0'                                  DSPATR(RI)
     C                   EVAL      §MsgID = YMsgID
     C                   EVAL      §MsgDta = YMsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EVAL      IsSflError = bTrue
     C                   Endif
     C                   Endif
      *
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSfl
     C                   Enddo
      *
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetColor      Auswählen neue Farbe                      *
      *============================================================*
      *
     C     GetColor      BEGSR
      *
     C     ##Color       IFNE      *BLANKS
      *
     C                   EVAL      YColorAttr = $$Color
      *
     C                   monitor
     C                   callp     PEEK25(i_dsp80: YColorAttr: yMsgID: yMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '1'
      *             Fehler aufgetreten
     C                   ELSE
     C                   EVAL      $$Color = YColorAttr
     C                   Endif
      *
     C                   ELSE
      *  Cursor steht auf falschem Feld ...
     C                   Endif
      *
     C                   EVAL      ##Color = *BLANKS
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
      *    C_SaveExit    F3     - Sichern und beenden              *
      *============================================================*
      *
     C     C_SaveExit    BEGSR
      *
     C                   EVAL      R_Seq = *ZEROS
      *
     C                   EVAL      W_Key = *ZEROS
     C     W0Key         SETLL     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ  (N) FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      R_Seq = R_Seq + 1
      *
     C                   EVAL      WRK0001 = W_Data
      *
     C     WRK_RcdNbr    CHAIN     FPEEKFLD                           11
      *
     C                   EVAL      F_Seq = R_Seq
     C                   EVAL      F_Hidden = WRK_Hidden
     C                   EVAL      F_Color = WRK_Color
     C                   EVAL      F_MarkCol = WRK_MrkCol
     C                   EVAL      F_MaxSize = WRK_MaxSiz
     C                   EVAL      F_EdtCde = WRK_EdtCde
      *
     C                   UPDATE    FPEEKFLD
     C                   Enddo
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
      * - Abrufen der Subfiletexte
     C                   EXSR      PBSflTxt
      *
      * - Subfile neu aufbauen
     C                   EVAL      W_Key = *ZEROS
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
      *
     C                   EXSR      SrchInit
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_FloatKey    F11 - Schlüsselfelder an den Anfang       *
      *============================================================*
      *
     C     C_FloatKey    BEGSR
      *
      *  Alle nicht Schlüsselfelder mit
      *  negativen Folgenummern versehen ...
     C                   EVAL      W_Key = *ZEROS
     C     W0Key         SETLL     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      WRK0001 = W_Data
      *
     C     WRK_KSeq      IFEQ      *ZEROS
     C                   MULT      -1            WRK_Seq
     C                   ELSE
     C                   EVAL      WRK_Seq = *ZEROS
     C                   Endif
      *
     C                   EVAL      W_Key = WRK_Seq
     C                   EVAL      W_Data = WRK0001
     C                   UPDATE    FPEEKWRK
     C                   Enddo
      *
      *  Nun alle negative Folgenummern neu
      *  durchnummerieren ...
     C                   EVAL      R_Seq = *ZEROS
      *
     C                   EVAL      W_Key = *HIVAL
     C     W0Key         SETGT     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READP     FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      WRK0001 = W_Data
      *
      *  Schlüsselfelder? ...
     C     WRK_KSeq      IFEQ      *ZEROS
      *  ... nein, kein Schlüselfeld
     C                   EVAL      R_Seq = R_Seq + 10
     C                   EVAL      WRK_Seq = R_Seq
     C                   ELSE
      *  ... ja, Schlüselfeld
     C     WRK_KSeq      MULT      10            WRK_Seq
     C     WRK_Seq       IFGT      R_Seq
     C                   EVAL      R_Seq = WRK_Seq
     C                   ELSE
      *    R_Seq stehenlassen ...
     C                   Endif
     C                   Endif
      *
     C                   EVAL      W_Key = WRK_Seq
     C                   EVAL      W_Data = WRK0001
     C                   UPDATE    FPEEKWRK
     C                   Enddo
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
     C                   EVAL      SFSANR = SflNbrRcd
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
      *    FillRecord    Füllen Datensatz in PEEKWRK               *
      *============================================================*
      *
     C     FillRecord    BEGSR
      *
     C                   EVAL      WRK_Seq = ##Seq
      *
     C                   SELECT
     C     ##Hidden      WHENEQ    bTrue
     C                   EVAL      WRK_Hidden = bFalse
     C     ##Hidden      WHENEQ    bFalse
     C                   EVAL      WRK_Hidden = bTrue
     C                   OTHER
     C                   EVAL      WRK_Hidden = ##Hidden
     C                   Endsl
      *
     C                   EVAL      WRK_Color = $$Color
     C                   EVAL      WRK_MrkCol = ##MarkCol
     C                   EVAL      WRK_MaxSiz = ##MaxSize
     C                   EVAL      WRK_EdtCde = ##EdtCde
      *
     C                   ENDSR
      *
      *============================================================*
      *    SflBzoff      Aussetzen aller Subfilebezugszahlen       *
      *                  für die MArkierung von Eingabefehlern     *
      *============================================================*
      *
     C     SflBzoff      BEGSR
      *
      *  DSPATR(PC)
     C                   EVAL      %subarr(*in: 20: 10) = '0'
      *  DSPATR(RI)
     C                   EVAL      %subarr(*in: 30: 10) = '0'
      *
     C                   ENDSR
      *
      *============================================================*
      *    VPosCsr       Positionieren Cursor auf fehlerhaftes     *
      *                  Feld in der Subfile                       *
      *============================================================*
      *
     C     VPosCsr       BEGSR
      *
     C                   SELECT
     C     YField        WHENEQ    'SEQ'
     C                   EVAL      *IN20 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN30 = '1'                                  DSPATR(RI)
     C     YField        WHENEQ    'HIDDEN'
     C                   EVAL      *IN21 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN31 = '1'                                  DSPATR(RI)
     C     YField        WHENEQ    'COLOR'
     C                   EVAL      *IN22 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN32 = '1'                                  DSPATR(RI)
     C     YField        WHENEQ    'MARKCOL'
     C                   EVAL      *IN23 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN33 = '1'                                  DSPATR(RI)
     C     YField        WHENEQ    'MAXSIZE'
     C                   EVAL      *IN24 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN34 = '1'                                  DSPATR(RI)
     C     YField        WHENEQ    'EDTCDE'
     C                   EVAL      *IN25 = '1'                                  DSPATR(PC)
     C                   EVAL      *IN35 = '1'                                  DSPATR(RI)
     C                   OTHER
      *  Weiß noch nicht
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    VPos          Verarbeiten der Eingaben                  *
      *============================================================*
      *
     C     VPos          BEGSR
      *
     C     RecordNbr     CHAIN     PEEKWRK_      DS_PEEKWRK           11
     C     *IN11         IFEQ      '1'
      *  Weiß noch nicht, was zu tun ist ...
     C                   ELSE
     C                   EVAL      WRK0001 = W_Data
     C                   EXSR      FillRecord
     C                   EVAL      W_Key = WRK_Seq
     C                   EVAL      W_Data = WRK0001
     C                   UPDATE    PEEKWRK_      DS_PEEKWRK
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauClr     Löschen Subfileauswahl                    *
      *============================================================*
      *
     C     VSfpauClr     BEGSR
      *
     C                   EVAL      SFPAU = *BLANKS
     C                   EVAL      *IN85 = '0'                                  DSPATR(RI)
     C                   EVAL      *IN84 = '0'                                  SFLNXTCHG
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
      *============================================================*
      *
     C     VSfpauErr     BEGSR
      *
     C                   EVAL      *IN85 = '1'                                  DSPATR(RI)
     C                   EXSR      VSfpauChg
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauChg     Datensatz in Subfile als geändert         *
      *                  markieren                                 *
      *============================================================*
      *
     C     VSfpauChg     BEGSR
      *
     C                   EVAL      *IN84 = '1'                                  SFLNXTCHG
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
     C                   EVAL      SflNbrRcd = *ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBReadUP      Vorwärts füllen der Subfile               *
      *============================================================*
      *
     C     PBReadUP      BEGSR
      *
     C                   DO        *HIVAL
     C                   READ  (N) FPEEKWRK                               83
     C     *IN83         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      PBFill
      *
     C                   EVAL      SflRec = SflRec + 1
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   WRITE     PBSfl
     C                   EVAL      SflNbrRcd = SflRec
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
      *    PBFill        Füllen Subfilesatz                        *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
     C                   EXSR      SflBzoff
      *
     C                   EVAL      RecordNbr = Work_00_DS.RcdNbr
      *
     C                   EVAL      WRK0001 = W_Data
      *
     C     WRK_RcdNbr    CHAIN (N) FPEEKFLD                           11
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  ... Anzeigereihenfolge
     C                   eval      ##Seq = WRK_Seq
      *  ... Feldname
     C                   eval      $$FNme = FLDL0100.F1FNme
      *  ... Feldbezeichnung
     C                   eval      $$FTxt = FLDL0100.F1FTxt
      *  ... Datentyp
     C                   eval      $$DTyp = FLDL0100.F1DTyp
      *
      *  ... Anzahl Dezimalstellen
     C                   If        (f_isNumFld(FLDL0100) = bTrue) and
     C                             (f_isFloatFld(FLDL0100) = bFalse)
     C                   Eval      $$Digt = FLDL0100.F1DIGT
      *      ... Anzahl Nachkommastellen
     C                   Eval      $$DecP = FLDL0100.F1DECP
     C                   Eval      isDecimal = bTrue
     C                   Else
     C                   Eval      $$Digt = f_buffLn(FLDL0100)
     C                   Eval      $$DecP = 0
     C                   Eval      isDecimal = bFalse
     C                   Endif
      *
      *  ... Variable Feldlänge
     C                   If        f_isVarLen(FLDL0100) = bTrue
     C                   Eval      isVarLen = bTrue
     C                   Else
     C                   Eval      isVarLen = bFalse
     C                   Endif
      *
      *  ... Unbekannte Feldart
     C                   If        F_UNKNOWN = bTrue
     C                   Eval      isUnKnown = bTrue
     C                   Else
     C                   Eval      isUnKnown = bFalse
     C                   Endif
      *
      *  ... Startposition
     C                   eval      $$IBuf = FLDL0100.F1IBuf
      *  ... Keyfeldnummer
     C     F_KSeq        IFNE      *ZEROS
     C                   EVAL      $$KSeq = 'K'+%editc(%dec(F_KSeq: 3: 0): 'X')
     C                   ELSE
     C                   EVAL      $$KSeq = ''
     C                   Endif
      *  ... Sichtbar
     C                   SELECT
     C     WRK_Hidden    WHENEQ    bTrue
     C                   EVAL      ##Hidden = bFalse
     C     WRK_Hidden    WHENEQ    bFalse
     C                   EVAL      ##Hidden = bTrue
     C                   OTHER
     C                   EVAL      ##Hidden = WRK_Hidden
     C                   Endsl
      *  ... Farbe
     C                   EVAL      ##Color = *BLANKS
     C                   EVAL      $$Color = WRK_Color
      *  ... Farbmarkierung
     C                   EVAL      ##MarkCol = WRK_MrkCol
      *  ... Max. Anzeigebreite (Größe)
     C                   EVAL      ##MaxSize = WRK_MaxSiz
      *  ... Editcode
     C                   EVAL      ##EdtCde = WRK_EdtCde
      *  ... Original-Editcode
     C                   if        (FLDL0100.F1EDTC <> '')
     C                   eval      $$EDTC = '(' + %trim(FLDL0100.F1EDTC) + ')'
     C                   eval      IsEditcode = '1'
     C                   else
     C                   eval      $$EDTC = ''
     C                   eval      IsEditcode = '0'
     C                   endif
      *
      *  ... anzeigen Subfile
     C                   EVAL      *IN80 = '1'                                  SFLDSP
      *
      *  ... Löschen Subfileauswahl
     C                   EXSR      VSfpauClr
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       BEGSR
      *
     C     W0Key         SETLL     FPEEKWRK
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetBZ       Setzen Bezugszahlen                       *
      *============================================================*
      *
     C     PBSetBZ       BEGSR
      *
      *  Editcode
     C     IsDecimal     IFEQ      bFalse
     C                   EVAL      *IN71 = '0'
     C                   ELSE
     C                   EVAL      *IN71 = '1'
     C                   Endif
      *
      *  Dezimalstellen
     C     IsDecimal     IFEQ      bFalse
     C                   EVAL      *IN72 = '0'
     C                   ELSE
     C                   EVAL      *IN72 = '1'
     C                   Endif
      *
      *  Kennzeichnung für variable Länge
     C                   If        isVarLen = bFalse
     C                   EVAL      *IN73 = '0'
     C                   ELSE
     C                   EVAL      *IN73 = '1'
     C                   Endif
      *
      *  Unbekannter Feldtyp
     C                   If        isUnKnown = bFalse
     C                   EVAL      *IN74 = '0'
     C                   ELSE
     C                   EVAL      *IN74 = '1'
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSflTxt      Abrufen der Subfiletexte                  *
      *============================================================*
      *
     C     PBSflTxt      BEGSR
      *
      *  TXT0080
     C                   Eval      TXT0080 = f_msgText('TXT0080': ' ')
      *  TXT0081
     C                   Eval      TXT0081 = f_msgText('TXT0081': ' ')
      *  TXT0082
     C                   Eval      TXT0082 = f_msgText('TXT0082': ' ')
      *  TXT0083
     C                   Eval      TXT0083 = f_msgText('TXT0083': ' ')
      *  TXT0084
     C                   Eval      TXT0084 = f_msgText('TXT0084': ' ')
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
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 2
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 2
     C                   EVAL      POS = 2
     C                   Endif
      *
     C                   EVAL      SflPage = *HIVAL
     C                   EVAL      SflPageDDS = 4
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClrPeekWrk    Löschen der Datei PEEKWRK                 *
      *============================================================*
      *
     C     ClrPeekWrk    BEGSR
      *
     C                   EVAL      §File = 'PEEKWRK'
     C                   EVAL      §Lib = 'QTEMP'
     C                   EVAL      §Mbr = '*FIRST'
      /COPY QCOPYLE,CLRPFM
      *
     C                   ENDSR
      *
      *============================================================*
      *    CopyToWork    Kopieren PEEKFLD nach PEEKWRK             *
      *============================================================*
      *
     C     CopyToWork    BEGSR
      *
     C                   EVAL      R_Seq = 0
     C                   EVAL      F_Seq = 0
      *
     C     F1Key         SETLL     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READ  (N) FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   CLEAR                   WRK0001
     C                   CLEAR                   DS_PEEKWRK
      *
     C                   EVAL      R_Seq = R_Seq + 10
      *
     C                   EVAL      W_Key = R_Seq
      *
     C                   EVAL      WRK_RcdNbr = Peek_01_DS.RcdNbr
     C                   EVAL      WRK_Seq = R_Seq
     C                   EVAL      WRK_KSeq = F_KSeq
     C                   EVAL      WRK_Hidden = F_Hidden
     C                   EVAL      WRK_Color = F_Color
     C                   EVAL      WRK_MrkCol = F_MarkCol
     C                   EVAL      WRK_MaxSiz = F_MaxSize
     C                   EVAL      WRK_EdtCde = F_EdtCde
      *
     C                   EVAL      W_Format = 'WRK0001'
     C                   EVAL      W_Data = WRK0001
      *
     C                   WRITE     PEEKWRK_      DS_PEEKWRK
     C                   Enddo
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
     C                   OPEN      PEEKFLDL1
     C                   OPEN      PEEKFLD
      *
     C                   EXSR      ClrPeekWrk
     C                   OPEN      PEEKWRK
     C                   OPEN      PEEKWRK_
     C                   EXSR      CopyToWork
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      ##Field = *BLANKS
      *
      * - Rückkehrcode
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Batchverarbeitung
     C                   SELECT
     C     i_function    WHENEQ    '*FLOATKEYS'
     C                   EXSR      C_FloatKey
     C                   EXSR      C_SaveExit
     C                   EVAL      IsBatch = bTrue
     C                   GOTO      Ende
     C                   OTHER
     C                   EVAL      IsBatch = bFalse
     C                   OPEN      PEEK34FM
     C                   Endsl
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
      * - Anzuzeigender Subfilesatz
     C                   EVAL      SFSANR = 1
      *
      * - Subfile füllen
     C                   EXSR      C_Refresh
      *
      * - Copyright
     C                   EVAL      §MsgID = 'USR9999'
     C                   EVAL      §MsgDta = i_copyright
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
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
     C                   Eval      PEEK25_NAME = f_pgmCallN('PEEK25')
     C                   Eval      PEEK35_NAME = f_pgmCallN('PEEK35')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': NbrFKeys
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
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
