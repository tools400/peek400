      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 1.4.0                               *
      *  Programm : PEEK12                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 02.10.97  Raddatz                                 *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Auswahl Satzformat                                           *
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
     FPEEK12FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
     F                                     SFILE(PBSFL:SFLREC)
     F                                     INFSR(*PSSR)
      * Liste der Satzformate
     FPEEKFMT   IF   E             DISK    USROPN
     F                                     INFSR(*PSSR)
     F                                     INFDS(Peek_01_DS)
     F                                     PREFIX(F_)
      *
      *---INFOSTRUKTUR FÜR AID-BYTE -----------------------*
      /COPY QCOPYLE,DS_WORKSTN
      *----------------------------------------------------*
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      /COPY QCOPYLE,FLDL0100
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
      *---API-Formate--------------------------------------*
      /COPY QCOPYLE,RCDL0200
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  I N F D S - D E F I N I T I O N E N               *
      *----------------------------------------------------*
      *
     DPeek_01_DS       DS
     D P1File                 83     92A
     D P1Library              93    102A
     D P1Member              129    138A
     D P1NbrOfRcd            156    159I 0
     D P1RcdNbr              397    400I 0
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
     D XCopyRight      S            512A
     D XFmtName        S             10A
     D XFmtData        S            512A
     D XFmtNbr         S              5I 0
     D XFmtMode        S             10A
     D XMsgID          S              7A
     D XMsgDta         S            512A
      *
     D SfBot           S                   like(r§int4    ) inz
      *
     D LastRcdNbr      S                   like(R§RcdNbr  ) inz
     D SflPage         S                   like(r§int4    ) inz
     D SflRec          S                   like(SflPage   ) inz
     D SflLastRcd      S                   like(SflPage   ) inz
     D §NbrFKeys       C                   const(3)
      *
     D PEEK21          S                   like(r§pgmCallN) inz
     D PEEK23          S                   like(r§pgmCallN) inz
      *
      *  PEEK21
     D YScnAID         S             10A   INZ(*BLANKS)
     D yPgm            S             10A   inz
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(r§pgmCmdDt) INZ(*BLANKS)
     D YMsgID          S              7A   INZ(*BLANKS)
     D YMsgDta         S            512A   INZ(*BLANKS)
      *
      *  PEEK23
      *yPgm            S             10A   inz
     D yKey            S             10A   inz
     D yPosF24         S                   like(r§int4    ) inz
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(r§int4    ) inz
      *YMsgID          S              7A   INZ(*BLANKS)
      *YMsgDta         S            512A   INZ(*BLANKS)
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
     C                   PARM                    XFmtName
     C                   PARM                    XFmtData
     C                   PARM                    XFmtNbr
     C                   PARM                    XFmtMode
     C                   PARM                    XMsgID
     C                   PARM                    XMsgDta
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
      *
     C                   EXSR      FIRST
      *
      *---------------------------------------------------*
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
      *
      *  Prüfen Positionierung der Subfile
     C                   IF        (SFSANR <= 0     )  or
     C                             (SFSANR >  SFLREC)
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
     C                   WRITE     PBBOT#0
      *
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
     C     §ScnAID       WHENEQ    §F3                                          ENDE
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  F5  - Aktualisieren
     C     §ScnAID       WHENEQ    §F5                                          AKTUALISIEREN
     C                   EXSR      C_Refresh
     C                   ITER
      *
      *  F12 - Ende
     C     §ScnAID       WHENEQ    §F12                                         ZURÜCK
     C                   EXSR      C_EndPgm
     C                   LEAVE
      *
      *  Datenfreigabe
     C     §ScnAID       WHENEQ    §ENTER
     C                   EXSR      C_Enter
      *
      *  F24 - Weitere Tasten
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
     C                   OTHER
      *  Falsche Taste gedrückt
     C                   Callp     p_wrongKey(§scnAID: §§pgmName)
     C                   ITER
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
     C                   Close     PEEKFMT
      *
     C                   Eval      *INLR = *ON
      *
      *============================================================*
      *    C_Enter       "Datenfreigabetaste"                      *
      *============================================================*
      *
     C     C_Enter       BEGSR
      *
     C     *IN80         IFEQ      '0'
      *          Subfile ist leer
     C                   ELSE
      *
     C                   DO        *HIVAL
     C                   READC     PBSFL                                  11
     C     *IN11         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      XFmtData = $$RCDL0200
     C                   EVAL      XFmtNbr = FMTNBR
     C                   Enddo
      *
     C                   Endif                                                  *IN80
      *
     C     XFmtData      IFNE      *BLANKS
     C                   GOTO      Ende
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
     C                   Write     RMVWDW
      *
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      XMsgID = 'USR8100'
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
     C                   EVAL      XMsgDta = USR8100
      *
     C                   EVAL      XFmtData = *BLANKS
     C                   EVAL      XFmtNbr = *ZEROS
      *
     C                   ENDSR
      *
      *============================================================*
      *    C_Refresh     F5  - Aktualisieren der Subfile           *
      *============================================================*
      *
     C     C_Refresh     BEGSR
      *
     C                   EXSR      PBFirstRcd
     C                   EXSR      PBInit
     C                   EXSR      PBSetLL
     C                   EXSR      PBReadUp
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
     C                   ENDSR
      *
      *============================================================*
      *    PBFirstRcd    Ersten geschriebenen Satz der Subfile     *
      *                  einlesen                                  *
      *============================================================*
      *
     C     PBFirstRcd    BEGSR
      *
     C     *IN80         IFEQ      '0'
     C                   EVAL      LastRcdNbr = *ZEROS
     C                   ELSE
      *
     C     1             CHAIN     PBSFL                              11
      *
     C     *IN11         IFEQ      '0'
     C                   EVAL      LastRcdNbr = RecordNbr
     C                   ELSE
     C                   EVAL      LastRcdNbr = *ZEROS
     C                   Endif
     C                   Endif
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
     C                   READ      FPEEKFMT                               83
     C     *IN83         IFEQ      '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EVAL      SFLRec = SFLRec + 1
      *
     C     SFLRec        IFGT      9999
     C                   EVAL      *IN83 = '1'
     C                   LEAVE
     C                   Endif
      *
     C                   EXSR      PBFill
      *
     C                   WRITE     PBSfl
      *
     C                   EVAL      SflLastRcd = SflRec
      *
     C     SFLRec        IFGE      SflPage
     C                   LEAVE
     C                   Endif
      *
     C                   Enddo
      *
     C                   EXSR      PBExit
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBExit        Hinter füllen Subfile                     *
      *============================================================*
      *
     C     PBExit        BEGSR
      *
     C                   EXSR      PBFirstRcd
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBFill        Füllen Subfilesatz                        *
      *============================================================*
      *
     C     PBFill        BEGSR
      *
     C                   EVAL      SFPAU = *BLANKS
     C                   EVAL      RCDL0200 = F_Fmt
     C                   EVAL      $$RCDL0200 = F_Fmt
     C                   EVAL      $$Format = R2FmtName
     C                   EVAL      $$Text = R2Text
     C                   EVAL      RecordNbr = P1RcdNbr
     C                   EVAL      FMTNBR = F_FmtNbr
      *
     C                   EVAL      *IN80 = '1'                                  SFLDSP
     C                   EVAL      LastRcdNbr = P1RcdNbr
      *
     C                   ENDSR
      *
      *============================================================*
      *    PBSetLL       Setzen Dateizeiger                        *
      *============================================================*
      *
     C     PBSetLL       BEGSR
      *
     C     LastRcdNbr    SETLL     FPEEKFMT
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
     C                   EVAL      ZEI = 4
     C                   EVAL      POS = 12
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 4
     C                   EVAL      POS = 8
     C                   Endif
      *
     C                   EVAL      SflPage = *HIVAL
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
     C                   OPEN      PEEKFMT
      *
      * - Prüfen auf Satzformat
     C                   IF        (XFmtMode   = §BATCH) and
     C                             ((P1NbrOfRcd = 1) or (XFmtName <> ''))
     C     1             SETLL     FPEEKFMT
     C                   DOU       %EOF(PEEKFMT)
     C                   READ      FPEEKFMT                               11
     C     *IN11         IFEQ      '0'

     C                   EVAL      RCDL0200 = F_Fmt
     C                   IF        (R2FmtName = XFmtName) or
     C                             ((P1NbrOfRcd = 1) and (XFmtName = ''))
     C                   EVAL      XFmtData = F_Fmt
     C                   EVAL      XFmtNbr = F_FmtNbr
     C                   GOTO      Ende
     C                   ENDIF
     C                   ENDIF
     C                   ENDDO
     C                   ENDIF
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      XFmtData = *BLANKS
     C                   EVAL      XFmtNbr = *ZEROS
     C                   EVAL      XMsgID = *BLANKS
     C                   EVAL      XMsgDta = *BLANKS
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
      * - Subfile füllen
     C                   EVAL      LastRcdNbr = 1
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
     C     *INZSR        BEGSR
      *
     C                   Eval      §PgmQ = '*'
      *
     C                   Eval      PEEK21 = f_pgmCallN('PEEK21')
     C                   Eval      PEEK23 = f_pgmCallN('PEEK23')
      *
     C                   Eval      yPgm    = §§PgmName
     C                   Eval      yKey    = '*ALL'
     C                   Eval      yPosF24 = §NbrFKeys
     C                   Call      PEEK23        P_Peek23
     C                   Eval      scrnFKeys = %subarr(yFKeys: 1)
      *
     C                   OPEN      PEEK12FM
      *
     C                   ENDSR
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
