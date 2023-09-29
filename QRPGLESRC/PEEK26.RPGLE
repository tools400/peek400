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
     F                                     INFDS(workstn)
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
     D YNbrOfKeys      S                   like(int4_t) inz
     D YMsgID          S              7A                 INZ(*BLANKS)
     D YMsgDta         S            512A                 INZ(*BLANKS)
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(int4_t) inz
     D NbrFKeys        C                   CONST(2)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
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
      /COPY QCOPYLE,CEECNDHDLR
      *
     D isInzSr         S                   like(bool_t) inz(bFalse)
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK26          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_qSrcFile                         const likeds(qObj_t)
     D  i_srcMbr                           const like(mbr_t)
     D  o_toFile                                 like(file_t)
     D  o_toLib                                  like(lib_t)
     D  o_toMbr                                  like(mbr_t)
     D  o_mbrOpt                     10A
     D  o_crtFile                    10A
     D  o_msgID                                  like(msgID_t)
     D  o_msgDta                                 like(msgDta_t)
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
      *  Schleife für Programmbearbeitung
      *
     C                   DO        *HIVAL
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
     C                   Eval      cursorPosition.row =
     C                               workstn.csrPos / 256
     C                   Eval      cursorPosition.column =
     C                               %rem(workstn.csrPos: 256)
      *
      *  Nachrichten löschen
     C                   Callp     p_rmvPgmMg(§§pgmName)
      *
      *  Bezugszahlen löschen
     C                   EXSR      BZOFF1
      *
      *  Mappen der gedrückten Taste
      *  in Programmbefehl
     C                   CALLP     PEEK21(workstn.aid: §§PgmName
     C                                    : YPgmCmd: YCmdDta: YMsgID: YMsgDta)
     C     YMsgID        IFNE      *BLANKS
     C                   Callp     p_sndPgmMg(yMsgID: yMsgDta: §§pgmName)
     C                   EVAL      YMsgID = ''
     C                   EVAL      YMsgDta = ''
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
     C                   Callp     p_wrongKey(workstn.aid: §§pgmName)
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
     C                   CLEAR                   USR81511
     C                   EVAL      USR81511 = ##File
     C                   Callp     p_sndPgmMg('USR8151': USR8151: §§pgmName)
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
     C                   CLEAR                   USR81521
     C                   EVAL      USR81521 = ##Library
     C                   Callp     p_sndPgmMg('USR8152': USR8152: §§pgmName)
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
     C                   CLEAR                   USR8152
     C                   EVAL      USR81521 = ##Library
     C                   Callp     p_sndPgmMg('USR8152': USR8152: §§pgmName)
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
     C                   CLEAR                   USR8153
     C                   EVAL      USR81531 = ##Member
     C                   Callp     p_sndPgmMg('USR8153': USR8153: §§pgmName)
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
     C                   CLEAR                   USR8153
     C                   EVAL      USR81531 = ##Member
     C                   Callp     p_sndPgmMg('USR8153': USR8153: §§pgmName)
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
     C                   CLEAR                   USR8154
     C                   EVAL      USR81541 = ##MbrOpt
     C                   Callp     p_sndPgmMg('USR8154': USR8154: §§pgmName)
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
     C                   CLEAR                   USR8155
     C                   EVAL      USR81551 = ##CrtFile
     C                   Callp     p_sndPgmMg('USR8155': USR8155: §§pgmName)
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
     C     workstn.aid   WHENEQ    K_F3
     C                   EVAL      USR81001 = 'F3'
     C     workstn.aid   WHENEQ    K_F12
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
     C                   Callp     PEEK23(§§PgmName: '*ALL': 0
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
