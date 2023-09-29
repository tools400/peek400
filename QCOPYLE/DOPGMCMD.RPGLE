      *
      *============================================================*
      *    Auswerten Programmbefehle                               *
      *============================================================*
      *
     C                   MOVEL (P) bFalse        IsCancel
     C                   MOVEL (P) bFalse        IsCmdErr
      *
     C                   SELECT
      *---------------------------------------*
      *  F3  - Programm beenden
     C     YPgmCmd       WHENEQ    '*EXIT'
     C                   EXSR      C_EndPgm
     C     IsOpen        IFEQ      bFalse
     C                   GOTO      ENDE
     C                   ELSE
      *              Weiter machen
     C                   ENDIF
      *
      *  F4  - Prompt
     C     YPgmCmd       WHENEQ    '*PROMPT'
     C                   EXSR      C_Prompt
     C                   IF        (*IN93 = bTrue)
     C                   EXSR      C_Enter
     C                   ENDIF
      *
      *  F5  - Anzeige aktualisieren
     C     YPgmCmd       WHENEQ    '*REFRESH'
     C                   EXSR      C_Refresh
      *
      *  F6  - Neuanlage Datensatz
     C     YPgmCmd       WHENEQ    '*ADD'
     C                   EXSR      C_Add
      *
      *  F7  - Umschalten der Überschrift
     C     YPgmCmd       WHENEQ    '*HEADLINE'
     C                   EXSR      C_ChgHead
      *
      *  F8  - Spalte markieren, ein
     C     YPgmCmd       WHENEQ    '*MRKCOL'
     C                   EXSR      C_MrkCol
      *
      *      - Spalte markieren, aus
     C     YPgmCmd       WHENEQ    '*UNMRKCOL'
     C                   EXSR      C_UnMrkCol
      *
      *      - Spalte markieren, ein/aus
     C     YPgmCmd       WHENEQ    '*TGLMRKCOL'
     C                   EXSR      C_TgMrkCol
      *
      *  F9  - Positionieren auf Datensatz
     C     YPgmCmd       WHENEQ    '*MOVETOP'
     C                   EXSR      C_MoveTop
      *
      *  F10 - Eingabe Aufsetzkey
     C     YPgmCmd       WHENEQ    '*POSCSR'
     C                   EXSR      C_PosCsr
      *
      *  F11 - Benutzereinstellungen
     C     YPgmCmd       WHENEQ    '*USERSETG'
     C                   EXSR      C_UserSetg
      *
      *  F12 - Programm beenden
     C     YPgmCmd       WHENEQ    '*CANCEL'
     C                   EXSR      C_EndPgm
     C     IsOpen        IFEQ      bFalse
     C                   GOTO      ENDE
     C                   ELSE
      *              Weiter machen
     C                   ENDIF
      *
      *  F13 - Wiederholen
     C     YPgmCmd       WHENEQ    '*REPEAT'
     C                   EXSR      C_Repeat
      *
      *  F15 - Layout
     C     YPgmCmd       WHENEQ    '*LAYOUT'
     C                   EXSR      C_Layout
      *
      *  F16 - Suchen
     C     YPgmCmd       WHENEQ    '*SEARCH'
     C                   EXSR      C_Search
      *
      *  F17 - Anfang der Datei
     C     YPgmCmd       WHENEQ    '*TOP'
     C                   EXSR      C_Top
      *
      *  F18 - Ende der Datei
     C     YPgmCmd       WHENEQ    '*BOT'
     C                   EXSR      C_Bot
      *
      *  F19 - nach rechts verschieben (ein Feld)
     C     YPgmCmd       WHENEQ    '*LEFT'
     C                   EXSR      C_MoveL
      *
      *  F20 - nach links verschieben  (ein Feld)
     C     YPgmCmd       WHENEQ    '*RIGHT'
     C                   EXSR      C_MoveR
      *
      *  F19 - nach rechts verschieben (eine Seite)
     C     YPgmCmd       WHENEQ    '*PAGELEFT'
     C                   EXSR      C_PageL
      *
      *  F20 - nach links verschieben  (eine Seite)
     C     YPgmCmd       WHENEQ    '*PAGERIGHT'
     C                   EXSR      C_PageR
      *
      *  F21 - OS/400 Befehlzeile
     C     YPgmCmd       WHENEQ    '*CMDLINE'
     C                   EXSR      C_CmdLine
      *
      *  F22 - Bildschirmauflösung 132/80
     C     YPgmCmd       WHENEQ    '*132/80'
     C                   EXSR      C_ChgScn
      *
      *  F23 - weitere Auswahlen
     C     YPgmCmd       WHENEQ    '*MOREOPT'
     C                   EXSR      C_MoreOpt
      *
      *  F24 - weitere Tasten anzeigen
     C     YPgmCmd       WHENEQ    '*MOREKEYS'
     C                   EXSR      C_MoreKeys
      *
      *  Fxx - zum nächsten markierten Feld verschieben
     C     YPgmCmd       WHENEQ    '*NEXTMARK'
     C                   EXSR      C_NextMark
      *
      *  Fxx - zum vorherigen markierten Feld verschieben
     C     YPgmCmd       WHENEQ    '*PREVMARK'
     C                   EXSR      C_PrevMark
      *
      *  Fxx - anzeigen der Datenbankrelationen
     C     YPgmCmd       WHENEQ    '*DSPDBR'
     C                   EXSR      C_DspDbr
      *
      *  Fxx - Pin-Dialog
     C     YPgmCmd       WHENEQ    '*PINCOLDLG'
     C                   EXSR      C_PinCDlg
      *
      *  vorwärts blättern
     C     YPgmCmd       WHENEQ    '*PAGEUP'
     C                   EXSR      C_PageUp
      *
      *  rückwärts blättern
     C     YPgmCmd       WHENEQ    '*PAGEDOWN'
     C                   EXSR      C_PageDown
      *
      *  Datenfreigabe
     C     YPgmCmd       WHENEQ    '*ENTER'
     C                   EXSR      C_Enter
      *
      *  Programm neu erstellen
     C     YPgmCmd       WHENEQ    '*REBUILD'
     C                   EXSR      C_BuildPgm
      *
      *  Löschen Pin-Tabelle für Zeilen
     C     YPgmCmd       WHENEQ    '*CLRPINROW'
     C                   EXSR      C_ClrPinRw
      *
      *  Löschen Pin-Tabelle für Spalten
     C     YPgmCmd       WHENEQ    '*CLRPINCOL'
     C                   EXSR      C_ClrPinCl
      *
      *  Sortierung in Schlüsselfolge
     C     YPgmCmd       WHENEQ    '*KEY'
     C                   EXSR      C_SortBKey
      *
      *  Sortierung in Satzfolge
     C     YPgmCmd       WHENEQ    '*RRN'
     C                   EXSR      C_SortBRrn
      *
      *  Umschalten der Sortierung
     C     YPgmCmd       WHENEQ    '*TGLACCESS'
     C                   EXSR      C_SortTgl
      *  SQL-Select ...
     C     YPgmCmd       WHENEQ    '*SQL'
     C                   EXSR      C_Sql
      *
      *  Nix tun
     C     YPgmCmd       WHENEQ    '*NONE'
      *          keinen Befehl ausführen
      *---------------------------------------*
      *  Ändern Datensatz ...
     C     YPgmCmd       WHENEQ    '*CHANGE'
     C                   EXSR      S_Change
      *  Kopieren Datensatz ...
     C     YPgmCmd       WHENEQ    '*COPY'
     C                   EXSR      S_Copy
      *  Löschen Datensatz ...
     C     YPgmCmd       WHENEQ    '*DELETE'
     C                   EXSR      S_Delete
      *  Anzeigen Datensatz ...
     C     YPgmCmd       WHENEQ    '*DISPLAY'
     C                   EXSR      S_Display
      *  Drucken Datensatz ...
     C     YPgmCmd       WHENEQ    '*PRINT'
     C                   EXSR      S_Print
      *  Pin-Datensatz ...
     C     YPgmCmd       WHENEQ    '*PINROW'
     C                   EXSR      S_PinRcd
      *  UnPin-Datensatz ...
     C     YPgmCmd       WHENEQ    '*UNPINROW'
     C                   EXSR      S_UnPinRcd
      *  Pin-Spalte ...
     C     YPgmCmd       WHENEQ    '*PINCOL'
     C                   EXSR      S_PinCol
      *  UnPin-Spalte ...
     C     YPgmCmd       WHENEQ    '*UNPINCOL'
     C                   EXSR      S_UnPinCol
      *  UnPin-Spalte, umschalten ...
     C     YPgmCmd       WHENEQ    '*TGLPINCOL'
     C                   EXSR      S_TgPinCol
      *  Tabellierpapier einschalten ...
     C     YPgmCmd       WHENEQ    '*TBLPAPON'
     C                   EXSR      S_TblPapOn
      *  Tabellierpapier ausschalten ...
     C     YPgmCmd       WHENEQ    '*TBLPAPOFF'
     C                   EXSR      S_TblPapOf
      *  Tabellierpapier umschalten ...
     C     YPgmCmd       WHENEQ    '*TGLTBLPAP'
     C                   EXSR      S_TgTblPap
      *  In extrene Datei kopieren ...
     C     YPgmCmd       WHENEQ    '*COPYEXT'
     C                   EXSR      S_CopyExt
      *  Splash-Screen Einschalten ...
     C     YPgmCmd       WHENEQ    '*SPLASHON'
     C                   EXSR      S_SplashOn
      *  Splash-Screen Ausschalten ...
     C     YPgmCmd       WHENEQ    '*SPLASHOFF'
     C                   EXSR      S_SplashOf
      *  Ausführen Kurzbefehl ...
     C     YPgmCmd       WHENEQ    '*CMD'
     C                   EXSR      S_ShortCmd
      *  Anzeigen "About" ...
     C     YPgmCmd       WHENEQ    '*ABOUT'
     C                   EXSR      S_About
      *  Hex-Anzeige ...
     C     YPgmCmd       WHENEQ    '*DSPHEX'
     C                   EXSR      S_DspHex
      *  Normale-Anzeige ...
     C     YPgmCmd       WHENEQ    '*DSPNRM'
     C                   EXSR      S_DspNrm
      *  Umschalten-Anzeige ...
     C     YPgmCmd       WHENEQ    '*TGLDSP'
     C                   EXSR      S_DspTgl
      *  Sichern Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*SAVEENV'
     C                   EXSR      S_SaveEnv
      *  Laden Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*LOADENV'
     C                   EXSR      S_LoadEnv
      *  Löschen Arbeitsumgebung ...
     C     YPgmCmd       WHENEQ    '*DELETEENV'
     C                   EXSR      S_DelEnv
      *  Umschalten Eingabe der Schlüsselfelder ...
     C     YPgmCmd       WHENEQ    '*TGLKEYLUC'
     C                   EXSR      S_TglKeyLC_UC
     C                   EXSR      C_PosCsr
      *
     C                   OTHER
      *  Unbekannter Programmbefehl
     C                   CLEAR                   USR8110
     C                   EVAL      USR81101 = YPgmCmd
     C                   Callp     p_sndPgmMg('USR8110': USR8110: §§pgmName)
     C                   EVAL      IsCmdErr = bTrue
     C                   ENDSL
      *
