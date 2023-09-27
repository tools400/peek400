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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK26
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
     D YFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D YNbrOfKeys      S                   like(r§int4    ) inz
     D YMsgID          S              7A                 INZ(*BLANKS)
     D YMsgDta         S            512A                 INZ(*BLANKS)
      *
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
     D PEEK21_NAME     S                   like(r§pgmCallN) inz
     D PEEK23_NAME     S                   like(r§pgmCallN) inz
      *
     D A1              S              1A   INZ(*BLANKS)
      *
     D R_SrcFile       S                   LIKE(i_qSrcFile.name) inz
     D R_SrcLib        S                   LIKE(i_qSrcFile.lib) inz
     D R_SrcMbr        S                   LIKE(i_srcMbr) inz
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
     D PEEK26          PI
     D  i_dsp80                            const like(r§dsp80)
     D  i_qSrcFile                         const likeds(r§qObj)
     D  i_srcMbr                           const like(r§mbr)
     D  o_toFile                                 like(r§file)
     D  o_toLib                                  like(r§lib)
     D  o_toMbr                                  like(r§mbr)
     D  o_mbrOpt                     10A
     D  o_crtFile                    10A
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
     C                   EVAL      o_toFile = ##File
     C                   EVAL      o_toLib = ##Library
     C                   EVAL      o_toMbr = ##Member
     C                   EVAL      o_mbrOpt = ##MbrOpt
     C                   EVAL      o_crtFile = ##CrtFile
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
     C                   EVAL      *IN20 = '0'                                  ##File
     C                   EVAL      *IN21 = '0'                                  ##Library
     C                   EVAL      *IN22 = '0'                                  ##Member
     C                   EVAL      *IN23 = '0'                                  ##MbrOpt
     C                   EVAL      *IN24 = '0'                                  ##CrtFile
      *
      *  DSPATR(RI)
     C                   EVAL      *IN30 = '0'                                  ##File
     C                   EVAL      *IN31 = '0'                                  ##Library
     C                   EVAL      *IN32 = '0'                                  ##Member
     C                   EVAL      *IN33 = '0'                                  ##MbrOpt
     C                   EVAL      *IN34 = '0'                                  ##CrtFile
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8151'
     C                   EVAL      USR81511 = ##File
     C                   EVAL      §MsgDta = USR8151
     C                   GOTO      EPRF20
     C                   Endif
      *
     C     EPRF20        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN20 = '1'
     C                   EVAL      *IN30 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8152'
     C                   EVAL      USR81521 = ##Library
     C                   EVAL      §MsgDta = USR8152
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8152'
     C                   EVAL      USR81521 = ##Library
     C                   EVAL      §MsgDta = USR8152
     C                   GOTO      EPRF21
     C                   Endif
     C                   ELSE
      *  Keine Sonderwerte ...
     C                   Endif
      *
     C     EPRF21        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN21 = '1'
     C                   EVAL      *IN31 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8153'
     C                   EVAL      USR81531 = ##Member
     C                   EVAL      §MsgDta = USR8153
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8153'
     C                   EVAL      USR81531 = ##member
     C                   EVAL      §MsgDta = USR8153
     C                   GOTO      EPRF22
     C                   Endif
     C                   ELSE
      *  Keine Sonderwerte ...
     C                   Endif
      *
     C     EPRF22        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN22 = '1'
     C                   EVAL      *IN32 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8154'
     C                   EVAL      USR81541 = ##MbrOpt
     C                   EVAL      §MsgDta = USR8154
     C                   GOTO      EPRF23
     C                   Endif
      *
     C     EPRF23        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN23 = '1'
     C                   EVAL      *IN33 = '1'
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
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8155'
     C                   EVAL      USR81551 = ##CrtFile
     C                   EVAL      §MsgDta = USR8155
     C                   GOTO      EPRF24
     C                   Endif
      *
     C     EPRF24        TAG
      *
     C     *IN99         IFEQ      '1'
     C                   EVAL      *IN24 = '1'
     C                   EVAL      *IN34 = '1'
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
     C     ##Library     IFEQ      *BLANKS
     C                   EVAL      ##Library = '*LIBL'
     C                   Endif
      *
     C     ##Member      IFEQ      *BLANKS
     C                   EVAL      ##Member = '*FIRST'
     C                   Endif
      *
     C     ##MbrOpt      IFEQ      *BLANKS
     C                   EVAL      ##MbrOpt = '*ADD'
     C                   Endif
      *
     C     ##CrtFile     IFEQ      *BLANKS
     C                   EVAL      ##CrtFile = '*NO'
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
     C     i_dsp80       IFEQ      '0'
      *   132-Zeichen Anzeige
     C                   EVAL      *IN88 = '0'
     C                   EVAL      ZEI = 8
     C                   EVAL      POS = 26
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 6
     C                   EVAL      POS = 7
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
     C                   IF        (i_qSrcFile.name <> R_SrcFile or
     C                              i_qSrcFile.lib <> R_SrcLib or
     C                              i_srcMbr <> R_SrcMbr)
     C                   EVAL      ##File = *BLANKS
     C                   EVAL      ##Library = *BLANKS
     C                   EVAL      ##Member = i_srcMbr
     C                   EVAL      R_SrcFile = i_qSrcFile.name
     C                   EVAL      R_SrcLib = i_qSrcFile.lib
     C                   EVAL      R_SrcMbr = i_srcMbr
     C                   ELSE
      * - Quelldatei hat nicht gewechselt ...
      *              alte Werte stehenlassen
     C                   Endif
      *
     C                   EVAL      ##MbrOpt = *BLANKS
     C                   EVAL      ##CrtFile = *BLANKS
      *
      * - Öffnen der Dateien
     C                   OPEN      PEEK26FM
      *
      * - Programm initialisieren
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
     C                   EVAL      o_msgID = *BLANKS
     C                   EVAL      o_msgDta = *BLANKS
      *
      * - Bildschirmfelder füllen
     C                   EXSR      FILL##
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
