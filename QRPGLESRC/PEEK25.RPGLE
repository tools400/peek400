      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK25                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 31.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Auswahl einer Farbe                                          *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK25FM  CF   E             WORKSTN USROPN
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
     D XColorAttr      S              1A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D yPgm            S             10A                 inz
     D yKey            S             10A                 inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A                 INZ(*BLANKS)
     D yMsgDta         S            512A                 INZ(*BLANKS)
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
     D NbrFKeys        C                   CONST(2)
      *
     D Wrk_Field       S             10A
      *
     D Char            C                   CONST('x')
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
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
     C                   PARM                    XColorAttr
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
      *  F3  - Ende
     C     YPgmCmd       WHENEQ    '*EXIT'                                      ENDE
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
     C     *IN99         IFEQ      '0'
     C                   LEAVE
     C                   Endif
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
      * - Schließen der Dateien
     C                   CLOSE     PEEK25FM
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
     C     SCNFLD        IFNE      *BLANKS
     C                   EXSR      ExtrColor
     C                   ELSE
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8147'     §MsgID
     C                   MOVEL (P) *BLANKS       §MsgDta
     C                   Endif
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
     C                   EXSR      PosCsr
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
     C                   MOVEL (P) §Green        $Green
     C     ' ':Char      XLATE     $Green        $Green
     C                   MOVEL (P) §Green_R      $Green_R
     C     ' ':Char      XLATE     $Green_R      $Green_R
     C                   MOVEL (P) §Green_U      $Green_U
     C     ' ':Char      XLATE     $Green_U      $Green_U
     C                   MOVEL (P) §Green_RU     $Green_RU
     C     ' ':Char      XLATE     $Green_RU     $Green_RU
      *
     C                   MOVEL (P) §White        $White
     C     ' ':Char      XLATE     $White        $White
     C                   MOVEL (P) §White_R      $White_R
     C     ' ':Char      XLATE     $White_R      $White_R
     C                   MOVEL (P) §White_U      $White_U
     C     ' ':Char      XLATE     $White_U      $White_U
      *
     C                   MOVEL (P) §Red          $Red
     C     ' ':Char      XLATE     $Red          $Red
     C                   MOVEL (P) §Red_R        $Red_R
     C     ' ':Char      XLATE     $Red_R        $Red_R
     C                   MOVEL (P) §Red_U        $Red_U
     C     ' ':Char      XLATE     $Red_U        $Red_U
     C                   MOVEL (P) §Red_RU       $Red_RU
     C     ' ':Char      XLATE     $Red_RU       $Red_RU
     C                   MOVEL (P) §Red_B        $Red_B
     C     ' ':Char      XLATE     $Red_B        $Red_B
     C                   MOVEL (P) §Red_RB       $Red_RB
     C     ' ':Char      XLATE     $Red_RB       $Red_RB
     C                   MOVEL (P) §Red_UB       $Red_UB
     C     ' ':Char      XLATE     $Red_UB       $Red_UB
      *
     C                   MOVEL (P) §Turkis       $Turkis
     C     ' ':Char      XLATE     $Turkis       $Turkis
     C                   MOVEL (P) §Turkis_R     $Turkis_R
     C     ' ':Char      XLATE     $Turkis_R     $Turkis_R
     C                   MOVEL (P) §Turkis_U     $Turkis_U
     C     ' ':Char      XLATE     $Turkis_U     $Turkis_U
     C                   MOVEL (P) §Turkis_RU    $Turkis_RU
     C     ' ':Char      XLATE     $Turkis_RU    $Turkis_RU
      *
     C                   MOVEL (P) §Yellow       $Yellow
     C     ' ':Char      XLATE     $Yellow       $Yellow
     C                   MOVEL (P) §Yellow_R     $Yellow_R
     C     ' ':Char      XLATE     $Yellow_R     $Yellow_R
     C                   MOVEL (P) §Yellow_U     $Yellow_U
     C     ' ':Char      XLATE     $Yellow_U     $Yellow_U
      *
     C                   MOVEL (P) §Pink         $Pink
     C     ' ':Char      XLATE     $Pink         $Pink
     C                   MOVEL (P) §Pink_R       $Pink_R
     C     ' ':Char      XLATE     $Pink_R       $Pink_R
     C                   MOVEL (P) §Pink_U       $Pink_U
     C     ' ':Char      XLATE     $Pink_U       $Pink_U
     C                   MOVEL (P) §Pink_RU      $Pink_RU
     C     ' ':Char      XLATE     $Pink_RU      $Pink_RU
      *
     C                   MOVEL (P) §Blue         $Blue
     C     ' ':Char      XLATE     $Blue         $Blue
     C                   MOVEL (P) §Blue_R       $Blue_R
     C     ' ':Char      XLATE     $Blue_R       $Blue_R
     C                   MOVEL (P) §Blue_U       $Blue_U
     C     ' ':Char      XLATE     $Blue_U       $Blue_U
      *
     C                   ENDSR
      *
      *============================================================*
      *    PosCsr        Positionieren Cursor auf aktuelle Farbe   *
      *============================================================*
      *
     C     PosCsr        BEGSR
      *
     C                   MOVEA     '0000000000'  *IN(10)                       - Green
     C                   MOVEA     '0000000000'  *IN(20)                       - White
     C                   MOVEA     '0000000000'  *IN(30)                       - Red
     C                   MOVEA     '0000000000'  *IN(40)                       - Türkis
     C                   MOVEA     '0000000000'  *IN(50)                       - Yellow
     C                   MOVEA     '0000000000'  *IN(60)                       - Pink
     C                   MOVEA     '0000000000'  *IN(70)                       - Blue
      *
      * Green
     C                   SELECT
     C     XColorAttr    WHENEQ    §Green
     C                   MOVEL (P) '1'           *IN10
     C     XColorAttr    WHENEQ    §Green_R
     C                   MOVEL (P) '1'           *IN11
     C     XColorAttr    WHENEQ    §Green_U
     C                   MOVEL (P) '1'           *IN12
     C     XColorAttr    WHENEQ    §Green_RU
     C                   MOVEL (P) '1'           *IN13
      * White
     C     XColorAttr    WHENEQ    §White
     C                   MOVEL (P) '1'           *IN20
     C     XColorAttr    WHENEQ    §White_R
     C                   MOVEL (P) '1'           *IN21
     C     XColorAttr    WHENEQ    §White_U
     C                   MOVEL (P) '1'           *IN22
      * Red
     C     XColorAttr    WHENEQ    §Red
     C                   MOVEL (P) '1'           *IN30
     C     XColorAttr    WHENEQ    §Red_R
     C                   MOVEL (P) '1'           *IN31
     C     XColorAttr    WHENEQ    §Red_U
     C                   MOVEL (P) '1'           *IN32
     C     XColorAttr    WHENEQ    §Red_RU
     C                   MOVEL (P) '1'           *IN33
     C     XColorAttr    WHENEQ    §Red_B
     C                   MOVEL (P) '1'           *IN34
     C     XColorAttr    WHENEQ    §Red_RB
     C                   MOVEL (P) '1'           *IN35
     C     XColorAttr    WHENEQ    §Red_UB
     C                   MOVEL (P) '1'           *IN36
      * Türkis
     C     XColorAttr    WHENEQ    §Turkis
     C                   MOVEL (P) '1'           *IN40
     C     XColorAttr    WHENEQ    §Turkis_R
     C                   MOVEL (P) '1'           *IN41
     C     XColorAttr    WHENEQ    §Turkis_U
     C                   MOVEL (P) '1'           *IN42
     C     XColorAttr    WHENEQ    §Turkis_RU
     C                   MOVEL (P) '1'           *IN43
      * Yellow
     C     XColorAttr    WHENEQ    §Yellow
     C                   MOVEL (P) '1'           *IN50
     C     XColorAttr    WHENEQ    §Yellow_R
     C                   MOVEL (P) '1'           *IN51
     C     XColorAttr    WHENEQ    §Yellow_U
     C                   MOVEL (P) '1'           *IN52
      * Pink
     C     XColorAttr    WHENEQ    §Pink
     C                   MOVEL (P) '1'           *IN60
     C     XColorAttr    WHENEQ    §Pink_R
     C                   MOVEL (P) '1'           *IN61
     C     XColorAttr    WHENEQ    §Pink_U
     C                   MOVEL (P) '1'           *IN62
     C     XColorAttr    WHENEQ    §Pink_RU
     C                   MOVEL (P) '1'           *IN63
      * Blue
     C     XColorAttr    WHENEQ    §Blue
     C                   MOVEL (P) '1'           *IN70
     C     XColorAttr    WHENEQ    §Blue_R
     C                   MOVEL (P) '1'           *IN71
     C     XColorAttr    WHENEQ    §Blue_U
     C                   MOVEL (P) '1'           *IN72
      *
     C                   OTHER
     C                   EXSR      *PSSR
     C                   Endsl
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
     C                   Z-ADD     8             ZEI
     C                   Z-ADD     41            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     6             ZEI
     C                   Z-ADD     22            POS
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    ExtrColor     Extrahieren Farbattribut                  *
      *============================================================*
      *
     C     ExtrColor     BEGSR
      *
     C                   SELECT
      *  Green
     C     ScnFld        WHENEQ    '$GREEN'
     C                   MOVEL (P) $GREEN        Wrk_Field
     C     ScnFld        WHENEQ    '$GREEN_R'
     C                   MOVEL (P) $GREEN_R      Wrk_Field
     C     ScnFld        WHENEQ    '$GREEN_U'
     C                   MOVEL (P) $GREEN_U      Wrk_Field
     C     ScnFld        WHENEQ    '$GREEN_RU'
     C                   MOVEL (P) $GREEN_RU     Wrk_Field
      *  White
     C     ScnFld        WHENEQ    '$WHITE'
     C                   MOVEL (P) $WHITE        Wrk_Field
     C     ScnFld        WHENEQ    '$WHITE_R'
     C                   MOVEL (P) $WHITE_R      Wrk_Field
     C     ScnFld        WHENEQ    '$WHITE_U'
     C                   MOVEL (P) $WHITE_U      Wrk_Field
      *  Red
     C     ScnFld        WHENEQ    '$RED'
     C                   MOVEL (P) $RED          Wrk_Field
     C     ScnFld        WHENEQ    '$RED_R'
     C                   MOVEL (P) $RED_R        Wrk_Field
     C     ScnFld        WHENEQ    '$RED_U'
     C                   MOVEL (P) $RED_U        Wrk_Field
     C     ScnFld        WHENEQ    '$RED_RU'
     C                   MOVEL (P) $RED_RU       Wrk_Field
     C     ScnFld        WHENEQ    '$RED_B'
     C                   MOVEL (P) $RED_B        Wrk_Field
     C     ScnFld        WHENEQ    '$RED_RB'
     C                   MOVEL (P) $RED_RB       Wrk_Field
     C     ScnFld        WHENEQ    '$RED_UB'
     C                   MOVEL (P) $RED_UB       Wrk_Field
      *  Turquoise
     C     ScnFld        WHENEQ    '$TURKIS'
     C                   MOVEL (P) $TURKIS       Wrk_Field
     C     ScnFld        WHENEQ    '$TURKIS_R'
     C                   MOVEL (P) $TURKIS_R     Wrk_Field
     C     ScnFld        WHENEQ    '$TURKIS_U'
     C                   MOVEL (P) $TURKIS_U     Wrk_Field
     C     ScnFld        WHENEQ    '$TURKIS_RU'
     C                   MOVEL (P) $TURKIS_RU    Wrk_Field
      *  Yellow
     C     ScnFld        WHENEQ    '$YELLOW'
     C                   MOVEL (P) $YELLOW       Wrk_Field
     C     ScnFld        WHENEQ    '$YELLOW_R'
     C                   MOVEL (P) $YELLOW_R     Wrk_Field
     C     ScnFld        WHENEQ    '$YELLOW_U'
     C                   MOVEL (P) $YELLOW_U     Wrk_Field
      *  Pink
     C     ScnFld        WHENEQ    '$PINK'
     C                   MOVEL (P) $PINK         Wrk_Field
     C     ScnFld        WHENEQ    '$PINK_R'
     C                   MOVEL (P) $PINK_R       Wrk_Field
     C     ScnFld        WHENEQ    '$PINK_U'
     C                   MOVEL (P) $PINK_U       Wrk_Field
     C     ScnFld        WHENEQ    '$PINK_RU'
     C                   MOVEL (P) $PINK_RU      Wrk_Field
      *  Blue
     C     ScnFld        WHENEQ    '$BLUE'
     C                   MOVEL (P) $BLUE         Wrk_Field
     C     ScnFld        WHENEQ    '$BLUE_R'
     C                   MOVEL (P) $BLUE_R       Wrk_Field
     C     ScnFld        WHENEQ    '$BLUE_U'
     C                   MOVEL (P) $BLUE_U       Wrk_Field
      *
     C                   OTHER
     C                   MOVEL (P) *BLANKS       Wrk_Field
     C                   Endsl
      *
     C     Wrk_Field     IFNE      *BLANKS
     C     1             SUBST (P) Wrk_Field:1   XColorAttr
     C                   ELSE
      *                ????????
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
      * - Öffnen der Dateien
     C                   OPEN      PEEK25FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      * - Bildschirmfelder füllen
     C                   EXSR      FILL##
     C                   EXSR      PosCsr
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
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
      ***                Eval      yPosF24 = NbrFKeys
     C                   Eval      yPosF24 = *ZEROS
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
      *---Nachrichten--------------------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
