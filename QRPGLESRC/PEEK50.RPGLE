      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.5.0                               *
      *  Programm : PEEK50                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 11.02.1999  Raddatz                               *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Erweiterte PIN-Funktion                           *
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
     FPEEK50FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
      * Feldliste nach Sequenzfolge
     FPEEKFLDL1 IF   E           K DISK    USROPN
     F                                     INFDS(Peek_01_DS)
     F                                     RENAME(FPEEKFLD:FPEEKFLDL1)
     F                                     PREFIX(F_)
      * Feldliste nach Eingangsfolge
     FPEEKFLD   IF   E             DISK    USROPN
     F                                     INFDS(Peek_00_DS)
     F                                     PREFIX(F_)
      * Arbeitsdatei nach Anzeigefolge
     FPEEKWRK   UF   E           K DISK    USROPN
     F                                     INFDS(Work_00_DS)
     F                                     PREFIX(W_)
      * Arbeitsdatei nach Eingangsfolge
     FPEEKWRK_  UF A F 1024        DISK    USROPN
     F                                     INFDS(Work_01_DS)
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
      /COPY QCOPYLE,PPEEK50
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
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8110
      /COPY QCOPYLE,USR8136
      /COPY QCOPYLE,USR8205
      /COPY QCOPYLE,USR8209
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
      *
      /COPY QCOPYLE,F_PEEK53
      /COPY QCOPYLE,F_PEEK58
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek_00_DS       DS                  likeds(infds_t)
     DPeek_01_DS       DS                  likeds(infds_t)
      *
     D DS_PEEKWRK    E DS          1024    EXTNAME(PEEKWRK) INZ
     D                                     PREFIX(W_)
      *
     DWork_00_DS       DS                  likeds(infds_t)
     DWork_01_DS       DS                  likeds(infds_t)
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
      /COPY QCOPYLE,WRK0002
      *----------------------------------------------------*
      *
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(int4_t) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) INZ(*BLANKS)
      *
     D SflPage         S                   like(int4_t) inz
     D SflPageDDS      S                   like(SflPage   ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflNbrRcd       S                   like(SflPage   ) inz
      *
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   CONST(3)
     D Sfl_Cmd         S             10A   INZ(*BLANKS)
      *
     D IsSflError      S              1A   INZ(bFalse)
     D IsNewPos        S              1A   INZ(bFalse)
     D IsFound         S              1A   INZ(bFalse)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
      *
     D R_Field         S                   INZ(*BLANKS) LIKE(##Field)
     D LstField        S                   INZ(*BLANKS) LIKE(##Field)
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
     D X               S                   like(int4_t) inz
     D NbrPinCol       S                   like(int4_t) inz
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK50          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  io_pinTabC                               like(fieldNme_t) dim(12)
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKFLDL1
     C     F1Key         KLIST
     C                   KFLD                    F_Seq
      *
      *----------------------------------------------------*
      *  Schlüsselliste für PEEKWRK
     C     W0KEY         KLIST
     C                   KFLD                    W_Key
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
     C     SFSANR        IFLE      *ZEROS
     C                   EVAL      SFSANR = 1
     C                   Endif
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Warnung, bei mehr als 12 Spalten
     C                   If        (NbrPinCol > %elem(io_pinTabC))
     C                   CLEAR                   USR8205
     C                   EVAL      §MsgID = 'USR8205'
     C                   Eval      USR82051 = %elem(io_pinTabC)
     C                   EVAL      §MsgDta = USR8205
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
     C                   WRITE     PBBOT#0                                      Trennlinie
      *
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
     C                   EXSR      C_SaveExit
     C                   LEAVE
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'
     C                   EXSR      C_Refresh
     C                   ITER
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
      *  F22 - Alle Löschen
     C     YPgmCmd       WHENEQ    '*CLRALL'
     C                   EXSR      C_ClrAll
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'
     C                   EXSR      C_EndPgm
     C                   LEAVE
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
     C                   CLOSE     PEEK50FM
     C                   CLOSE     PEEKFLD
     C                   CLOSE     PEEKFLDL1
     C                   CLOSE     PEEKWRK
     C                   CLOSE     PEEKWRK_
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
     C                                                      LstFIELD) - 1))
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
     C                   EXSR      VPos
     C                   EXSR      VSfpauClr
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
     C                   Clear                   io_pinTabC
     C                   Eval      X = 0
      *
     C                   EVAL      W_Key = *ZEROS
     C     W0Key         Setll     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ  (N) FPEEKWRK                               83
     C     *IN83         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      WRK0002 = W_Data
      *
     C                   If        (x < %elem(io_pinTabC)) and
     C                             (Wrk_Seq <> 0)
     C                   Eval      X = X + 1
     C                   Eval      io_pinTabC(x) = Wrk_FNme
     C                   Endif
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
      *    C_ClrAll      F22 - Löschen alle Einträge               *
      *                        der Pintabelle                      *
      *============================================================*
      *
     C     C_ClrAll      BEGSR
      *
     C                   EVAL      W_Key = *ZEROS
     C     W0Key         Setll     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKWRK                               83
     C     *IN83         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      WRK0002 = W_Data
      *
     C                   Eval      ##Seq = 0
     C                   Exsr      FillRecord
     C                   Exsr      FillKey
      *
     C                   EVAL      W_Data = WRK0002
     C                   Update    FPEEKWRK
     C                   Enddo
      *
     C                   Exsr      C_Refresh
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
     C                   If        (##Seq   <> 0) and
     C                             (WRK_Seq  = 0)
     C                   Eval      NbrPinCol = NbrPinCol + 1
     C                   Endif
      *
     C                   If        (##Seq    = 0) and
     C                             (WRK_Seq <> 0)
     C                   Eval      NbrPinCol = NbrPinCol - 1
     C                   Endif
      *
     C                   EVAL      WRK_Seq = ##Seq
      *
     C                   ENDSR
      *
      *============================================================*
      *    FillKey       Füllen Schlüsselfelder in PEEKWRK         *
      *============================================================*
      *
     C     FillKey       BEGSR
      *
     C                   If        WRK_Seq = 0
     C                   EVAL      W_Key = *HIVAL
     C                   Else
     C                   EVAL      W_Key = WRK_Seq
     C                   Endif
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
      *    VPos          Verarbeiten der Eingaben                  *
      *============================================================*
      *
     C     VPos          BEGSR
      *
     C     RecordNbr     CHAIN     PEEKWRK_      DS_PEEKWRK           11
     C     *IN11         IFEQ      '1'
      *  Weiß noch nicht, was zu tun ist ...
     C                   ELSE
     C                   EVAL      WRK0002 = W_Data
     C                   EXSR      FillRecord
     C                   EXSR      FillKey
     C                   EVAL      W_Data = WRK0002
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
     C                   EVAL      WRK0002 = W_Data
      *
     C     WRK_RcdNbr    CHAIN     FPEEKFLD                           11
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  ... Folgenummer
     C                   EVAL      ##Seq = Wrk_Seq
      *  ... Feldname
     C                   EVAL      $$FNme = Wrk_FNme
      *  ... Feldbezeichnung
     C                   EVAL      $$FTxt = Wrk_FTxt
      *  ... Keyfeldnummer
     C     F_KSeq        IFNE      *ZEROS
     C                   EVAL      $$KSeq = 'K'+%editc(%dec(F_KSeq: 3: 0): 'X')
     C                   ELSE
     C                   EVAL      $$KSeq = ''
     C                   Endif
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
     C                   EVAL      §File = WORK_FILE_NAME
     C                   EVAL      §Lib = WORK_FILE_LIBRARY
     C                   EVAL      §Mbr = WORK_FILE_MEMBER
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
     C                   Eval      NbrPinCol = 0
      *
     C                   EVAL      F_Seq = *ZEROS
     C     F1Key         SETLL     FPEEKFLDL1
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKFLDL1                             11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   CLEAR                   WRK0002
     C                   CLEAR                   DS_PEEKWRK
      *
     C                   EVAL      FLDL0100 = F_FFD
      *
      *  ... Folgenummer
     C                   Eval      x = %lookup(FLDL0100.F1FNME: io_pinTabC: 1)
     C**                 Eval      X = 1
     C**   fieldName     LOOKUP    XPinTabC(X)                            99
     C**   *IN99         IFEQ      '1'
     C                   If        (x > 0)
      *  ... gefunden
     C                   Eval      ##Seq   = x * 10
     C                   Eval      W_Key   = x * 10
     C                   ELSE
      *  ... nicht gefunden
     C                   Eval      ##Seq   = 0
     C                   Eval      W_Key   = *HIVAL
     C                   Endif
      *
     C                   Exsr      FillRecord
      *
      *  ... sonstige Felder
     C                   EVAL      WRK_RcdNbr = Peek_01_DS.RcdNbr
     C                   EVAL      WRK_FNme = FLDL0100.F1FNme
     C                   EVAL      WRK_FTxt = FLDL0100.F1FTxt
      *
     C                   EVAL      W_Format = 'WRK0002'
     C                   EVAL      W_Data = WRK0002
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
     C                   OPEN      PEEKFLD
     C                   OPEN      PEEKFLDL1
      *
     C                   EXSR      ClrPeekWrk
     C                   OPEN      PEEKWRK
     C                   OPEN      PEEKWRK_
     C                   EXSR      CopyToWork
      *
     C                   OPEN      PEEK50FM
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
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': NbrFKeys
     C                                    : yFKeys: yNbrOfKeys)
     C                   Eval      ScrnFKeys = %subarr(YFKeys: 1)
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
