      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.5.0                               *
      *  Programm : PEEK26                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 31.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Abfragen Zielangaben für kopieren nach externer Datei        *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK26FM  CF   E             WORKSTN USROPN
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
      /COPY QCOPYLE,USR8151
      /COPY QCOPYLE,USR8152
      /COPY QCOPYLE,USR8153
      /COPY QCOPYLE,USR8154
      /COPY QCOPYLE,USR8155
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
     D XQSrcFile       DS
     D  XSrcFile                     10A
     D  XSrcLib                      10A
     D XSrcMbr         S             10A
     D XFile           S             10A
     D XLibrary        S             10A
     D XMember         S             10A
     D XMbrOpt         S             10A
     D XCrtFile        S             10A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D YPgm            S             10A                 inz
     D YKey            S             10A                 inz
     D YPosF24         S                   like(r§int4    ) inz
     D YFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D YNbrOfKeys      S                   like(r§int4    ) inz
     D YMsgID          S              7A                 INZ(*BLANKS)
     D YMsgDta         S            512A                 INZ(*BLANKS)
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
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
      *
     D A1              S              1A   INZ(*BLANKS)
      *
     D R_SrcFile       S                   LIKE(XSrcFile)  INZ(*BLANKS)
     D R_SrcLib        S                   LIKE(XSrcLib )  INZ(*BLANKS)
     D R_SrcMbr        S                   LIKE(XSrcMbr )  INZ(*BLANKS)
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
     C                   PARM                    XQSrcFile
     C                   PARM                    XSrcMbr
     C                   PARM                    XFile
     C                   PARM                    XLibrary
     C                   PARM                    XMember
     C                   PARM                    XMbrOpt
     C                   PARM                    XCrtFile
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
     C                   CLOSE     PEEK26FM
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
     C     *IN99         IFEQ      '0'
     C                   MOVEL (P) ##File        XFile
     C                   MOVEL (P) ##Library     XLibrary
     C                   MOVEL (P) ##Member      XMember
     C                   MOVEL (P) ##MbrOpt      XMbrOpt
     C                   MOVEL (P) ##CrtFile     XCrtFile
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
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
      *  DSPATR(PC)
     C                   MOVEL (P) '0'           *IN20                         ##File
     C                   MOVEL (P) '0'           *IN21                         ##Library
     C                   MOVEL (P) '0'           *IN22                         ##Member
     C                   MOVEL (P) '0'           *IN23                         ##MbrOpt
     C                   MOVEL (P) '0'           *IN24                         ##CrtFile
      *
      *  DSPATR(RI)
     C                   MOVEL (P) '0'           *IN30                         ##File
     C                   MOVEL (P) '0'           *IN31                         ##Library
     C                   MOVEL (P) '0'           *IN32                         ##Member
     C                   MOVEL (P) '0'           *IN33                         ##MbrOpt
     C                   MOVEL (P) '0'           *IN34                         ##CrtFile
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
     C                   EXSR      PRF20                                       File
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF21                                       Library
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF22                                       Member
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF23                                       MbrOpt
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF24                                       CrtFile
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF20         Prüfen:  Datei                            *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     ##File        IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8151'     §MsgID
     C                   MOVEL (P) ##File        USR81511
     C                   MOVEL (P) USR8151       §MsgDta
     C                   GOTO      EPRF20
     C                   Endif
      *
     C     EPRF20        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN20
     C                   MOVEL (P) '1'           *IN30
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF21         Prüfen:  Bibliothek                       *
      *============================================================*
      *
     C     PRF21         BEGSR
      *
     C     ##Library     IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8152'     §MsgID
     C                   MOVEL (P) ##Library     USR81521
     C                   MOVEL (P) USR8152       §MsgDta
     C                   GOTO      EPRF21
     C                   Endif
      *
     C     1             SUBST     ##Library:1   A1
     C     A1            IFEQ      '*'
      *  Sonderwerte ...
     C     ##Library     IFEQ      '*LIBL'
      *  ... gültig
     C                   ELSE
      *  ... ungültig
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8152'     §MsgID
     C                   MOVEL (P) ##Library     USR81521
     C                   MOVEL (P) USR8152       §MsgDta
     C                   GOTO      EPRF21
     C                   Endif
     C                   ELSE
      *  Keine Sonderwerte ...
     C                   Endif
      *
     C     EPRF21        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN21
     C                   MOVEL (P) '1'           *IN31
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF22         Prüfen:  Teildatei                        *
      *============================================================*
      *
     C     PRF22         BEGSR
      *
     C     ##Member      IFEQ      *BLANKS
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8153'     §MsgID
     C                   MOVEL (P) ##Member      USR81531
     C                   MOVEL (P) USR8153       §MsgDta
     C                   GOTO      EPRF22
     C                   Endif
      *
     C     1             SUBST     ##Member:1    A1
     C     A1            IFEQ      '*'
      *  Sonderwerte ...
     C     ##Member      IFEQ      '*FIRST'
      *  ... gültig
     C                   ELSE
      *  ... ungültig
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8153'     §MsgID
     C                   MOVEL (P) ##member      USR81531
     C                   MOVEL (P) USR8153       §MsgDta
     C                   GOTO      EPRF22
     C                   Endif
     C                   ELSE
      *  Keine Sonderwerte ...
     C                   Endif
      *
     C     EPRF22        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN22
     C                   MOVEL (P) '1'           *IN32
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF23         Prüfen:  Member Option                    *
      *============================================================*
      *
     C     PRF23         BEGSR
      *
     C     ##MbrOpt      IFNE      '*ADD'
     C     ##MbrOpt      ANDNE     '*REPLACE'
     C     ##MbrOpt      ANDNE     '*UPDADD'
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8154'     §MsgID
     C                   MOVEL (P) ##MbrOpt      USR81541
     C                   MOVEL (P) USR8154       §MsgDta
     C                   GOTO      EPRF23
     C                   Endif
      *
     C     EPRF23        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN23
     C                   MOVEL (P) '1'           *IN33
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF24         Prüfen:  Datei erstellen                  *
      *============================================================*
      *
     C     PRF24         BEGSR
      *
     C     ##CrtFile     IFNE      '*YES'
     C     ##CrtFile     ANDNE     '*NO'
     C                   MOVEL (P) '1'           *IN99
     C                   MOVEL (P) 'USR8155'     §MsgID
     C                   MOVEL (P) ##CrtFile     USR81551
     C                   MOVEL (P) USR8155       §MsgDta
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN24
     C                   MOVEL (P) '1'           *IN34
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
      *    C_Refresh     F5  - Aktualisieren Bildschirm            *
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
     C     ##Library     IFEQ      *BLANKS
     C                   MOVEL (P) '*LIBL'       ##Library
     C                   Endif
      *
     C     ##Member      IFEQ      *BLANKS
     C                   MOVEL (P) '*FIRST'      ##Member
     C                   Endif
      *
     C     ##MbrOpt      IFEQ      *BLANKS
     C                   MOVEL (P) '*ADD'        ##MbrOpt
     C                   Endif
      *
     C     ##CrtFile     IFEQ      *BLANKS
     C                   MOVEL (P) '*NO'         ##CrtFile
     C                   Endif
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
     C                   Z-ADD     26            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     6             ZEI
     C                   Z-ADD     7             POS
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
      * - Quelldatei hat gewechselt ...
     C     XSrcFile      IFNE      R_SrcFile
     C     XSrcLib       ORNE      R_SrcLib
     C     XSrcMbr       ORNE      R_SrcMbr
     C                   MOVEL (P) *BLANKS       ##File
     C                   MOVEL (P) *BLANKS       ##Library
     C                   MOVEL (P) XSrcMbr       ##Member
     C                   MOVEL (P) XSrcFile      R_SrcFile
     C                   MOVEL (P) XSrcLib       R_SrcLib
     C                   MOVEL (P) XSrcMbr       R_SrcMbr
     C                   ELSE
      * - Quelldatei hat nicht gewechselt ...
      *              alte Werte stehenlassen
     C                   Endif
      *
     C                   MOVEL (P) *BLANKS       ##MbrOpt
     C                   MOVEL (P) *BLANKS       ##CrtFile
      *
      * - Öffnen der Dateien
     C                   OPEN      PEEK26FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Bildschirmfelder füllen
     C                   EXSR      FILL##
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
