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
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XFunction       S             10A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
     D YScnAID         S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *
     D YRcdNbr         S                   INZ(*ZEROS)  LIKE(R§RcdNbr)
     D YBuffer         S           1024A   INZ(*BLANKS)
     D YField          S             10A   INZ(*BLANKS)
      *
     D YDsp80          S              1A   INZ(*BLANKS)
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
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK25          S                   like(r§pgmCallN) inz
     D PEEK35          S                   like(r§pgmCallN) inz
      *
     D R_Field         S                   INZ(*BLANKS) LIKE(##Field)
     D R_Seq           S                   INZ(*ZEROS ) LIKE(F_Seq  )
     D LstField        S                   INZ(*BLANKS) LIKE(##Field)
     D LstNbrRcd       S                   INZ(0) LIKE(SflPage)
      *
     D Wrk_SFSANR      S                   INZ(*ZEROS ) LIKE(SFSANR )
     D X               S                   like(r§int4    ) inz
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
      *---ENTRY-LISTE--------------------------------------*
      *
     C     *ENTRY        PLIST
     C                   PARM                    XDsp80
     C                   PARM                    XCopyRight
     C                   PARM                    XFunction
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
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
      *  Parameterliste für PEEK25
     C     P_Peek25      PLIST
     C                   PARM                    YDsp80
     C                   PARM                    YColorAttr
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
      *
      *----------------------------------------------------*
      *  Parameterliste für PEEK35
     C     P_Peek35      PLIST
     C                   PARM                    YRcdNbr
     C                   PARM                    YBuffer
     C                   PARM                    YField
     C                   PARM                    YMsgID
     C                   PARM                    YMsgDta
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
     C                   Z-ADD     1             SFSANR
     C                   Endif
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Modus: DROP/FOLD
     C                   MOVE      SFLMDE        *IN86
      *
      *  Nachrichten anzeigen
     C                   MOVE      '0'           *IN89
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
     C                   Z-ADD     1             SFBOT
     C                   Endsl
      *
      *  Anzeige der Subfile
     C                   EXFMT     PBCTL
     C                   MOVEL (P) '0'           *IN70
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Aktuelle Satz-Nr.
     C     SFLCSR        IFGT      *ZEROS
     C                   Z-ADD     SFLCSR        SFSANR
     C                   Endif
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   MOVEL (P) §ScnAID       YScnAID
     C                   MOVEL (P) §§PgmName     YPgm
     C                   CALL      PEEK21        P_Peek21
     C     YMsgID        IFNE      *BLANKS
     C                   MOVEL (P) YMsgID        §MsgID
     C                   MOVEL (P) YMsgDta       §MsgDta
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
     C                   MOVEL (P) ##Field       LstField
     C                   MOVEL (P) *BLANKS       ##Field
     C                   Endif
      *
     C     LstField      IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN70
     C                   CLEAR                   USR8209
     C                   MOVEL (P) 'USR8209'     §MsgID
     C                   MOVEL (P) USR8209       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   EXSR      PosToField
     C     IsNewPos      IFEQ      bTrue
     C                   Z-ADD     Wrk_SFSANR    SFSANR
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
 B01  ***  ##Field       IFEQ      R_Field
      ***                MOVEL (P) bFalse        IsNewPos
 X01  ***                ELSE
      *
     C     LstField      IFNE      R_Field
     C                   Eval      LstNbrRcd = 0
     C                   Endif
      *
     C     LstField      IFEQ      *BLANKS
     C                   MOVEL (P) bFalse        IsNewPos
     C                   Eval      LstNbrRcd = 0
     C                   ELSE
      *
     C                   EXSR      SrchField
     C     IsFound       IFEQ      bFalse
     C                   MOVEL (P) bFalse        IsNewPos
     C                   CLEAR                   USR8136
     C                   MOVEL (P) 'USR8136'     §MsgID
     C                   MOVEL (P) LstField      USR81361                       Feldname
     C                   MOVEL (P) USR8136       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   ELSE
     C                   MOVEL (P) bTrue         IsNewPos
     C                   Endif
     C                   Endif
      *
     C                   MOVEL (P) LstField      R_Field
 E01  ***                ENDIF
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
     C                   MOVEL (P) bFalse        IsFound
     C                   ELSE
      *
     C                   MOVEL (P) bFalse        IsFound
     C                   Eval      LstNbrRcd = LstNbrRcd + 1
      *
     C     LstNbrRcd     DO        SflNbrRcd     SflRec
     C     SflRec        CHAIN     PBSFL                              1111
     C     *IN11         IFEQ      '1'
     C                   MOVEL (P) bFalse        IsFound
     C                   LEAVE
     C                   Endif
      *
     C                   IF        LstField =
     C                             %subst($$FNME: 1:(f_scan(' ':
     C                                               LstField) - 1))
     C                   MOVEL (P) bTrue         IsFound
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
     C                   Z-ADD     SflRec        Wrk_SFSANR
     C                   Eval      LstNbrRcd = SflRec
     C                   ELSE
     C                   Z-ADD     *ZEROS        Wrk_SFSANR
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
     C                   MOVEL (P) bFalse        IsSflError
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
     C                   Z-ADD     SflRec        SflCsr
     C                   ELSE
      *  Subfile nicht neu positionieren
     C                   Endif
      *
      *  Linksbündig setzen ...
     C     ' '           CHECK     SFPAU         X
     C     X             IFGE      1
     C                   SUBST (P) SFPAU:X       SFPAU
     C                   Endif
      *
      *  Zuordnung AUSWAHL => Befehl ...
     C     '#'           CAT   (P) SFPAU:0       YScnAID
     C                   MOVEL (P) §§PgmName     YPgm
     C                   CALL      PEEK21        P_Peek21
     C     YMsgID        IFNE      *BLANKS
      *  Fehlermeldung ...
     C                   MOVEL (P) 'USR8110'     §MsgID
     C                   MOVEL (P) SFPAU         §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSfl
     C                   MOVEL (P) bTrue         IsSflError
     C                   ITER
     C                   Endif
      *
      *----------------------------*
      *  Ausführen SFL-Befehl ...  *
      *----------------------------*
     C                   MOVEL (P) YPgmCmd       Sfl_Cmd
      *
     C                   SELECT
     C     Sfl_Cmd       WHENEQ    '*NONE'
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   MOVEL (P) 'USR8110'     §MsgID
     C                   MOVEL (P) YPgmCmd       USR81101
     C                   MOVEL (P) USR8110       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   EXSR      VSfpauErr
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   UPDATE    PBSfl
     C                   MOVEL (P) bTrue         IsSflError
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
     C                   Z-ADD     RecordNbr     YRcdNbr
     C                   MOVEL (P) WRK0001       YBuffer
     C                   CALL      PEEK35        P_Peek35               99
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
     C                   MOVEL (P) '0'           *IN85                          DSPATR(RI)
     C                   MOVEL (P) YMsgID        §MsgID
     C                   MOVEL (P) YMsgDta       §MsgDta
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
     C                   MOVEL (P) bTrue         IsSflError
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
     C                   MOVEL (P) XDsp80        YDsp80
     C                   MOVEL (P) $$Color       YColorAttr
     C                   CALL      PEEK25        P_Peek25               99
      *
     C     *IN99         IFEQ      '1'
      *             Fehler aufgetreten
     C                   ELSE
     C                   MOVEL (P) YColorAttr    $$Color
     C                   Endif
      *
     C                   ELSE
      *  Cursor steht auf falschem Feld ...
     C                   Endif
      *
     C                   MOVEL (P) *BLANKS       ##Color
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
     C                   MOVEL (P) 'USR8100'     XMsgID
     C                   MOVEL (P) YPgmCmd       USR81001
     C                   MOVEL (P) USR8100       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_SaveExit    F3     - Sichern und beenden              *
      *============================================================*
      *
     C     C_SaveExit    BEGSR
      *
     C                   Z-ADD     *ZEROS        R_Seq
      *
     C                   Z-ADD     *ZEROS        W_Key
     C     W0Key         SETLL     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ  (N) FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   ADD       1             R_Seq
      *
     C                   MOVEL (P) W_Data        WRK0001
      *
     C     WRK_RcdNbr    CHAIN     FPEEKFLD                           11
      *
     C                   Z-ADD     R_Seq         F_Seq
     C                   MOVEL (P) WRK_Hidden    F_Hidden
     C                   MOVEL (P) WRK_Color     F_Color
     C                   MOVEL (P) WRK_MrkCol    F_MarkCol
     C                   Z-ADD     WRK_MaxSiz    F_MaxSize
     C                   MOVEL (P) WRK_EdtCde    F_EdtCde
      *
     C                   UPDATE    FPEEKFLD
     C                   Enddo
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
     C                   Z-ADD     *ZEROS        W_Key
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
     C                   Z-ADD     *ZEROS        W_Key
     C     W0Key         SETLL     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READ      FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   MOVEL (P) W_Data        WRK0001
      *
     C     WRK_KSeq      IFEQ      *ZEROS
     C                   MULT      -1            WRK_Seq
     C                   ELSE
     C                   Z-ADD     *ZEROS        WRK_Seq
     C                   Endif
      *
     C                   Z-ADD     WRK_Seq       W_Key
     C                   MOVEL (P) WRK0001       W_Data
     C                   UPDATE    FPEEKWRK
     C                   Enddo
      *
      *  Nun alle negative Folgenummern neu
      *  durchnummerieren ...
     C                   Z-ADD     *ZEROS        R_Seq
      *
     C                   Z-ADD     *HIVAL        W_Key
     C     W0Key         SETGT     FPEEKWRK
      *
     C                   DO        *HIVAL
     C                   READP     FPEEKWRK                               11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   MOVEL (P) W_Data        WRK0001
      *
      *  Schlüsselfelder? ...
     C     WRK_KSeq      IFEQ      *ZEROS
      *  ... nein, kein Schlüselfeld
     C                   ADD       10            R_Seq
     C                   Z-ADD     R_Seq         WRK_Seq
     C                   ELSE
      *  ... ja, Schlüselfeld
     C     WRK_KSeq      MULT      10            WRK_Seq
     C     WRK_Seq       IFGT      R_Seq
     C                   Z-ADD     WRK_Seq       R_Seq
     C                   ELSE
      *    R_Seq stehenlassen ...
     C                   Endif
     C                   Endif
      *
     C                   Z-ADD     WRK_Seq       W_Key
     C                   MOVEL (P) WRK0001       W_Data
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
     C                   Z-ADD     1             SFSANR
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Bot         F18 - Ende der Subfile                    *
      *============================================================*
      *
     C     C_Bot         BEGSR
      *
     C                   Z-ADD     SflNbrRcd     SFSANR
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_MoreKeys    F24 - Weitere Tasten                      *
      *============================================================*
      *
     C     C_MoreKeys    BEGSR
      *
     C                   ADD       1             SFBOT
      *
     C                   ENDSR
      *
      *============================================================*
      *    FillRecord    Füllen Datensatz in PEEKWRK               *
      *============================================================*
      *
     C     FillRecord    BEGSR
      *
     C                   Z-ADD     ##Seq         WRK_Seq
      *
     C                   SELECT
     C     ##Hidden      WHENEQ    bTrue
     C                   MOVEL (P) bFalse        WRK_Hidden
     C     ##Hidden      WHENEQ    bFalse
     C                   MOVEL (P) bTrue         WRK_Hidden
     C                   OTHER
     C                   MOVEL (P) ##Hidden      WRK_Hidden
     C                   Endsl
      *
     C                   MOVEL (P) $$Color       WRK_Color
     C                   MOVEL (P) ##MarkCol     WRK_MrkCol
     C                   Z-ADD     ##MaxSize     WRK_MaxSiz
     C                   MOVEL (P) ##EdtCde      WRK_EdtCde
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
     C                   MOVEA     '0000000000'  *IN(20)                        20-29
      *  DSPATR(RI)
     C                   MOVEA     '0000000000'  *IN(30)                        30-39
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
     C                   MOVEL (P) '1'           *IN20                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN30                          DSPATR(RI)
     C     YField        WHENEQ    'HIDDEN'
     C                   MOVEL (P) '1'           *IN21                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN31                          DSPATR(RI)
     C     YField        WHENEQ    'COLOR'
     C                   MOVEL (P) '1'           *IN22                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN32                          DSPATR(RI)
     C     YField        WHENEQ    'MARKCOL'
     C                   MOVEL (P) '1'           *IN23                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN33                          DSPATR(RI)
     C     YField        WHENEQ    'MAXSIZE'
     C                   MOVEL (P) '1'           *IN24                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN34                          DSPATR(RI)
     C     YField        WHENEQ    'EDTCDE'
     C                   MOVEL (P) '1'           *IN25                          DSPATR(PC)
     C                   MOVEL (P) '1'           *IN35                          DSPATR(RI)
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
     C                   MOVEL (P) W_Data        WRK0001
     C                   EXSR      FillRecord
     C                   Z-ADD     WRK_Seq       W_Key
     C                   MOVEL (P) WRK0001       W_Data
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
     C                   MOVEL (P) *BLANKS       SFPAU
     C                   MOVEL (P) '0'           *IN85                          DSPATR(RI)
     C                   MOVEL (P) '0'           *IN84                          SFLNXTCHG
      *
     C                   ENDSR
      *
      *============================================================*
      *    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
      *============================================================*
      *
     C     VSfpauErr     BEGSR
      *
     C                   MOVEL (P) '1'           *IN85                          DSPATR(RI)
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
     C                   MOVEL (P) '1'           *IN84                          SFLNXTCHG
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
     C                   MOVEL (P) '0'           *IN89
     C                   WRITE     MSGCTL
      *
     C                   MOVEL (P) '0'           *IN80                          SFLDSP
     C                   MOVEL (P) '1'           *IN81                          SFLDSPCTL
     C                   MOVEL (P) '1'           *IN82                          SFLCLR
     C                   MOVEL (P) '1'           *IN83                          SFLEND
     C                   WRITE     PBCTL
      *
     C                   MOVEL (P) '0'           *IN82                          SFLCLR
      *
     C                   Z-ADD     *ZEROS        SFLREC
     C                   Z-ADD     *ZEROS        SflNbrRcd
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
     C                   ADD       1             SflRec
      *  Setzen Bezugszahlen ...
     C                   EXSR      PBSetBZ
     C                   WRITE     PBSfl
     C                   Z-ADD     SflRec        SflNbrRcd
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
     C                   MOVEL (P) F_FFD         FLDL0100
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
     C                   MOVE  (P) F_KSeq        $$KSeq
     C                   MOVEL     'K'           $$KSeq
     C                   ELSE
     C                   MOVEL (P) *BLANKS       $$KSeq
     C                   Endif
      *  ... Sichtbar
     C                   SELECT
     C     WRK_Hidden    WHENEQ    bTrue
     C                   MOVEL (P) bFalse        ##Hidden
     C     WRK_Hidden    WHENEQ    bFalse
     C                   MOVEL (P) bTrue         ##Hidden
     C                   OTHER
     C                   MOVEL (P) WRK_Hidden    ##Hidden
     C                   Endsl
      *  ... Farbe
     C                   MOVEL (P) *BLANKS       ##Color
     C                   MOVEL (P) WRK_Color     $$Color
      *  ... Farbmarkierung
     C                   MOVEL (P) WRK_MrkCol    ##MarkCol
      *  ... Max. Anzeigebreite (Größe)
     C                   Z-ADD     WRK_MaxSiz    ##MaxSize
      *  ... Editcode
     C                   MOVEL (P) WRK_EdtCde    ##EdtCde
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
     C                   MOVEL (P) '1'           *IN80                          SFLDSP
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
     C                   MOVEL (P) '0'           *IN71
     C                   ELSE
     C                   MOVEL (P) '1'           *IN71
     C                   Endif
      *
      *  Dezimalstellen
     C     IsDecimal     IFEQ      bFalse
     C                   MOVEL (P) '0'           *IN72
     C                   ELSE
     C                   MOVEL (P) '1'           *IN72
     C                   Endif
      *
      *  Kennzeichnung für variable Länge
     C                   If        isVarLen = bFalse
     C                   MOVEL (P) '0'           *IN73
     C                   ELSE
     C                   MOVEL (P) '1'           *IN73
     C                   Endif
      *
      *  Unbekannter Feldtyp
     C                   If        isUnKnown = bFalse
     C                   MOVEL (P) '0'           *IN74
     C                   ELSE
     C                   MOVEL (P) '1'           *IN74
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
     C     XDsp80        IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   MOVEL (P) '0'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     2             POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     2             ZEI
     C                   Z-ADD     2             POS
     C                   Endif
      *
     C                   Z-ADD     *HIVAL        SflPage
     C                   Z-ADD     4             SflPageDDS
      *
     C                   ENDSR
      *
      *============================================================*
      *    ClrPeekWrk    Löschen der Datei PEEKWRK                 *
      *============================================================*
      *
     C     ClrPeekWrk    BEGSR
      *
     C                   MOVEL (P) 'PEEKWRK'     §File
     C                   MOVEL (P) 'QTEMP'       §Lib
     C                   MOVEL (P) '*FIRST'      §Mbr
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
     C                   MOVEL (P) *BLANKS       ##Field
      *
      * - Rückkehrcode
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Batchverarbeitung
     C                   SELECT
     C     XFunction     WHENEQ    '*FLOATKEYS'
     C                   EXSR      C_FloatKey
     C                   EXSR      C_SaveExit
     C                   MOVEL (P) bTrue         IsBatch
     C                   GOTO      Ende
     C                   OTHER
     C                   MOVEL (P) bFalse        IsBatch
     C                   OPEN      PEEK34FM
     C                   Endsl
      *
      * - Darstellung der Subfile
     C                   MOVEL (P) '1'           SflMde
      *
      * - Darstellung der Befehlstasten
     C                   Z-ADD     1             SfBot
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Anzuzeigender Subfilesatz
     C                   Z-ADD     1             SFSANR
      *
      * - Subfile füllen
     C                   EXSR      C_Refresh
      *
      * - Copyright
     C                   MOVEL (P) 'USR9999'     §MsgID
     C                   MOVEL (P) XCopyRight    §MsgDta
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
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
     C                   Eval      PEEK25 = f_pgmCallN('PEEK25')
     C                   Eval      PEEK35 = f_pgmCallN('PEEK35')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = NbrFKeys
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) yFKeys        ScrnFKeys
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
