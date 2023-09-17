      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK24                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 31.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Änderung der Farbeinstellung                                 *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK24FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Farbattribute------------------------------------*
      /COPY QCOPYLE,D_COLORATR
      *----------------------------------------------------*
      *
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0000
      /COPY QCOPYLE,SET0001
      *----------------------------------------------------*
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
      /COPY QCOPYLE,USR8100
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
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XSet0001        S                   LIKE(SET0001)
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D YDsp80          S              1A   INZ(*BLANKS)
     D YColorAttr      S              1A   INZ(*BLANKS)
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
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(r§int4    ) inz
     D §NbrFKeys       C                   CONST(2)
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D Wrk_Field       S             10A   INZ(*BLANKS)
     D Wrk_Color       S             10A   INZ(*BLANKS)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
     D PEEK25          S                   like(r§pgmCallN) inz
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
     C                   PARM                    XDsp80
     C                   PARM                    XCopyRight
     C                   PARM                    XSet0001
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
      *---------------------------------------------------*
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Nachrichten senden
     C                   Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
      *
      *  Nachrichten anzeigen
     C                   MOVE      '0'           *IN89
     C                   WRITE     MSGCTL
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
     C                   Z-ADD     1             SFBOT
     C                   Endsl
      *
      *  Anzeigen Bildschirm
     C                   EXFMT     BILD01
      *
      *  Berechnen Zeile/Spalte
     C     §ScnCsrPos    DIV       256           §ScnCsrRow
     C                   MVR                     §ScnCsrCol
      *
      *  Beibehalten der Cursorosition
     C     §ScnCsrRow    SUB       ZEI           CsrRow
     C     §ScnCsrCol    SUB       POS           CsrCol
     C                   SUB       1             CsrCol
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   EXSR      BZOFF1
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
      *  F3  - Ende & Speichern
     C     YPgmCmd       WHENEQ    '*SAVE_EXIT'                                 ENDE
     C                   EXSR      C_Exit
     C                   LEAVE
      *
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'                                      ZURÜCK
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F5  - Aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'                                   AKTUALISIEREN
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F12 - Ende
     C     YPgmCmd       WHENEQ    '*CANCEL'                                    ZURÜCK
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'                                  ZURÜCK
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
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
      * - Dateien schließen
     C                   CLOSE     PEEK24FM
      *
     C                   RETURN
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      PRFB1
     C     *IN99         IFEQ      '0'
     C                   EXSR      GetColor
     C                   ELSE
      *          Fehlernachricht ausgeben
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     BZOFF1        BEGSR
      *
      *  Fehler
     C                   MOVEL (P) '0'           *IN99
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRFB1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     PRFB1         BEGSR
      *
     C                   EXSR      PRF20                                       Feldauswahl
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF20         Prüfen:  Feldauswahl                      *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     6             SUBST (P) SCNFLD:3      Wrk_Field
      *
     C                   SELECT
     C     Wrk_Field     WHENEQ    'KEYCOL'                                     Überschrift
     C                   MOVEL (P) SET_KeyCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'HEDCOL'                                     Überschrift
     C                   MOVEL (P) SET_HedCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'PINCOL'                                     Pined-Daten
     C                   MOVEL (P) SET_PinCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'CLMCOL'                                     SpaltenMark
     C                   MOVEL (P) SET_ClmCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'STDCOL'                                     Standard
     C                   MOVEL (P) SET_StdCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'NMLCOL'                                     Normale Suche
     C                   MOVEL (P) SET_NmlCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'UNDCOL'                                     Unterstrichen
     C                   MOVEL (P) SET_UndCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'REVCOL'                                     Reverse Suche
     C                   MOVEL (P) SET_RevCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'TBLCOL'                                     Tabellierpap.
     C                   MOVEL (P) SET_TblCol    Wrk_Color
     C     Wrk_Field     WHENEQ    'EXCCOL'                                     Exception
     C                   MOVEL (P) SET_ExcCol    Wrk_Color
     C                   OTHER
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8146'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C     EPRF20        TAG
      *
     C     *IN99         IFEQ      '1'
      *               ??????????
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Exit        F3     - Speichern und beenden            *
      *============================================================*
      *
     C     C_Exit        BEGSR
      *
     C                   EXSR      SetUsrSetg
      *
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_EndPgm      F12    - Programm beenden                 *
      *============================================================*
      *
     C     C_EndPgm      BEGSR
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) 'USR8100'     XMsgID
      *
     C                   SELECT
     C     §ScnAID       WHENEQ    §F3
     C                   MOVEL (P) 'F3'          USR81001
     C     §ScnAID       WHENEQ    §F12
     C                   MOVEL (P) 'F12'         USR81001
     C                   OTHER
     C                   MOVEL (P) 'Fxx'         USR81001
     C                   Endsl
      *
     C                   MOVEL (P) USR8100       XMsgDta
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C                   EXSR      FILL##
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
      *    FILL##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     FILL##        BEGSR
      *
      *  SET_KeyCol
     C                   MOVEL (P) SET_KeyCol    $$KEYCOL
     C                   CAT       'KeyField':0  $$KEYCOL
      *
      *  SET_HedCol
     C                   MOVEL (P) SET_HedCol    $$HEDCOL
     C                   CAT       'Headline':0  $$HEDCOL
      *
      *  SET_PinCol
     C                   MOVEL (P) SET_PinCol    $$PINCOL1
     C                   MOVEL (P) $$PINCOL1     $$PINCOL2
     C                   CAT       'Pin-Record':0$$PINCOL1
      *
     C     ' ':'x'       XLATE     $$PINCOL2     $$PINCOL2
     C                   MOVEL (P) $$PINCOL2     $$PINCOL3
     C                   MOVEL (P) $$PINCOL2     $$PINCOL4
      *
      *  SET_StdCol
     C                   MOVEL (P) SET_StdCol    $$STDCOL1
     C                   MOVEL (P) $$STDCOL1     $$STDCOL2
     C                   CAT       'Std.Color':0 $$STDCOL1
      *
     C     ' ':'x'       XLATE     $$STDCOL2     $$STDCOL2
     C                   MOVEL (P) $$STDCOL2     $$STDCOL3
     C                   MOVEL (P) $$STDCOL2     $$STDCOL4
     C                   MOVEL (P) $$STDCOL2     $$STDCOL5
     C                   MOVEL (P) $$STDCOL2     $$STDCOL6
      *
      *  SET_ClmCol
     C                   MOVEL (P) SET_ClmCol    $$CLMCOL1
     C                   MOVEL (P) $$CLMCOL1     $$CLMCOL2
     C                   CAT       'Mark Clm':0  $$CLMCOL1
      *
     C     ' ':'x'       XLATE     $$CLMCOL2     $$CLMCOL2
     C                   MOVEL (P) $$CLMCOL2     $$CLMCOL3
     C                   MOVEL (P) $$CLMCOL2     $$CLMCOL4
     C                   MOVEL (P) $$CLMCOL2     $$CLMCOL5
     C                   MOVEL (P) $$CLMCOL2     $$CLMCOL6
     C                   MOVEL (P) $$CLMCOL2     $$CLMCOL7
      *
      *  SET_NmlCol
     C                   MOVEL (P) SET_NmlCol    $$NmlCOL1
     C                   MOVEL (P) $$NmlCOL1     $$NmlCOL2
     C                   CAT       'Search':0    $$NmlCOL1
      *
     C     ' ':'x'       XLATE     $$NmlCOL2     $$NmlCOL2
     C                   MOVEL (P) $$NmlCOL2     $$NMLCOL3
     C                   MOVEL (P) $$NmlCOL2     $$NmlCOL4
      *
      *  SET_UndCol
     C                   MOVEL (P) SET_UndCol    $$UNDCOL1
     C                   MOVEL (P) $$UNDCOL1     $$UNDCOL2
     C                   CAT       'Search-Und':0$$UNDCOL1
      *
     C     ' ':'x'       XLATE     $$UNDCOL2     $$UNDCOL2
     C                   MOVEL (P) $$UNDCOL2     $$UNDCOL3
     C                   MOVEL (P) $$UNDCOL2     $$UNDCOL4
      *
      *  SET_RevCol
     C                   MOVEL (P) SET_RevCol    $$REVCOL1
     C                   MOVEL (P) $$REVCOL1     $$REVCOL2
     C                   CAT       'Search-Rev':0$$REVCOL1
      *
     C     ' ':'x'       XLATE     $$REVCOL2     $$REVCOL2
     C                   MOVEL (P) $$REVCOL2     $$REVCOL3
     C                   MOVEL (P) $$REVCOL2     $$REVCOL4
      *
      *  SET_TblCol
     C                   MOVEL (P) SET_TblCol    $$TBLCOL1
     C                   MOVEL (P) $$TBLCOL1     $$TBLCOL2
     C                   CAT       'Tabulated':0 $$TBLCOL1
      *
     C     ' ':'x'       XLATE     $$TBLCOL2     $$TBLCOL2
     C                   MOVEL (P) $$TBLCOL2     $$TBLCOL3
     C                   MOVEL (P) $$TBLCOL2     $$TBLCOL4
      *
      *  SET_ExcCol
     C                   MOVEL (P) SET_ExcCol    $$EXCCOL1
     C                   MOVEL (P) $$EXCCOL1     $$EXCCOL2
     C                   CAT       'Exception':0 $$EXCCOL1
      *
     C     ' ':'x'       XLATE     $$EXCCOL2     $$EXCCOL2
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
     C                   Z-ADD     6             ZEI
     C                   Z-ADD     26            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     4             ZEI
     C                   Z-ADD     7             POS
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     GetUsrSetg    BEGSR
      *
     C                   MOVEL (P) XSet0001      SET0001
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
     C                   MOVEL (P) SET0001       XSet0001
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetColor      Auswählen neue Farbe                      *
      *============================================================*
      *
     C     GetColor      BEGSR
      *
     C                   MOVEL (P) XDsp80        YDsp80
     C                   MOVEL (P) Wrk_Color     YColorAttr
     C                   CALL      PEEK25        P_Peek25               99
      *
     C     *IN99         IFEQ      '1'
      *             Fehler aufgetreten
     C                   ELSE
      *
     C                   SELECT
     C     Wrk_Field     WHENEQ    'KEYCOL'                                     Überschrift
     C                   MOVEL (P) YColorAttr    SET_KeyCol
     C     Wrk_Field     WHENEQ    'HEDCOL'                                     Überschrift
     C                   MOVEL (P) YColorAttr    SET_HedCol
     C     Wrk_Field     WHENEQ    'PINCOL'                                     Pined-Daten
     C                   MOVEL (P) YColorAttr    SET_PinCol
     C     Wrk_Field     WHENEQ    'CLMCOL'                                     Spaltenmark.
     C                   MOVEL (P) YcolorAttr    SET_ClmCol
     C     Wrk_Field     WHENEQ    'STDCOL'                                     Standard
     C                   MOVEL (P) YColorAttr    SET_StdCol
     C     Wrk_Field     WHENEQ    'NMLCOL'                                     Normale Suche
     C                   MOVEL (P) YColorAttr    SET_NmlCol
     C     Wrk_Field     WHENEQ    'UNDCOL'                                     Unterstrichen
     C                   MOVEL (P) YColorAttr    SET_UndCol
     C     Wrk_Field     WHENEQ    'REVCOL'                                     Reverse Suche
     C                   MOVEL (P) YColorAttr    SET_RevCol
     C     Wrk_Field     WHENEQ    'TBLCOL'                                     Tabellierpap.
     C                   MOVEL (P) YColorAttr    SET_TblCol
     C     Wrk_Field     WHENEQ    'EXCCOL'                                     Exception
     C                   MOVEL (P) YColorAttr    SET_ExcCol
     C                   OTHER
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8146'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endsl
      *
     C                   EXSR      Fill##
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
      * - Dateien öffnen
     C                   OPEN      PEEK24FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Bildschirmfelder füllen
     C                   EXSR      FILL##
      *
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      *  Löschen der Cursorosition
     C                   Z-ADD     *ZEROS        CsrRow
     C                   Z-ADD     *ZEROS        CsrCol
      *
      * - Einstellen Darstellung der Funktionstasten
     C                   Z-ADD     1             SfBot
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
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
      *
     C                   Eval      yPgm     = §§PgmName
     C                   Eval      yKey     = '*ALL'
      ***                Eval      yPosF24  = §NbrFKeys
     C                   Eval      yPosF24  = *ZEROS
     C                   Call      PEEK23        P_Peek23
     C                   Movea (P) YFKeys        ScrnFKeys
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
      *---Nachrichten--------------------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
