         // The following statements must be included as a /copy book
         // to avoid infinite loops when executing commands from
         // c_readsfl -> doSlfCmd.

          isCancel = bFalse;
          isCmdErr = bFalse;

          select;

          when ypgmcmd = '*EXIT';      //  F3  - Programm beenden
             exsr c_endpgm;
             if isopen = bfalse;
                // Programm beenden
             else;
                // Weiter machen
                ypgmcmd = '';
             endif;
          when ypgmcmd = '*PROMPT';    //  F4  - Prompt
             exsr c_prompt;
             if (*in93 = btrue);
                exsr c_enter;
             endif;
          when ypgmcmd = '*REFRESH';   //  F5  - Anzeige aktualisieren
             exsr c_refresh;
          when ypgmcmd = '*ADD';       //  F6  - Neuanlage Datensatz
             exsr c_add;
          when ypgmcmd = '*HEADLINE';  //  F7  - Umschalten der Überschrift
             exsr c_chghead;
          when ypgmcmd = '*MRKCOL';    //  F8  - Spalte markieren, ein
             exsr c_mrkcol;
          when ypgmcmd = '*UNMRKCOL';
             exsr c_unmrkcol;
          when ypgmcmd = '*TGLMRKCOL'; //      - Spalte markieren, ein/aus
             exsr c_tgmrkcol;
          when ypgmcmd = '*MOVETOP';   //  F9  - Positionieren auf Datensatz
             exsr c_movetop;
          when ypgmcmd = '*POSCSR';
             exsr c_poscsr;
          when ypgmcmd = '*USERSETG';  //  F11 - Benutzereinstellungen
             exsr c_usersetg;
          when ypgmcmd = '*CANCEL';    //  F12 - Programm beenden
             exsr c_endpgm;
             if isopen = bfalse;
                // Programm beenden
             else;
                // Weiter machen
                ypgmcmd = '';
             endif;
          when ypgmcmd = '*REPEAT';    //  F13 - Wiederholen
             exsr c_repeat;
          when ypgmcmd = '*LAYOUT';    //  F15 - Layout
             exsr c_layout;
          when ypgmcmd = '*SEARCH';    //  F16 - Suchen
             exsr c_search;
          when ypgmcmd = '*TOP';       //  F17 - Anfang der Datei
             exsr c_top;
          when ypgmcmd = '*BOT';       //  F18 - Ende der Datei
             exsr c_bot;
          when ypgmcmd = '*LEFT';      //  F19 - nach rechts verschieben (ein Feld)
             exsr c_movel;
          when ypgmcmd = '*RIGHT';     //  F20 - nach links verschieben  (ein Feld)
             exsr c_mover;
          when ypgmcmd = '*PAGELEFT';  //  F19 - nach rechts verschieben (eine Seite)
             exsr c_pageleft;
          when ypgmcmd = '*PAGERIGHT'; //  F20 - nach links verschieben  (eine Seite)
             exsr c_pageright;
          when ypgmcmd = '*CMDLINE';   //  F21 - OS/400 Befehlzeile
             exsr c_cmdline;
          when ypgmcmd = '*132/80';    //  F22 - Bildschirmauflösung 132/80
             exsr c_chgscn;
          when ypgmcmd = '*MOREOPT';   //  F23 - weitere Auswahlen
             exsr c_moreopt;
          when ypgmcmd = '*MOREKEYS';  //  F24 - weitere Tasten anzeigen
             exsr c_morekeys;
          when ypgmcmd = '*NEXTMARK';  //  Fxx - zum nächsten markierten Feld verschieben
             exsr c_nextmark;
          when ypgmcmd = '*PREVMARK';  //  Fxx - zum vorherigen markierten Feld verschieben
             exsr c_prevmark;
          when ypgmcmd = '*DSPDBR';    //  Fxx - anzeigen der Datenbankrelationen
             exsr c_dspdbr;
          when ypgmcmd = '*PINCOLDLG'; //  Fxx - Pin-Dialog
             exsr c_pincdlg;
          when ypgmcmd = '*PAGEUP';    //  vorwärts blättern
             exsr c_pageup;
          when ypgmcmd = '*PAGEDOWN';  //  rückwärts blättern
             exsr c_pagedown;
          when ypgmcmd = '*ENTER';     //  Datenfreigabe
             exsr c_enter;
          when ypgmcmd = '*REBUILD';   //  Programm neu erstellen
             exsr c_buildpgm;
          when ypgmcmd = '*CLRPINROW'; //  Löschen Pin-Tabelle für Zeilen
             exsr c_clrpinrw;
          when ypgmcmd = '*CLRPINCOL'; //  Löschen Pin-Tabelle für Spalten
             exsr c_clrpincl;
          when ypgmcmd = '*KEY';       //  Sortierung in Schlüsselfolge
             exsr c_sortbkey;
          when ypgmcmd = '*RRN';       //  Sortierung in Satzfolge
             exsr c_sortbrrn;
          when ypgmcmd = '*TGLACCESS'; //  Umschalten der Sortierung
             exsr c_sorttgl;
          when ypgmcmd = '*SQL';       //  SQL-Select ...
             exsr c_sql;
          when ypgmcmd = '*NONE';      //  Nix tun
             // keinen Befehl ausführen
          when ypgmcmd = '*CHANGE';    //  Ändern Datensatz ...
             exsr s_change;
          when ypgmcmd = '*COPY';      //  Kopieren Datensatz ...
             exsr s_copy;
          when ypgmcmd = '*DELETE';    //  Löschen Datensatz ...
             exsr s_delete;
          when ypgmcmd = '*DISPLAY';   //  Anzeigen Datensatz ...
             exsr s_display;
          when ypgmcmd = '*PRINT';     //  Drucken Datensatz ...
             exsr s_print;
          when ypgmcmd = '*PINROW';    //  Pin-Datensatz ...
             exsr s_pinrcd;
          when ypgmcmd = '*UNPINROW';  //  UnPin-Datensatz ...
             exsr s_unpinrcd;
          when ypgmcmd = '*PINCOL';    //  Pin-Spalte ...
             exsr s_pincol;
          when ypgmcmd = '*UNPINCOL';  //  UnPin-Spalte ...
             exsr s_unpincol;
          when ypgmcmd = '*TGLPINCOL'; //  UnPin-Spalte, umschalten ...
             exsr s_tgpincol;
          when ypgmcmd = '*TBLPAPON';  //  Tabellierpapier einschalten ...
             exsr s_tblpapon;
          when ypgmcmd = '*TBLPAPOFF'; //  Tabellierpapier ausschalten ...
             exsr s_tblpapof;
          when ypgmcmd = '*TGLTBLPAP'; //  Tabellierpapier umschalten ...
             exsr s_tgtblpap;
          when ypgmcmd = '*COPYEXT';   //  In extrene Datei kopieren ...
             exsr s_copyext;
          when ypgmcmd = '*SPLASHON';  //  Splash-Screen Einschalten ...
             exsr s_splashon;
          when ypgmcmd = '*SPLASHOFF'; //  Splash-Screen Ausschalten ...
             exsr s_splashof;
          when ypgmcmd = '*CMD';       //  Ausführen Kurzbefehl ...
             exsr s_shortcmd;
          when ypgmcmd = '*ABOUT';     //  Anzeigen "About" ...
             exsr s_about;
          when ypgmcmd = '*DSPHEX';    //  Hex-Anzeige ...
             exsr s_dsphex;
          when ypgmcmd = '*DSPNRM';    //  Normale-Anzeige ...
             exsr s_dspnrm;
          when ypgmcmd = '*TGLDSP';    //  Umschalten-Anzeige ...
             exsr s_dsptgl;
          when ypgmcmd = '*SAVEENV';   //  Sichern Arbeitsumgebung ...
             exsr s_saveenv;
          when ypgmcmd = '*LOADENV';   //  Laden Arbeitsumgebung ...
             exsr s_loadenv;
          when ypgmcmd = '*DELETEENV'; //  Löschen Arbeitsumgebung ...
             exsr s_delenv;
          when ypgmcmd = '*TGLKEYLUC'; //  Umschalten Eingabe der Schlüsselfelder ...
             exsr s_tglkeylc_uc;
             exsr c_poscsr;
          other;
             //  Unbekannter Programmbefehl
             clear usr8110;
             usr8110.var1 = ypgmcmd;
             p_sndpgmmg('USR8110': usr8110: sds.pgmname);
             iscmderr = btrue;
          endsl;

