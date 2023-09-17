?     *                                                                                       RADDAT
?     *============================================================*                          RADDAT
?     *    Auswerten Programmbefehle                               *                          RADDAT
?     *============================================================*                          RADDAT
?     *                                                                                       RADDAT
     C                   MOVEL (P) bFalse        IsCancel                                     RADDAT
     C                   MOVEL (P) bFalse        IsCmdErr                                     RADDAT
?     *                                                                                       RADDAT
 B01 C                   SELECT                                                               RADDAT
?     *---------------------------------------*                                               RADDAT
?     *  F3  - Programm beenden                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*EXIT'                                                    RADDAT
     C                   EXSR      C_EndPgm                                                   RADDAT
 B02 C     IsOpen        IFEQ      bFalse                                                     RADDAT
     C                   GOTO      ENDE                                                       RADDAT
 X02 C                   ELSE                                                                 RADDAT
?     *              Weiter machen                                                            RADDAT
 E02 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
?     *  F4  - Prompt
     C     YPgmCmd       WHENEQ    '*PROMPT'
     C                   EXSR      C_Prompt
 B02 C     §MsgID        IFEQ      *BLANKS
?   R ***                MOVEL (P) '1'           *IN93                                        RADDAT
     C                   EXSR      C_Enter
 E02 C                   ENDIF
?     *                                                                                       RADDAT
?     *  F5  - Anzeige aktualisieren                                                          RADDAT
     C     YPgmCmd       WHENEQ    '*REFRESH'                                                 RADDAT
     C                   EXSR      C_Refresh                                                  RADDAT
?     *                                                                                       RADDAT
?     *  F6  - Neuanlage Datensatz                                                            RADDAT
     C     YPgmCmd       WHENEQ    '*ADD'                                                     RADDAT
     C                   EXSR      C_Add                                                      RADDAT
?     *                                                                                       RADDAT
?     *  F7  - Umschalten der Überschrift                                                     RADDAT
     C     YPgmCmd       WHENEQ    '*HEADLINE'                                                RADDAT
     C                   EXSR      C_ChgHead                                                  RADDAT
?     *                                                                                       RADDAT
?     *  F8  - Spalte markieren, ein                                                          RADDAT
     C     YPgmCmd       WHENEQ    '*MRKCOL'                                                  RADDAT
     C                   EXSR      C_MrkCol                                                   RADDAT
?     *                                                                                       RADDAT
?     *      - Spalte markieren, aus                                                          RADDAT
     C     YPgmCmd       WHENEQ    '*UNMRKCOL'                                                RADDAT
     C                   EXSR      C_UnMrkCol                                                 RADDAT
?     *                                                                                       RADDAT
?     *      - Spalte markieren, ein/aus                                                      RADDAT
     C     YPgmCmd       WHENEQ    '*TGLMRKCOL'                                               RADDAT
     C                   EXSR      C_TgMrkCol                                                 RADDAT
?     *                                                                                       RADDAT
?     *  F9  - Positionieren auf Datensatz                                                    RADDAT
     C     YPgmCmd       WHENEQ    '*MOVETOP'                                                 RADDAT
     C                   EXSR      C_MoveTop                                                  RADDAT
?     *                                                                                       RADDAT
?     *  F10 - Eingabe Aufsetzkey                                                             RADDAT
     C     YPgmCmd       WHENEQ    '*POSCSR'                                                  RADDAT
     C                   EXSR      C_PosCsr                                                   RADDAT
?     *                                                                                       RADDAT
?     *  F11 - Benutzereinstellungen                                                          RADDAT
     C     YPgmCmd       WHENEQ    '*USERSETG'                                                RADDAT
     C                   EXSR      C_UserSetg                                                 RADDAT
?     *                                                                                       RADDAT
?     *  F12 - Programm beenden                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*CANCEL'                                                  RADDAT
     C                   EXSR      C_EndPgm                                                   RADDAT
 B02 C     IsOpen        IFEQ      bFalse                                                     RADDAT
     C                   GOTO      ENDE                                                       RADDAT
 X02 C                   ELSE                                                                 RADDAT
