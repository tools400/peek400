**free
// The following statements must be included as a /copy book
// to avoid infinite loops when executing commands from
// c_readsfl -> doSlfCmd.

isCancel = bFalse;
IsCmdErr = bFalse;

select;

when (YPgmCmd = '*EXIT');      //  F3  - Programm beenden
  exsr C_EndPgm;
  if (IsOpen = bFalse);
  // Programm beenden
  else;
    // Weiter machen
    YPgmCmd = '';
  endif;
when (YPgmCmd = '*PROMPT');    //  F4  - Prompt
  exsr C_Prompt;
  if (*in93 = bTrue);
    exsr C_Enter;
  endif;
when (YPgmCmd = '*REFRESH');   //  F5  - Anzeige aktualisieren
  exsr C_Refresh;
when (YPgmCmd = '*ADD');       //  F6  - Neuanlage Datensatz
  exsr C_Add;
when (YPgmCmd = '*HEADLINE');  //  F7  - Umschalten der Überschrift
  exsr C_ChgHead;
when (YPgmCmd = '*MRKCOL');    //  F8  - Spalte markieren, ein
  exsr C_MrkCol;
when (YPgmCmd = '*UNMRKCOL');
  exsr C_UnMrkCol;
when (YPgmCmd = '*TGLMRKCOL'); //      - Spalte markieren, ein/aus
  exsr C_TgMrkCol;
when (YPgmCmd = '*MOVETOP');   //  F9  - Positionieren auf Datensatz
  exsr C_MoveTop;
when (YPgmCmd = '*POSCSR');
  exsr C_PosCsr;
when (YPgmCmd = '*USERSETG');  //  F11 - Benutzereinstellungen
  exsr C_UserSetg;
when (YPgmCmd = '*CANCEL');    //  F12 - Programm beenden
  exsr C_EndPgm;
  if (IsOpen = bFalse);
  // Programm beenden
  else;
    // Weiter machen
    YPgmCmd = '';
  endif;
when (YPgmCmd = '*REPEAT');    //  F13 - Wiederholen
  exsr C_Repeat;
when (YPgmCmd = '*LAYOUT');    //  F15 - Layout
  exsr C_Layout;
when (YPgmCmd = '*SEARCH');    //  F16 - Suchen
  exsr C_Search;
when (YPgmCmd = '*TOP');       //  F17 - Anfang der Datei
  exsr C_Top;
when (YPgmCmd = '*BOT');       //  F18 - Ende der Datei
  exsr C_Bot;
when (YPgmCmd = '*LEFT');      //  F19 - nach rechts verschieben (ein Feld)
  exsr C_MoveL;
when (YPgmCmd = '*RIGHT');     //  F20 - nach links verschieben  (ein Feld)
  exsr C_MoveR;
when (YPgmCmd = '*PAGELEFT');  //  F19 - nach rechts verschieben (eine Seite)
  exsr c_pageLeft;
when (YPgmCmd = '*PAGERIGHT'); //  F20 - nach links verschieben  (eine Seite)
  exsr c_pageRight;
when (YPgmCmd = '*CMDLINE');   //  F21 - OS/400 Befehlzeile
  exsr C_CmdLine;
when (YPgmCmd = '*132/80');    //  F22 - Bildschirmauflösung 132/80
  exsr C_ChgScn;
when (YPgmCmd = '*MOREOPT');   //  F23 - weitere Auswahlen
  exsr C_MoreOpt;
when (YPgmCmd = '*MOREKEYS');  //  F24 - weitere Tasten anzeigen
  exsr C_MoreKeys;
when (YPgmCmd = '*NEXTMARK');  //  Fxx - zum nächsten markierten Feld verschieben
  exsr C_NextMark;
when (YPgmCmd = '*PREVMARK');  //  Fxx - zum vorherigen markierten Feld verschieben
  exsr C_PrevMark;
when (YPgmCmd = '*DSPDBR');    //  Fxx - anzeigen der Datenbankrelationen
  exsr C_DspDbr;
when (YPgmCmd = '*PINCOLDLG'); //  Fxx - Pin-Dialog
  exsr C_PinCDlg;
when (YPgmCmd = '*PAGEUP');    //  vorwärts blättern
  exsr c_pageUp;
when (YPgmCmd = '*PAGEDOWN');  //  rückwärts blättern
  exsr c_pageDown;
