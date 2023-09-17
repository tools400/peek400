      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK52                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 20.01.99  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Abfrage "Programm erstellen"                      *
      *                                                               *
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
     FPEEK52FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     INFSR(*PSSR)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
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
      *---Benutzervoreinstellungen-------------------------*
      /COPY QCOPYLE,SET0012
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
      /COPY QCOPYLE,API_ERROR
      /COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---Nachrichtenaufbau--------------------------------*
      /COPY QCOPYLE,USR8100
      /COPY QCOPYLE,USR8216
      /COPY QCOPYLE,USR8219
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XDsp80          S              1A
     D XCopyRight      S            512A
     D XAlwLc          S              1A
     D XCase           S              1A
     D XRcdLock        S              1A
     D XNullDft        S              1A
     D XKeepCrs        S              1A
     D XMsgID          S              7A
     D XMsgDta         S            512A
     D XUnload         S              1A
      *
      *  Peek23:
     D yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
     D yMsgID          S              7A   INZ(*BLANKS)
     D yMsgDta         S            512A   INZ(*BLANKS)
      *
      *  Peek21:
     D YScnAID         S             10A   INZ(*BLANKS)
      *YPgm            S             10A   INZ(*BLANKS)
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(r§int4    ) inz
     D NbrFKeys        C                   CONST(2)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
      *
     D X               S                   like(r§int4    ) inz
     D Y               S                   like(r§int4    ) inz
      *
     D doGenerate      S               N   inz(bFalse)
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
     C                   PARM                    XAlwLc
     C                   PARM                    XCase
     C                   PARM                    XRcdLock
     C                   PARM                    XNullDft
     C                   PARM                    XKeepCrs
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
     C                   PARM                    XUnload
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
      *---------------------------------------------------*
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
     C                   IF        xUnload = bTrue
     C                   CLOSE     PEEK52FM
     C                   MOVEL(P)  *ON           *INLR
     C                   GOTO      ENDE
     C                   ENDIF
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
     C                   EVAL      doGenerate = bFalse
     C                   EXSR      dspCmdKeys
      *
      *  Anzeigen Bildschirm
     C                   EXFMT     BILD01
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
      *  Abfragen der Programmbefehle
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
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
     C     *IN99         IFEQ      '0'
     C                   MOVEL (P) 'USR8112'     XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
     C                   WRITE     MSGCTL2
     C                   EVAL      doGenerate = bTrue
     C                   EXSR      dspCmdKeys
     C                   WRITE     BILD02
      *
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
     C                   RETURN
      *
      *============================================================*
      *    dspCmdKeys    Anzeigen der Befehlstasten                *
      *============================================================*
      *
     C     dspCmdKeys    BEGSR
      *
     C                   Eval      *IN40 = *OFF
      *
     C                   SELECT
     C                   When      (SFBOT = 2) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C                   If        (not doGenerate)
     C                   WRITE     PBBOT#2                                      BT-Tasten 2
     C                   Else
     C                   WRITE     PBBOT2#2                                     BT-Tasten 2
     C                   Endif
     C                   When      (SFBOT = 3) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#3                                      BT-Tasten 3
     C   40              WRITE     PBBOT2#3                                     BT-Tasten 3
     C                   When      (SFBOT = 4) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#4                                      BT-Tasten 4
     C   40              WRITE     PBBOT2#4                                     BT-Tasten 4
     C                   When      (SFBOT = 5) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#5                                      BT-Tasten 5
     C   40              WRITE     PBBOT2#5                                     BT-Tasten 5
     C                   When      (SFBOT = 6) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#6                                      BT-Tasten 6
     C   40              WRITE     PBBOT2#6                                     BT-Tasten 6
     C                   When      (SFBOT = 7) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#7                                      BT-Tasten 7
     C   40              WRITE     PBBOT2#7                                     BT-Tasten 7
     C                   When      (SFBOT = 8) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#8                                      BT-Tasten 8
     C   40              WRITE     PBBOT2#8                                     BT-Tasten 8
     C                   When      (SFBOT = 9) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#9                                      BT-Tasten 4
     C   40              WRITE     PBBOT2#9                                     BT-Tasten 9
     C                   When      (SFBOT = 10) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#10                                     BT-Tasten 10
     C   40              WRITE     PBBOT2#10                                    BT-Tasten 10
     C                   When      (SFBOT = 11) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#11                                     BT-Tasten 11
     C   40              WRITE     PBBOT2#11                                    BT-Tasten 11
     C                   When      (SFBOT = 12) and
     C                             (yNbrOfKeys > NbrFKeys * (SFBOT - 1))
     C  N40              WRITE     PBBOT#12                                     BT-Tasten 12
     C   40              WRITE     PBBOT2#12                                    BT-Tasten 12
     C                   OTHER
     C                   If        (not doGenerate)
     C                   WRITE     PBBOT#1                                      BT-Tasten 1
     C                   Else
     C                   WRITE     PBBOT2#1                                     BT-Tasten 1
     C                   Endif
     C                   Z-ADD     1             SFBOT
     C                   Endsl
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C                   EXSR      PRFB1
      *
     C     E_Enter       TAG
      *
     C     *IN99         IFEQ      '0'
     C                   MOVEL (P) ##ALWLC       XAlwLc
     C                   MOVEL (P) ##CASE        xCase
     C                   MOVEL (P) ##RCDLCK      xRcdLock
     C                   MOVEL (P) ##NULLDFT     xNullDft
     C                   MOVEL (P) ##KEEPCRS     xKeepCrs
     C                   IF        ##SAVE = bTrue
     C                   EXSR      SavUsrSetg
     C                   Endif
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRFB1         Prüfen der Eingaben                       *
      *============================================================*
      *
     C     PRFB1         BEGSR
      *
     C                   EXSR      PRF22                                       ##ALWLC
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF20                                       ##CASE
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF24                                       CASE/ALWLC
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF23                                       ##RCDLCK
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF25                                       ##NULLDFT
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF26                                       ##KEEPCRS
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C                   EXSR      PRF21                                       ##SAVE
     C     *IN99         CABEQ     '1'           EPRFB1
      *
     C     EPRFB1        ENDSR
      *
      *============================================================*
      *    PRF22         Prüfen:  alwlc                            *
      *============================================================*
      *
     C     PRF22         BEGSR
      *
     C     ##ALWLC       IFNE      bTrue
     C     ##ALWLC       ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##ALWLC       USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
     C                   GOTO      EPRF22
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
      *    PRF20         Prüfen:  case-sensitive                   *
      *============================================================*
      *
     C     PRF20         BEGSR
      *
     C     ##CASE        IFNE      bTrue
     C     ##CASE        ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##CASE        USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
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
      *    PRF23         Prüfen:  Satz gesperrt einlesen           *
      *============================================================*
      *
     C     PRF23         BEGSR
      *
     C     ##RCDLCK      IFNE      bTrue
     C     ##RCDLCK      ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##RCDLCK      USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
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
      *    PRF24         Prüfen:  case-sensitive                   *
      *============================================================*
      *
     C     PRF24         BEGSR
      *
     C                   IF        (##ALWLC = bFalse) and
     C                             (##CASE  = bTrue )
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8216
     C                   MOVEL (P) 'USR8216'     §MsgID
     C                   MOVEL (P) USR8216       §MsgDta
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN20
     C                   MOVEL (P) '1'           *IN30
     C                   MOVEL (P) '1'           *IN22
     C                   MOVEL (P) '1'           *IN32
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF25         Prüfen:  nullDft                          *
      *============================================================*
      *
     C     PRF25         BEGSR
      *
     C     ##NULLDFT     IFNE      bTrue
     C     ##NULLDFT     ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##NULLDFT     USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
     C                   GOTO      EPRF25
     C                   Endif
      *
     C     EPRF25        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN25
     C                   MOVEL (P) '1'           *IN35
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF26         Prüfen:  keepCrs                          *
      *============================================================*
      *
     C     PRF26         BEGSR
      *
     C     ##KEEPCRS     IFNE      bTrue
     C     ##KEEPCRS     ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##KEEPCRS     USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
     C                   GOTO      EPRF26
     C                   Endif
      *
     C     EPRF26        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   MOVEL (P) '1'           *IN26
     C                   MOVEL (P) '1'           *IN36
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    PRF21         Prüfen:  save                             *
      *============================================================*
      *
     C     PRF21         BEGSR
      *
     C     ##SAVE        IFNE      bTrue
     C     ##SAVE        ANDNE     bFalse
     C                   MOVEL (P) '1'           *IN99
     C                   CLEAR                   USR8219
     C                   MOVEL (P) ##SAVE        USR82191
     C                   MOVEL (P) 'USR8219'     §MsgID
     C                   MOVEL (P) USR8219       §MsgDta
     C                   GOTO      EPRF21
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
      *    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
      *============================================================*
      *
     C     BZOFF1        BEGSR
      *
      *  DSPATR(PC)
     C                   MOVEL (P) '0'           *IN20                         ##CASE
     C                   MOVEL (P) '0'           *IN21                         ##SAVE
     C                   MOVEL (P) '0'           *IN22                         ##ALWLC
     C                   MOVEL (P) '0'           *IN23                         ##RCDLCK
     C                   MOVEL (P) '0'           *IN25                         ##NULLDFT
     C                   MOVEL (P) '0'           *IN26                         ##KEEPCRS
      *
      *  DSPATR(RI)
     C                   MOVEL (P) '0'           *IN30                         ##CASE
     C                   MOVEL (P) '0'           *IN31                         ##SAVE
     C                   MOVEL (P) '0'           *IN32                         ##ALWLC
     C                   MOVEL (P) '0'           *IN33                         ##RCDLCK
     C                   MOVEL (P) '0'           *IN35                         ##NULLDFT
     C                   MOVEL (P) '0'           *IN36                         ##KEEPCRS
      *
      *  Fehler
     C                   MOVEL (P) '0'           *IN99
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
     C                   EXSR      BZOFF1
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
     C                   Eval      ##ALWLC   = SET_ALWLC
     C                   Eval      ##CASE    = SET_CASE
     C                   Eval      ##RCDLCK  = SET_RCD_LOCK
     C                   Eval      ##NULLDFT = SET_NULL_DFT
     C                   Eval      ##KEEPCRS = SET_KEEP_CRS
     C                   Eval      ##SAVE    = bFalse
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
     C                   ADD       1             ZEI
     C                   Z-ADD     40            POS
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   MOVEL (P) '1'           *IN88
     C                   Z-ADD     4             ZEI
     C                   ADD       3             ZEI
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
      *  *CRTPGM
     C                   Eval      SET0012 = f_getUsrSg('*CRTPGM'   )
      *
     C                   ENDSR
      *
      *============================================================*
      *    SavUsrSetg    Sichern der Benutzervoreinstellungen      *
      *============================================================*
      *
     C     SavUsrSetg    BEGSR
      *
      *  *CRTPGM
     C                   MOVEL (P) ##CASE        SET_CASE
     C                   MOVEL (P) ##RCDLCK      SET_RCD_LOCK
     C                   MOVEL (P) ##ALWLC       SET_ALWLC
     C                   MOVEL (P) ##NULLDFT     SET_NULL_DFT
     C                   MOVEL (P) ##KEEPCRS     SET_KEEP_CRS
     C                   Callp     p_updUsrSg('*CRTPGM': SET0012)
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
     C                   OPEN      PEEK52FM
      *
      * - Benutzervoreinstellungen
     C                   EXSR      GetUsrSetg
      *
      * - Füllen der Bildschirmfelder
     C                   EXSR      BZOFF1
     C                   EXSR      FILL##
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   MOVEL (P) *BLANKS       XMsgID
     C                   MOVEL (P) *BLANKS       XMsgDta
      *
      * - Darstellung der Befehlstasten
     C                   Z-ADD     1             SfBot
      *
      * - Einstellen der Bildschirmauflösung 80/132-Zeichen
     C                   EXSR      SetScreen
      *
      * - Copyright
      ***                MOVEL (P) 'USR9999'     §MsgID
      ***                MOVEL (P) XCopyRight    §MsgDta
      ***                Callp     p_sndPgmMg(§msgID: §msgDta: §§pgmName)
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