?     *              Weiter machen                                                            RADDAT
 E02 C                   ENDIF                                                                RADDAT
?     *                                                                                       RADDAT
?     *  F13 - Wiederholen                                                                    RADDAT
     C     YPgmCmd       WHENEQ    '*REPEAT'                                                  RADDAT
     C                   EXSR      C_Repeat                                                   RADDAT
?     *                                                                                       RADDAT
?     *  F15 - Layout                                                                         RADDAT
     C     YPgmCmd       WHENEQ    '*LAYOUT'                                                  RADDAT
     C                   EXSR      C_Layout                                                   RADDAT
?     *                                                                                       RADDAT
?     *  F16 - Suchen                                                                         RADDAT
     C     YPgmCmd       WHENEQ    '*SEARCH'                                                  RADDAT
     C                   EXSR      C_Search                                                   RADDAT
?     *                                                                                       RADDAT
?     *  F17 - Anfang der Datei                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*TOP'                                                     RADDAT
     C                   EXSR      C_Top                                                      RADDAT
?     *                                                                                       RADDAT
?     *  F18 - Ende der Datei                                                                 RADDAT
     C     YPgmCmd       WHENEQ    '*BOT'                                                     RADDAT
     C                   EXSR      C_Bot                                                      RADDAT
?     *                                                                                       RADDAT
?     *  F19 - nach rechts verschieben (ein Feld)                                             RADDAT
     C     YPgmCmd       WHENEQ    '*LEFT'                                                    RADDAT
     C                   EXSR      C_MoveL                                                    RADDAT
?     *                                                                                       RADDAT
?     *  F20 - nach links verschieben  (ein Feld)                                             RADDAT
     C     YPgmCmd       WHENEQ    '*RIGHT'                                                   RADDAT
     C                   EXSR      C_MoveR                                                    RADDAT
?     *                                                                                       RADDAT
?     *  F19 - nach rechts verschieben (eine Seite)                                           RADDAT
     C     YPgmCmd       WHENEQ    '*PAGELEFT'                                                RADDAT
     C                   EXSR      C_PageL                                                    RADDAT
?     *                                                                                       RADDAT
?     *  F20 - nach links verschieben  (eine Seite)                                           RADDAT
     C     YPgmCmd       WHENEQ    '*PAGERIGHT'                                               RADDAT
     C                   EXSR      C_PageR                                                    RADDAT
?     *                                                                                       RADDAT
?     *  F21 - OS/400 Befehlzeile                                                             RADDAT
     C     YPgmCmd       WHENEQ    '*CMDLINE'                                                 RADDAT
     C                   EXSR      C_CmdLine                                                  RADDAT
?     *                                                                                       RADDAT
?     *  F22 - Bildschirmauflösung 132/80                                                     RADDAT
     C     YPgmCmd       WHENEQ    '*132/80'                                                  RADDAT
     C                   EXSR      C_ChgScn                                                   RADDAT
?     *                                                                                       RADDAT
?     *  F23 - weitere Auswahlen                                                              RADDAT
     C     YPgmCmd       WHENEQ    '*MOREOPT'                                                 RADDAT
     C                   EXSR      C_MoreOpt                                                  RADDAT
?     *                                                                                       RADDAT
?     *  F24 - weitere Tasten anzeigen                                                        RADDAT
     C     YPgmCmd       WHENEQ    '*MOREKEYS'                                                RADDAT
     C                   EXSR      C_MoreKeys                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Fxx - zum nächsten markierten Feld verschieben                                       RADDAT
     C     YPgmCmd       WHENEQ    '*NEXTMARK'                                                RADDAT
     C                   EXSR      C_NextMark                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Fxx - zum vorherigen markierten Feld verschieben                                     RADDAT
     C     YPgmCmd       WHENEQ    '*PREVMARK'                                                RADDAT
     C                   EXSR      C_PrevMark                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Fxx - anzeigen der Datenbankrelationen                                               RADDAT
     C     YPgmCmd       WHENEQ    '*DSPDBR'                                                  RADDAT
     C                   EXSR      C_DspDbr                                                   RADDAT