when (YPgmCmd = '*ENTER');     //  Datenfreigabe
  exsr C_Enter;
when (YPgmCmd = '*REBUILD');   //  Programm neu erstellen
  exsr C_BuildPgm;
when (YPgmCmd = '*CLRPINROW'); //  Löschen Pin-Tabelle für Zeilen
  exsr C_ClrPinRw;
when (YPgmCmd = '*CLRPINCOL'); //  Löschen Pin-Tabelle für Spalten
  exsr C_ClrPinCl;
when (YPgmCmd = '*KEY');       //  Sortierung in Schlüsselfolge
  exsr C_SortBKey;
when (YPgmCmd = '*RRN');       //  Sortierung in Satzfolge
  exsr C_SortBRrn;
when (YPgmCmd = '*TGLACCESS'); //  Umschalten der Sortierung
  exsr C_SortTgl;
when (YPgmCmd = '*SQL');       //  SQL-Select ...
  exsr C_Sql;
when (YPgmCmd = '*NONE');      //  Nix tun
// keinen Befehl ausführen
when (YPgmCmd = '*CHANGE');    //  Ändern Datensatz ...
  exsr S_Change;
when (YPgmCmd = '*COPY');      //  Kopieren Datensatz ...
  exsr S_Copy;
when (YPgmCmd = '*DELETE');    //  Löschen Datensatz ...
  exsr S_Delete;
when (YPgmCmd = '*DISPLAY');   //  Anzeigen Datensatz ...
  exsr S_Display;
when (YPgmCmd = '*PRINT');     //  Drucken Datensatz ...
  exsr S_Print;
when (YPgmCmd = '*PINROW');    //  Pin-Datensatz ...
  exsr S_PinRcd;
when (YPgmCmd = '*UNPINROW');  //  UnPin-Datensatz ...
  exsr S_UnPinRcd;
when (YPgmCmd = '*PINCOL');    //  Pin-Spalte ...
  exsr S_PinCol;
when (YPgmCmd = '*UNPINCOL');  //  UnPin-Spalte ...
  exsr S_UnPinCol;
when (YPgmCmd = '*TGLPINCOL'); //  UnPin-Spalte, umschalten ...
  exsr S_TgPinCol;
when (YPgmCmd = '*TBLPAPON');  //  Tabellierpapier einschalten ...
  exsr S_TblPapOn;
when (YPgmCmd = '*TBLPAPOFF'); //  Tabellierpapier ausschalten ...
  exsr S_TblPapOf;
when (YPgmCmd = '*TGLTBLPAP'); //  Tabellierpapier umschalten ...
  exsr S_TgTblPap;
when (YPgmCmd = '*COPYEXT');   //  In extrene Datei kopieren ...
  exsr S_CopyExt;
when (YPgmCmd = '*SPLASHON');  //  Splash-Screen Einschalten ...
  exsr S_SplashOn;
when (YPgmCmd = '*SPLASHOFF'); //  Splash-Screen Ausschalten ...
  exsr S_SplashOf;
when (YPgmCmd = '*CMD');       //  Ausführen Kurzbefehl ...
  exsr S_ShortCmd;
when (YPgmCmd = '*ABOUT');     //  Anzeigen "About" ...
  exsr S_About;
when (YPgmCmd = '*DSPHEX');    //  Hex-Anzeige ...
  exsr S_DspHex;
when (YPgmCmd = '*DSPNRM');    //  Normale-Anzeige ...
  exsr S_DspNrm;
when (YPgmCmd = '*TGLDSP');    //  Umschalten-Anzeige ...
  exsr S_DspTgl;
when (YPgmCmd = '*SAVEENV');   //  Sichern Arbeitsumgebung ...
  exsr S_SaveEnv;
when (YPgmCmd = '*LOADENV');   //  Laden Arbeitsumgebung ...
  exsr S_LoadEnv;
when (YPgmCmd = '*DELETEENV'); //  Löschen Arbeitsumgebung ...
  exsr S_DelEnv;
when (YPgmCmd = '*TGLKEYLUC'); //  Umschalten Eingabe der Schlüsselfelder ...
  exsr S_TglKeyLC_UC;
  exsr C_PosCsr;
other;
  //  Unbekannter Programmbefehl
  clear usr8110;
  usr8110.var1 = YPgmCmd;
  p_sndPgmMg('USR8110': usr8110: sds.pgmName);
  IsCmdErr = bTrue;
endsl;

