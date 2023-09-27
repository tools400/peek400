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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK25
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
     D PEEK21_NAME     S                   like(r§pgmCallN) inz
     D PEEK23_NAME     S                   like(r§pgmCallN) inz
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
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
     D PEEK25          PI
     D  i_dsp80                            const like(r§dsp80)
     D  o_colorAttr                   1A
     D  o_msgID                                  like(r§msgID)
     D  o_msgDta                                 like(r§msgDta)
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
     C                   EVAL      *IN89 = '0'
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
     C                   EVAL      SFBOT = 1
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
     C                   EVAL      CsrRow = §ScnCsrRow - ZEI
     C                   EVAL      CsrCol = §ScnCsrCol - POS
     C                   EVAL      CsrCol = CsrCol - 1
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   EXSR      BZOFF1
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
     C                   EVAL      *IN99 = '0'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8147'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   EVAL      o_msgID = 'USR8100'
      *
     C                   SELECT
     C     §ScnAID       WHENEQ    §F3
     C                   EVAL      USR81001 = 'F3'
     C     §ScnAID       WHENEQ    §F12
     C                   EVAL      USR81001 = 'F12'
     C                   OTHER
     C                   EVAL      USR81001 = 'Fxx'
     C                   Endsl
      *
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
     C                   EVAL      SFBOT = SFBOT + 1
      *
     C                   ENDSR
      *
      *============================================================*
      *    FILL##        Füllen Bildschirm                         *
      *============================================================*
      *
     C     FILL##        BEGSR
      *
     C                   EVAL      $Green = §Green
     C                   EVAL      $Green = %xlate(' ': Char: $Green)
     C                   EVAL      $Green_R = §Green_R
     C                   EVAL      $Green_R = %xlate(' ': Char: $Green_R)
     C                   EVAL      $Green_U = §Green_U
     C                   EVAL      $Green_U = %xlate(' ': Char: $Green_U)
     C                   EVAL      $Green_RU = §Green_RU
     C                   EVAL      $Green_RU = %xlate(' ': Char: $Green_RU)
      *
     C                   EVAL      $White = §White
     C                   EVAL      $White = %xlate(' ': Char: $White)
     C                   EVAL      $White_R = §White_R
     C                   EVAL      $White_R = %xlate(' ': Char: $White_R)
     C                   EVAL      $White_U = §White_U
     C                   EVAL      $White_U = %xlate(' ': Char: $White_U)
      *
     C                   EVAL      $Red = §Red
     C                   EVAL      $Red = %xlate(' ': Char: $Red)
     C                   EVAL      $Red_R = §Red_R
     C                   EVAL      $Red_R = %xlate(' ': Char: $Red_R)
     C                   EVAL      $Red_U = §Red_U
     C                   EVAL      $Red_U = %xlate(' ': Char: $Red_U)
     C                   EVAL      $Red_RU = §Red_RU
     C                   EVAL      $Red_RU = %xlate(' ': Char: $Red_RU)
     C                   EVAL      $Red_B = §Red_B
     C                   EVAL      $Red_B = %xlate(' ': Char: $Red_B)
     C                   EVAL      $Red_RB = §Red_RB
     C                   EVAL      $Red_RB = %xlate(' ': Char: $Red_RB)
     C                   EVAL      $Red_UB = §Red_UB
     C                   EVAL      $Red_UB = %xlate(' ': Char: $Red_UB)
      *
     C                   EVAL      $Turkis = §Turkis
     C                   EVAL      $Turkis = %xlate(' ': Char: $Turkis)
     C                   EVAL      $Turkis_R = §Turkis_R
     C                   EVAL      $Turkis_R = %xlate(' ': Char: $Turkis_R)
     C                   EVAL      $Turkis_U = §Turkis_U
     C                   EVAL      $Turkis_U = %xlate(' ': Char: $Turkis_U)
     C                   EVAL      $Turkis_RU = §Turkis_RU
     C                   EVAL      $Turkis_RU = %xlate(' ': Char: $Turkis_RU)
      *
     C                   EVAL      $Yellow = §Yellow
     C                   EVAL      $Yellow = %xlate(' ': Char: $Yellow)
     C                   EVAL      $Yellow_R = §Yellow_R
     C                   EVAL      $Yellow_R = %xlate(' ': Char: $Yellow_R)
     C                   EVAL      $Yellow_U = §Yellow_U
     C                   EVAL      $Yellow_U = %xlate(' ': Char: $Yellow_U)
      *
     C                   EVAL      $Pink = §Pink
     C                   EVAL      $Pink = %xlate(' ': Char: $Pink)
     C                   EVAL      $Pink_R = §Pink_R
     C                   EVAL      $Pink_R = %xlate(' ': Char: $Pink_R)
     C                   EVAL      $Pink_U = §Pink_U
     C                   EVAL      $Pink_U = %xlate(' ': Char: $Pink_U)
     C                   EVAL      $Pink_RU = §Pink_RU
     C                   EVAL      $Pink_RU = %xlate(' ': Char: $Pink_RU)
      *
     C                   EVAL      $Blue = §Blue
     C                   EVAL      $Blue = %xlate(' ': Char: $Blue)
     C                   EVAL      $Blue_R = §Blue_R
     C                   EVAL      $Blue_R = %xlate(' ': Char: $Blue_R)
     C                   EVAL      $Blue_U = §Blue_U
     C                   EVAL      $Blue_U = %xlate(' ': Char: $Blue_U)
      *
     C                   ENDSR
      *
      *============================================================*
      *    PosCsr        Positionieren Cursor auf aktuelle Farbe   *
      *============================================================*
      *
     C     PosCsr        BEGSR
      *
     C                   EVAL      %subarr(*in: 10: 10) = '0'                   - Green
     C                   EVAL      %subarr(*in: 20: 10) = '0'                   - White
     C                   EVAL      %subarr(*in: 30: 10) = '0'                   - Red
     C                   EVAL      %subarr(*in: 40: 10) = '0'                   - Türkis
     C                   EVAL      %subarr(*in: 50: 10) = '0'                   - Yellow
     C                   EVAL      %subarr(*in: 60: 10) = '0'                   - Pink
     C                   EVAL      %subarr(*in: 70: 10) = '0'                   - Blue
      *
      * Green
     C                   SELECT
     C     o_colorAttr   WHENEQ    §Green
     C                   EVAL      *IN10 = '1'
     C     o_colorAttr   WHENEQ    §Green_R
     C                   EVAL      *IN11 = '1'
     C     o_colorAttr   WHENEQ    §Green_U
     C                   EVAL      *IN12 = '1'
     C     o_colorAttr   WHENEQ    §Green_RU
     C                   EVAL      *IN13 = '1'
      * White
     C     o_colorAttr   WHENEQ    §White
     C                   EVAL      *IN20 = '1'
     C     o_colorAttr   WHENEQ    §White_R
     C                   EVAL      *IN21 = '1'
     C     o_colorAttr   WHENEQ    §White_U
     C                   EVAL      *IN22 = '1'
      * Red
     C     o_colorAttr   WHENEQ    §Red
     C                   EVAL      *IN30 = '1'
     C     o_colorAttr   WHENEQ    §Red_R
     C                   EVAL      *IN31 = '1'
     C     o_colorAttr   WHENEQ    §Red_U
     C                   EVAL      *IN32 = '1'
     C     o_colorAttr   WHENEQ    §Red_RU
     C                   EVAL      *IN33 = '1'
     C     o_colorAttr   WHENEQ    §Red_B
     C                   EVAL      *IN34 = '1'
     C     o_colorAttr   WHENEQ    §Red_RB
     C                   EVAL      *IN35 = '1'
     C     o_colorAttr   WHENEQ    §Red_UB
     C                   EVAL      *IN36 = '1'
      * Türkis
     C     o_colorAttr   WHENEQ    §Turkis
     C                   EVAL      *IN40 = '1'
     C     o_colorAttr   WHENEQ    §Turkis_R
     C                   EVAL      *IN41 = '1'
     C     o_colorAttr   WHENEQ    §Turkis_U
     C                   EVAL      *IN42 = '1'
     C     o_colorAttr   WHENEQ    §Turkis_RU
     C                   EVAL      *IN43 = '1'
      * Yellow
     C     o_colorAttr   WHENEQ    §Yellow
     C                   EVAL      *IN50 = '1'
     C     o_colorAttr   WHENEQ    §Yellow_R
     C                   EVAL      *IN51 = '1'
     C     o_colorAttr   WHENEQ    §Yellow_U
     C                   EVAL      *IN52 = '1'
      * Pink
     C     o_colorAttr   WHENEQ    §Pink
     C                   EVAL      *IN60 = '1'
     C     o_colorAttr   WHENEQ    §Pink_R
     C                   EVAL      *IN61 = '1'
     C     o_colorAttr   WHENEQ    §Pink_U
     C                   EVAL      *IN62 = '1'
     C     o_colorAttr   WHENEQ    §Pink_RU
     C                   EVAL      *IN63 = '1'
      * Blue
     C     o_colorAttr   WHENEQ    §Blue
     C                   EVAL      *IN70 = '1'
     C     o_colorAttr   WHENEQ    §Blue_R
     C                   EVAL      *IN71 = '1'
     C     o_colorAttr   WHENEQ    §Blue_U
     C                   EVAL      *IN72 = '1'
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
     C     i_dsp80       IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      ZEI = 8
     C                   EVAL      POS = 41
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 6
     C                   EVAL      POS = 22
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
     C                   EVAL      Wrk_Field = $GREEN
     C     ScnFld        WHENEQ    '$GREEN_R'
     C                   EVAL      Wrk_Field = $GREEN_R
     C     ScnFld        WHENEQ    '$GREEN_U'
     C                   EVAL      Wrk_Field = $GREEN_U
     C     ScnFld        WHENEQ    '$GREEN_RU'
     C                   EVAL      Wrk_Field = $GREEN_RU
      *  White
     C     ScnFld        WHENEQ    '$WHITE'
     C                   EVAL      Wrk_Field = $WHITE
     C     ScnFld        WHENEQ    '$WHITE_R'
     C                   EVAL      Wrk_Field = $WHITE_R
     C     ScnFld        WHENEQ    '$WHITE_U'
     C                   EVAL      Wrk_Field = $WHITE_U
      *  Red
     C     ScnFld        WHENEQ    '$RED'
     C                   EVAL      Wrk_Field = $RED
     C     ScnFld        WHENEQ    '$RED_R'
     C                   EVAL      Wrk_Field = $RED_R
     C     ScnFld        WHENEQ    '$RED_U'
     C                   EVAL      Wrk_Field = $RED_U
     C     ScnFld        WHENEQ    '$RED_RU'
     C                   EVAL      Wrk_Field = $RED_RU
     C     ScnFld        WHENEQ    '$RED_B'
     C                   EVAL      Wrk_Field = $RED_B
     C     ScnFld        WHENEQ    '$RED_RB'
     C                   EVAL      Wrk_Field = $RED_RB
     C     ScnFld        WHENEQ    '$RED_UB'
     C                   EVAL      Wrk_Field = $RED_UB
      *  Turquoise
     C     ScnFld        WHENEQ    '$TURKIS'
     C                   EVAL      Wrk_Field = $TURKIS
     C     ScnFld        WHENEQ    '$TURKIS_R'
     C                   EVAL      Wrk_Field = $TURKIS_R
     C     ScnFld        WHENEQ    '$TURKIS_U'
     C                   EVAL      Wrk_Field = $TURKIS_U
     C     ScnFld        WHENEQ    '$TURKIS_RU'
     C                   EVAL      Wrk_Field = $TURKIS_RU
      *  Yellow
     C     ScnFld        WHENEQ    '$YELLOW'
     C                   EVAL      Wrk_Field = $YELLOW
     C     ScnFld        WHENEQ    '$YELLOW_R'
     C                   EVAL      Wrk_Field = $YELLOW_R
     C     ScnFld        WHENEQ    '$YELLOW_U'
     C                   EVAL      Wrk_Field = $YELLOW_U
      *  Pink
     C     ScnFld        WHENEQ    '$PINK'
     C                   EVAL      Wrk_Field = $PINK
     C     ScnFld        WHENEQ    '$PINK_R'
     C                   EVAL      Wrk_Field = $PINK_R
     C     ScnFld        WHENEQ    '$PINK_U'
     C                   EVAL      Wrk_Field = $PINK_U
     C     ScnFld        WHENEQ    '$PINK_RU'
     C                   EVAL      Wrk_Field = $PINK_RU
      *  Blue
     C     ScnFld        WHENEQ    '$BLUE'
     C                   EVAL      Wrk_Field = $BLUE
     C     ScnFld        WHENEQ    '$BLUE_R'
     C                   EVAL      Wrk_Field = $BLUE_R
     C     ScnFld        WHENEQ    '$BLUE_U'
     C                   EVAL      Wrk_Field = $BLUE_U
      *
     C                   OTHER
     C                   EVAL      Wrk_Field = *BLANKS
     C                   Endsl
      *
     C     Wrk_Field     IFNE      *BLANKS
     C     1             SUBST (P) Wrk_Field:1   o_colorAttr
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
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      *  Löschen der Cursorosition
     C                   EVAL      CsrRow = *ZEROS
     C                   EVAL      CsrCol = *ZEROS
      *
      * - Einstellen Darstellung der Funktionstasten
     C                   EVAL      SfBot = 1
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
     C                   Eval      PEEK21_NAME = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23_NAME = f_pgmCallN('PEEK23')
      *
     C                   Callp     PEEK23(§§PgmName: '*ALL': 0
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
      *---Nachrichten--------------------------------------*
 CPY  ***/COPY QCOPYLE,MSG_C_MAPI
      *----------------------------------------------------*
      *