?     *                                                                                       RADDAT
?     *  Fxx - Pin-Dialog
     C     YPgmCmd       WHENEQ    '*PINCOLDLG'
     C                   EXSR      C_PinCDlg
?     *                                                                                       RADDAT
?     *  vorwärts blättern                                                                    RADDAT
     C     YPgmCmd       WHENEQ    '*PAGEUP'                                                  RADDAT
     C                   EXSR      C_PageUp                                                   RADDAT
?     *                                                                                       RADDAT
?     *  rückwärts blättern                                                                   RADDAT
     C     YPgmCmd       WHENEQ    '*PAGEDOWN'                                                RADDAT
     C                   EXSR      C_PageDown                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Datenfreigabe                                                                        RADDAT
     C     YPgmCmd       WHENEQ    '*ENTER'                                                   RADDAT
     C                   EXSR      C_Enter
?     *                                                                                       RADDAT
?     *  Programm neu erstellen                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*REBUILD'                                                 RADDAT
     C                   EXSR      C_BuildPgm                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Löschen Pin-Tabelle für Zeilen                                                       RADDAT
     C     YPgmCmd       WHENEQ    '*CLRPINROW'                                               RADDAT
     C                   EXSR      C_ClrPinRw                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Löschen Pin-Tabelle für Spalten                                                      RADDAT
     C     YPgmCmd       WHENEQ    '*CLRPINCOL'                                               RADDAT
     C                   EXSR      C_ClrPinCl                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Sortierung in Schlüsselfolge                                                         RADDAT
     C     YPgmCmd       WHENEQ    '*KEY'                                                     RADDAT
     C                   EXSR      C_SortBKey                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Sortierung in Satzfolge                                                              RADDAT
     C     YPgmCmd       WHENEQ    '*RRN'                                                     RADDAT
     C                   EXSR      C_SortBRrn                                                 RADDAT
?     *                                                                                       RADDAT
?     *  Umschalten der Sortierung                                                            RADDAT
     C     YPgmCmd       WHENEQ    '*TGLACCESS'                                               RADDAT
     C                   EXSR      C_SortTgl                                                  RADDAT
?     *  SQL-Select ...
     C     YPgmCmd       WHENEQ    '*SQL'                                                     RADDAT
     C                   EXSR      C_Sql
?     *                                                                                       RADDAT
?     *  Nix tun                                                                              RADDAT
     C     YPgmCmd       WHENEQ    '*NONE'                                                    RADDAT
?     *          keinen Befehl ausführen                                                      RADDAT
?     *---------------------------------------*                                               RADDAT
?     *  Ändern Datensatz ...                                                                 RADDAT
     C     YPgmCmd       WHENEQ    '*CHANGE'                                                  RADDAT
     C                   EXSR      S_Change                                                   RADDAT
?     *  Kopieren Datensatz ...                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*COPY'                                                    RADDAT
     C                   EXSR      S_Copy                                                     RADDAT
?     *  Löschen Datensatz ...                                                                RADDAT
     C     YPgmCmd       WHENEQ    '*DELETE'                                                  RADDAT
     C                   EXSR      S_Delete                                                   RADDAT
?     *  Anzeigen Datensatz ...                                                               RADDAT
     C     YPgmCmd       WHENEQ    '*DISPLAY'                                                 RADDAT
     C                   EXSR      S_Display                                                  RADDAT
?     *  Drucken Datensatz ...                                                                RADDAT
     C     YPgmCmd       WHENEQ    '*PRINT'                                                   RADDAT
     C                   EXSR      S_Print                                                    RADDAT
?     *  Pin-Datensatz ...                                                                    RADDAT
     C     YPgmCmd       WHENEQ    '*PINROW'                                                  RADDAT
     C                   EXSR      S_PinRcd                                                   RADDAT
?     *  UnPin-Datensatz ...                                                                  RADDAT
     C     YPgmCmd       WHENEQ    '*UNPINROW'                                                RADDAT
     C                   EXSR      S_UnPinRcd                                                 RADDAT
