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
     FPEEK24FM  CF   E             WORKSTN USROPN
     F                                     INFDS(§Workstn)
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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK24
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
     D YMsgID          S              7A   INZ(*BLANKS)
     D YMsgDta         S            512A   INZ(*BLANKS)
      *
     D yFKeys          S             18A   DIM(32)       INZ(*BLANKS)
     D yNbrOfKeys      S                   like(int4_t) inz
      *
     D YPgmCmd         S             10A   INZ(*BLANKS)
     D YCmdDta         S                   LIKE(pgmCmdDt_t) INZ(*BLANKS)
      *
      *---Definition der F-Tastenbildschirmfelder----------*
      /COPY QCOPYLE,SCRNFKEYS
      *----------------------------------------------------*
      *
     D SfBot           S                   like(int4_t) inz
     D §NbrFKeys       C                   CONST(2)
      *
     D Wrk_Field       S             10A   INZ(*BLANKS)
     D Wrk_Color       S              1A   INZ(*BLANKS)
      *
     D PEEK21_NAME     S                   like(pgmCallN_t) inz
     D PEEK23_NAME     S                   like(pgmCallN_t) inz
     D PEEK25_NAME     S                   like(pgmCallN_t) inz
      *
      /COPY QCOPYLE,PPEEK21
      /COPY QCOPYLE,PPEEK23
      /COPY QCOPYLE,PPEEK25
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
     D PEEK24          PI
     D  i_dsp80                            const like(dsp80_t)
     D  i_copyright                        const like(copyRght_t)
     D  o_set0001                                likeds(SET0001)
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
     C     6             SUBST (P) SCNFLD:3      Wrk_Field
      *
     C                   SELECT
     C     Wrk_Field     WHENEQ    'KEYCOL'                                     Überschrift
     C                   EVAL      Wrk_Color = SET_KeyCol
     C     Wrk_Field     WHENEQ    'HEDCOL'                                     Überschrift
     C                   EVAL      Wrk_Color = SET_HedCol
     C     Wrk_Field     WHENEQ    'PINCOL'                                     Pined-Daten
     C                   EVAL      Wrk_Color = SET_PinCol
     C     Wrk_Field     WHENEQ    'CLMCOL'                                     SpaltenMark
     C                   EVAL      Wrk_Color = SET_ClmCol
     C     Wrk_Field     WHENEQ    'STDCOL'                                     Standard
     C                   EVAL      Wrk_Color = SET_StdCol
     C     Wrk_Field     WHENEQ    'NMLCOL'                                     Normale Suche
     C                   EVAL      Wrk_Color = SET_NmlCol
     C     Wrk_Field     WHENEQ    'UNDCOL'                                     Unterstrichen
     C                   EVAL      Wrk_Color = SET_UndCol
     C     Wrk_Field     WHENEQ    'REVCOL'                                     Reverse Suche
     C                   EVAL      Wrk_Color = SET_RevCol
     C     Wrk_Field     WHENEQ    'TBLCOL'                                     Tabellierpap.
     C                   EVAL      Wrk_Color = SET_TblCol
     C     Wrk_Field     WHENEQ    'EXCCOL'                                     Exception
     C                   EVAL      Wrk_Color = SET_ExcCol
     C                   OTHER
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8146'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   EVAL      o_msgID = 'USR8112'
     C                   EVAL      o_msgDta = *BLANKS
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
      *  SET_KeyCol
     C                   EVAL      $$KEYCOL = SET_KeyCol
     C**                 CAT       'KeyField':0  $$KEYCOL
     C                   EVAL      $$KEYCOL = %trimr($$KEYCOL) + 'KeyField'
      *
      *  SET_HedCol
     C                   EVAL      $$HEDCOL = SET_HedCol
     C**                 CAT       'Headline':0  $$HEDCOL
     C                   EVAL      $$HEDCOL = %trimr($$HEDCOL) + 'Headline'
      *
      *  SET_PinCol
     C                   EVAL      $$PINCOL1 = SET_PinCol
     C                   EVAL      $$PINCOL2 = $$PINCOL1
     C**                 CAT       'Pin-Record':0$$PINCOL1
     C                   EVAL      $$PINCOL1 = %trimr($$PINCOL1) + 'Pin-Record'
      *
     C**   ' ':'x'       XLATE     $$PINCOL2     $$PINCOL2
     C                   EVAL      $$PINCOL2 = %xlate(' ': 'x': $$PINCOL2)
     C                   EVAL      $$PINCOL3 = $$PINCOL2
     C                   EVAL      $$PINCOL4 = $$PINCOL2
      *
      *  SET_StdCol
     C                   EVAL      $$STDCOL1 = SET_StdCol
     C                   EVAL      $$STDCOL2 = $$STDCOL1
     C**                 CAT       'Std.Color':0 $$STDCOL1
     C                   EVAL      $$STDCOL1 = %trimr($$STDCOL1) + 'Std.Color'
      *
     C**   ' ':'x'       XLATE     $$STDCOL2     $$STDCOL2
     C                   EVAL      $$STDCOL2 = %xlate(' ': 'x': $$STDCOL2)
     C                   EVAL      $$STDCOL3 = $$STDCOL2
     C                   EVAL      $$STDCOL4 = $$STDCOL2
     C                   EVAL      $$STDCOL5 = $$STDCOL2
     C                   EVAL      $$STDCOL6 = $$STDCOL2
      *
      *  SET_ClmCol
     C                   EVAL      $$CLMCOL1 = SET_ClmCol
     C                   EVAL      $$CLMCOL2 = $$CLMCOL1
     C**                 CAT       'Mark Clm':0  $$CLMCOL1
     C                   EVAL      $$CLMCOL1 = %trimr($$CLMCOL1) + 'Mark Clm'
      *
     C**   ' ':'x'       XLATE     $$CLMCOL2     $$CLMCOL2
     C                   EVAL      $$CLMCOL2 = %xlate(' ': 'x': $$CLMCOL2)
     C                   EVAL      $$CLMCOL3 = $$CLMCOL2
     C                   EVAL      $$CLMCOL4 = $$CLMCOL2
     C                   EVAL      $$CLMCOL5 = $$CLMCOL2
     C                   EVAL      $$CLMCOL6 = $$CLMCOL2
     C                   EVAL      $$CLMCOL7 = $$CLMCOL2
      *
      *  SET_NmlCol
     C                   EVAL      $$NmlCOL1 = SET_NmlCol
     C                   EVAL      $$NmlCOL2 = $$NmlCOL1
     C**                 CAT       'Search':0    $$NmlCOL1
     C                   EVAL      $$NmlCOL1 = %trimr($$NmlCOL1) + 'Search'
      *
     C**   ' ':'x'       XLATE     $$NmlCOL2     $$NmlCOL2
     C                   EVAL      $$NmlCOL2 = %xlate(' ': 'x': $$NmlCOL2)
     C                   EVAL      $$NMLCOL3 = $$NmlCOL2
     C                   EVAL      $$NmlCOL4 = $$NmlCOL2
      *
      *  SET_UndCol
     C                   EVAL      $$UNDCOL1 = SET_UndCol
     C                   EVAL      $$UNDCOL2 = $$UNDCOL1
     C**                 CAT       'Search-Und':0$$UNDCOL1
     C                   EVAL      $$UNDCOL1 = %trimr($$UNDCOL1) + 'Search-Und'
      *
     C**   ' ':'x'       XLATE     $$UNDCOL2     $$UNDCOL2
     C                   EVAL      $$UNDCOL2 = %xlate(' ': 'x': $$UNDCOL2)
     C                   EVAL      $$UNDCOL3 = $$UNDCOL2
     C                   EVAL      $$UNDCOL4 = $$UNDCOL2
      *
      *  SET_RevCol
     C                   EVAL      $$REVCOL1 = SET_RevCol
     C                   EVAL      $$REVCOL2 = $$REVCOL1
     C**                 CAT       'Search-Rev':0$$REVCOL1
     C                   EVAL      $$REVCOL1 = %trimr($$REVCOL1) + 'Search-Rev'
      *
     C**   ' ':'x'       XLATE     $$REVCOL2     $$REVCOL2
     C                   EVAL      $$REVCOL2 = %xlate(' ': 'x': $$REVCOL2)
     C                   EVAL      $$REVCOL3 = $$REVCOL2
     C                   EVAL      $$REVCOL4 = $$REVCOL2
      *
      *  SET_TblCol
     C                   EVAL      $$TBLCOL1 = SET_TblCol
     C                   EVAL      $$TBLCOL2 = $$TBLCOL1
     C**                 CAT       'Tabulated':0 $$TBLCOL1
     C                   EVAL      $$TBLCOL1 = %trimr($$TBLCOL1) + 'Tabulated'
      *
     C**   ' ':'x'       XLATE     $$TBLCOL2     $$TBLCOL2
     C                   EVAL      $$TBLCOL2 = %xlate(' ': 'x': $$TBLCOL2)
     C                   EVAL      $$TBLCOL3 = $$TBLCOL2
     C                   EVAL      $$TBLCOL4 = $$TBLCOL2
      *
      *  SET_ExcCol
     C                   EVAL      $$EXCCOL1 = SET_ExcCol
     C                   EVAL      $$EXCCOL2 = $$EXCCOL1
     C**                 CAT       'Exception':0 $$EXCCOL1
     C                   EVAL      $$EXCCOL1 = %trimr($$EXCCOL1) + 'Exception'
      *
     C**   ' ':'x'       XLATE     $$EXCCOL2     $$EXCCOL2
     C                   EVAL      $$EXCCOL2 = %xlate(' ': 'x': $$EXCCOL2)
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
     C                   EVAL      ZEI = 6
     C                   EVAL      POS = 26
     C                   ELSE
      *    80-Zeichen Anzeige
     C                   EVAL      *IN88 = '1'
     C                   EVAL      ZEI = 4
     C                   EVAL      POS = 7
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
     C                   EVAL      SET0001 = o_set0001
      *
     C                   ENDSR
      *
      *============================================================*
      *    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
      *============================================================*
      *
     C     SetUsrSetg    BEGSR
      *
     C                   EVAL      o_set0001 = SET0001
      *
     C                   ENDSR
      *
      *============================================================*
      *    GetColor      Auswählen neue Farbe                      *
      *============================================================*
      *
     C     GetColor      BEGSR
      *
     C                   monitor
     C                   callp     PEEK25(i_dsp80: Wrk_Color: YMsgID: YMsgDta)
     C                   eval      *in99 = bFalse
     C                   on-error
     C                   eval      *in99 = bTrue
     C                   endmon
      *
     C     *IN99         IFEQ      '1'
      *             Fehler aufgetreten
     C                   ELSE
      *
     C                   SELECT
     C     Wrk_Field     WHENEQ    'KEYCOL'                                     Überschrift
     C                   EVAL      SET_KeyCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'HEDCOL'                                     Überschrift
     C                   EVAL      SET_HedCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'PINCOL'                                     Pined-Daten
     C                   EVAL      SET_PinCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'CLMCOL'                                     Spaltenmark.
     C                   EVAL      SET_ClmCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'STDCOL'                                     Standard
     C                   EVAL      SET_StdCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'NMLCOL'                                     Normale Suche
     C                   EVAL      SET_NmlCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'UNDCOL'                                     Unterstrichen
     C                   EVAL      SET_UndCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'REVCOL'                                     Reverse Suche
     C                   EVAL      SET_RevCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'TBLCOL'                                     Tabellierpap.
     C                   EVAL      SET_TblCol = Wrk_Color
     C     Wrk_Field     WHENEQ    'EXCCOL'                                     Exception
     C                   EVAL      SET_ExcCol = Wrk_Color
     C                   OTHER
     C                   EVAL      *IN99 = '1'
     C                   EVAL      §MsgID = 'USR8146'
     C                   EVAL      §MsgDta = *BLANKS
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
     C                   Eval      PEEK25_NAME = f_pgmCallN('PEEK25')
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