?     *  Pin-Spalte ...                                                                       RADDAT
     C     YPgmCmd       WHENEQ    '*PINCOL'                                                  RADDAT
     C                   EXSR      S_PinCol                                                   RADDAT
?     *  UnPin-Spalte ...                                                                     RADDAT
     C     YPgmCmd       WHENEQ    '*UNPINCOL'                                                RADDAT
     C                   EXSR      S_UnPinCol                                                 RADDAT
?     *  UnPin-Spalte, umschalten ...                                                         RADDAT
     C     YPgmCmd       WHENEQ    '*TGLPINCOL'                                               RADDAT
     C                   EXSR      S_TgPinCol                                                 RADDAT
?     *  Tabellierpapier einschalten ...                                                      RADDAT
     C     YPgmCmd       WHENEQ    '*TBLPAPON'                                                RADDAT
     C                   EXSR      S_TblPapOn                                                 RADDAT
?     *  Tabellierpapier ausschalten ...                                                      RADDAT
     C     YPgmCmd       WHENEQ    '*TBLPAPOFF'                                               RADDAT
     C                   EXSR      S_TblPapOf                                                 RADDAT
?     *  Tabellierpapier umschalten ...                                                       RADDAT
     C     YPgmCmd       WHENEQ    '*TGLTBLPAP'                                               RADDAT
     C                   EXSR      S_TgTblPap                                                 RADDAT
?     *  In extrene Datei kopieren ...                                                        RADDAT
     C     YPgmCmd       WHENEQ    '*COPYEXT'                                                 RADDAT
     C                   EXSR      S_CopyExt                                                  RADDAT
?     *  Splash-Screen Einschalten ...                                                        RADDAT
     C     YPgmCmd       WHENEQ    '*SPLASHON'                                                RADDAT
     C                   EXSR      S_SplashOn                                                 RADDAT
?     *  Splash-Screen Ausschalten ...                                                        RADDAT
     C     YPgmCmd       WHENEQ    '*SPLASHOFF'                                               RADDAT
     C                   EXSR      S_SplashOf                                                 RADDAT
?     *  Ausführen Kurzbefehl ...                                                             RADDAT
     C     YPgmCmd       WHENEQ    '*CMD'                                                     RADDAT
     C                   EXSR      S_ShortCmd                                                 RADDAT
?     *  Anzeigen "About" ...
     C     YPgmCmd       WHENEQ    '*ABOUT'                                                   RADDAT
     C                   EXSR      S_About
?     *  Hex-Anzeige ...
     C     YPgmCmd       WHENEQ    '*DSPHEX'                                                  RADDAT
     C                   EXSR      S_DspHex
?     *  Normale-Anzeige ...
     C     YPgmCmd       WHENEQ    '*DSPNRM'                                                  RADDAT
     C                   EXSR      S_DspNrm
?     *  Umschalten-Anzeige ...
     C     YPgmCmd       WHENEQ    '*TGLDSP'                                                  RADDAT
     C                   EXSR      S_DspTgl
?     *  Sichern Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*SAVEENV'
     C                   EXSR      S_SaveEnv
?     *  Laden Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*LOADENV'
     C                   EXSR      S_LoadEnv
?     *  Löschen Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*DELETEENV'
     C                   EXSR      S_DelEnv
?     *  Umschalten Eingabe der Schlüsselfelder ...                                           RADDAT
     C     YPgmCmd       WHENEQ    '*TGLKEYLUC'                                               RADDAT
     C                   EXSR      S_TglKeyLC_UC                                              RADDAT
     C                   EXSR      C_PosCsr                                                   RADDAT
?     *
 X01 C                   OTHER                                                                RADDAT
?     *  Unbekannter Programmbefehl                                                           RADDAT
     C                   MOVEL (P) bTrue         IsCmdErr                                     RADDAT
     C                   MOVEL (P) 'USR8110'     §MsgID                                       RADDAT
     C                   MOVEL (P) YPgmCmd       USR81101                                     RADDAT
     C                   MOVEL (P) USR8110       §MsgDta                                      RADDAT
 E01 C                   ENDSL                                                                RADDAT
?     *                                                                                       RADDAT
