**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK40                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.03.1998  Raddatz                               *
//  geändert : 06.04.1999  für Version 2.1.0                     *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Auswahl Datenbankrelation                         *
//                                                               *
//===============================================================*
// >>PRE-COMPILER<<                                              *
//   >>CRTCMD<< &LI/CRTPEEKOBJ SRCFILE(&SL/&SF) SRCMBR(&SM) +    *
//                           OBJLIB(&LI) DEVLIB(&LI) +           *
//                           SBMJOB(*NO) BNDDIR(PEEK) +          *
//                           INSTALL(*NO);                       *
//   >>EXECUTE<<                                                 *
// >>END-PRE-COMPILER<<                                          *
//===============================================================*
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek40fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,FILD0100
/copy QCOPYLE,DBRL0200
/copy QCOPYLE,KEYL0100
/copy QCOPYLE,SELL0100
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR0008
/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8172
/copy QCOPYLE,USR8194
/copy QCOPYLE,USR8209

/define internal_prototype
/copy QCOPYLE,PPEEK40
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27
/copy QCOPYLE,PPEEK39
/copy QCOPYLE,PPEEK41

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

dcl-s YChoice char(75) dim(32);
dcl-s YNbrOfCh like(int4_t) inz;

dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-ds YQFile likeds(qObj_t) inz;
dcl-s YMbr char(10) inz(*blanks);
dcl-s YData char(512) inz(*blanks);

dcl-s IsNewPos char(1) inz(bFalse);
dcl-s IsFound char(1) inz(bFalse);
dcl-s IsSflError char(1) inz(bFalse);

dcl-s rc like(int4_t) inz;
dcl-s numRel like(int4_t) inz;
dcl-s numKey like(int4_t) inz;
dcl-s numSel like(int4_t) inz;

dcl-s SflPage like(int4_t) inz;
dcl-s SFTop like(int4_t) inz;
dcl-s SflPageDDS inz(0) like(SflPage);
dcl-s SflRec inz(0) like(SflPage);
dcl-s SflNbrRcd inz(0) like(SflPage);
dcl-s sfbot like(int4_t) inz;
dcl-c NbrFKeys 2;
dcl-s Sfl_Cmd char(10) inz(*blanks);

dcl-c UNIQUE '*UNIQUE';

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek39_name like(pgmCallN_t) inz;
dcl-s peek41_name like(pgmCallN_t) inz;

dcl-s R_File inz(*blanks) like(##File);
dcl-s LstFile inz(*blanks) like(##File);
dcl-s LstNbrRcd inz(0) like(SflPage);
dcl-s sPos like(int4_t) inz;
dcl-s srchrec inz(0) like(SflPage);
//  Dateinamen der Subfile-Sätze für die Suche
dcl-s sfl_files like($$File) dim(9999);

dcl-s Wrk_SFSANR inz(*zeros) like(sfsanr);

dcl-s Buffer char(2000);

dcl-s strPos like(uint4_t) inz;

dcl-s pFile inz(*blanks) like(i_file);
dcl-s plib inz(*blanks) like(i_lib);
dcl-s pMbr inz(*blanks) like(i_mbr);
dcl-s PFmtName inz(*blanks) like(i_rcdFmt);

dcl-ds fild0100 likeds(FILD0100_t) inz;
dcl-ds keyl0100 likeds(KEYL0100_t) inz;
dcl-ds dbrl0200 likeds(dbrl0200_t) inz;
dcl-ds sell0100 likeds(SELL0100_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek40;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_file      like(file_t) const;
  i_lib       like(lib_t) const;
  i_mbr       like(mbr_t) const;
  i_rcdFmt    like(fmt_t) const;
  i_basePhyF  like(bool_t) const;
  o_file      like(file_t);
  o_lib       like(lib_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);
dcl-s do_x3 packed(7);
dcl-s do_x4 packed(7);
dcl-s do_x5 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;
if (o_msgID = '');

  //---------------------------------------------------*
  //  Schleife für Programmbearbeitung

  dow ('1');

    //  Prüfen Positionierung der Subfile
    if (sfsanr <= *zeros);
      sfsanr = 1;
    endif;

    //  Modus: DROP/FOLD
    *in86 = sflmde;

    //  Nachrichten anzeigen
    *in89 = '0';
    write msgctl;

    //  "Keine Sätze ..."
    if (*in80 = *off);
      write pbleer;
    endif;

    //  Anzeigen der Einzelauswahlen
    if (SFTop > 32
        or SFTop > YNbrOfCh);
      SFTop = 1;
    endif;
    $$choice = YChoice(SFTop);

    //  Trennlinie
    write pbbot#0;
    //  Anzeigen der Befehlstasten
    select;
    when ((sfbot = 2) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#2;
    when ((sfbot = 3) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#3;
    when ((sfbot = 4) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#4;
    when ((sfbot = 5) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#5;
    when ((sfbot = 6) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#6;
    when ((sfbot = 7) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#7;
    when ((sfbot = 8) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#8;
    when ((sfbot = 9) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#9;
    when ((sfbot = 10) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#10;
    when ((sfbot = 11) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#11;
    when ((sfbot = 12) and
       (yNbrOfKeys > NbrFKeys * (sfbot - 1)));
      write pbbot#12;
    other;
      write pbbot#1;
      sfbot = 1;
    endsl;

    //  Anzeige der Subfile
    exfmt pbctl;
    *in70 = '0';

    //  Nachrichten löschen
    p_rmvPgmMg(sds.pgmName);

    //  Aktuelle Satz-Nr.
    if (SflCsr > *zeros);
      sfsanr = SflCsr;
    endif;

    //  Mappen der gedrückten Taste
    //  in Programmbefehl
    peek21(workstn.aid: sds.pgmName
          : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
    if (YMsgID <> *blanks);
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      iter;
    endif;

    //  Abfragen der Befehlstasten
    select;
    //  F3  - Ende
    when (YPgmCmd = '*EXIT');
      exsr C_EndPgm;
      leave;

    //  F5  - Aktualisieren
    when (YPgmCmd = '*REFRESH');
      exsr C_Refresh;
      iter;

    //  F12 - Ende
    when (YPgmCmd = '*CANCEL');
      exsr C_EndPgm;
      leave;

    //  F16 - Suchen
    when (YPgmCmd = '*SEARCH');
      exsr C_Search;
      iter;

    //   F17 - Anfang Datensatz
    when (YPgmCmd = '*TOP');
      exsr C_Top;
      iter;

    //   F18 - Ende Datensatz
    when (YPgmCmd = '*BOT');
      exsr C_Bot;
      iter;

    //  F23 - Weitere Auswahlen
    when (YPgmCmd = '*MOREOPT');
      exsr C_MoreOpt;

    //  F24 - Weitere Tasten
    when (YPgmCmd = '*MOREKEYS');
      exsr C_MoreKeys;

    //  Datenfreigabe
    when (YPgmCmd = '*ENTER');
      exsr C_Enter;
      if (o_file = *blanks);
      //  ... keine Auswahl getroffen, weiter machen
      else;
        leave;
      endif;
    //  Page up
    when (YPgmCmd = '*PAGEUP');
    //  Page down
    when (YPgmCmd = '*PAGEDOWN');

    other;
      //  Falsche Taste gedrückt
      p_wrongKey(workstn.aid: sds.pgmName);
      iter;
    endsl;

  enddo;

endif;

close peek40fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr VReadC;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##File <> *blanks and IsSflError = bFalse);
    exsr C_Search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr C_Search;

  if (##File <> *blanks);
    LstFile = ##File;
    ##File = *blanks;
  endif;

  if (LstFile = *blanks);
    *in70 = '1';
    clear usr8209;
    p_sndPgmMg('USR8209': usr8209: sds.pgmName);
  else;
    exsr PosToField;
    if (IsNewPos = bTrue);
      sfsanr = Wrk_SFSANR;
    endif;
  endif;

endsr;

//============================================================*
//    PosToField    Subfile neu positionieren                 *
//============================================================*

begsr PosToField;

  if (LstFile <> R_File);
    LstNbrRcd = 0;
  endif;

  if (LstFile = *blanks);
    IsNewPos = bFalse;
    LstNbrRcd = 0;
  else;

    exsr SrchField;
    if (IsFound = bFalse);
      IsNewPos = bFalse;
      //  USR8194: Datei '&1' nicht gefunden. (##file ist schon gelöscht)
      clear usr8194;
      usr8194.var1 = LstFile;
      p_sndPgmMg('USR8194': usr8194: sds.pgmName);
    else;
      IsNewPos = bTrue;
    endif;
  endif;

  R_File = LstFile;

endsr;

//============================================================*
//    SrchField     Suchen Feld in Subfile                    *
//============================================================*

begsr SrchField;

  if (*in80 = *off);
    IsFound = bFalse;
  else;

    IsFound = bFalse;
    LstNbrRcd = LstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Dateinamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
    for srchrec = LstNbrRcd to SflNbrRcd;
      sPos = %check(' ': sfl_files(srchrec));
      if (sPos <= 0);
        sPos = 1;
      endif;

      if (LstFile  =
          %subst(sfl_files(srchrec): sPos:(f_scan(' ':
                            LstFile) - 1)));
        IsFound = bTrue;
        leave;
      endif;

    endfor;

    if (IsFound = bTrue);
      Wrk_SFSANR = srchrec;
      LstNbrRcd = srchrec;
    else;
      Wrk_SFSANR = *zeros;
      LstNbrRcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    SrchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr SrchInit;

  LstFile   = ' ';
  LstNbrRcd = 0;
  R_File    = LstFile;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr VReadC;

  IsSflError = bFalse;
  o_file = *blanks;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to SflNbrRcd;
      readc pbsfl;
      *in11 = %eof;
      if (*in11 = *on);
        leave;
      endif;

      chain SflRec pbsfl;
      *in11 = not %found;

      exsr BzToScreen;

      //  Cursorpositionierung ...
      if (IsSflError = bFalse);
        SflCsr = SflRec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Leere Auswahl wird nicht geprüft. Nur eine alte
      //  Fehlermarkierung (RI, SFLNXTCHG) wird entfernt.
      if (sfpau = *blanks);
        exsr VSfpauClr;
        exsr BzToSubf;
        update pbsfl;
        iter;
      endif;

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmName
            : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
      if (YMsgID <> *blanks);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8110': sfpau: sds.pgmName);
        exsr VSfpauErr;

        exsr BzToSubf;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      Sfl_Cmd = YPgmCmd;

      select;
      when (Sfl_Cmd = '*NONE');
      when (Sfl_Cmd = '*SELECT');
        //  Die erste Auswahl merken. Ausgeführt wird sie nur, wenn keine
        //  Zeile eine ungültige Auswahl enthält.
        if (o_file = *blanks);
          exsr VPos;
        endif;
        *in85 = '0'; // DSPATR(RI)
        exsr VSfpauChg;
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = YPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr VSfpauErr;

        exsr BzToSubf;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endsl;

      exsr BzToSubf;
      update pbsfl;
    endfor;

    //  Ungültige Auswahl: keine Auswahl übernehmen und den Cursor auf
    //  die erste fehlerhafte Zeile setzen (sfsanr wird sonst nur nach
    //  der Anzeige aus SFLCSRRRN gesetzt)
    if (IsSflError = bTrue);
      o_file = *blanks;
      sfsanr = SflCsr;
    endif;

  endif;

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = YPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  // - Subfile neu aufbauen
  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

  exsr SrchInit;

endsr;

//============================================================*
//    C_Top         F17 - Anfang der Subfile                  *
//============================================================*

begsr C_Top;

  sfsanr = 1;

endsr;

//============================================================*
//    C_Bot         F18 - Ende der Subfile                    *
//============================================================*

begsr C_Bot;

  sfsanr = SflNbrRcd;

endsr;

//============================================================*
//    C_MoreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr C_MoreOpt;

  SFTop = SFTop + 1;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr VPos;

  o_file = h_file;
  o_lib = h_lib;

endsr;

//============================================================*
//    VSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr VSfpauClr;

  sfpau = *blanks;
  *in85 = '0'; // DSPATR(RI)
  *in84 = '0'; // SFLNXTCHG

endsr;

//============================================================*
//    VSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
//============================================================*

begsr VSfpauErr;

  *in85 = '1'; // DSPATR(RI)
  exsr VSfpauChg;

endsr;

//============================================================*
//    VSfpauChg     Datensatz in Subfile als geändert         *
//                  markieren                                 *
//============================================================*

begsr VSfpauChg;

  *in84 = '1'; // SFLNXTCHG

endsr;

//============================================================*
//    PBInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr PBInit;

  *in89 = '0';
  write msgctl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbctl;

  *in82 = '0'; // SFLCLR

  SflRec = 0;
  SflNbrRcd = 0;
  $$DepFile = 0;

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  for do_x3 = 1 to numRel;

    peek39(YQFile: YMbr
          : '*READ': rc: dbrl0200);

    if (dbrl0200.B2DepFile = '*NONE');
      iter;
    endif;

    if (dbrl0200.B2DepType <> 'D');
      iter;
    endif;

    $$DepFile = $$DepFile + 1;

    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      //  ... die physische Datei anzeigen
      h_file = dbrl0200.B2FNmeUsed;
      h_lib = dbrl0200.B2LNmeUsed;
      //**                EXSR      StatMsg
      exsr PBFill;
      exsr PBFillKey;
      exsr PBFillSel;
    endif;

    //  Anzeigen der logischen Sichten
    h_file = dbrl0200.B2DepFile;
    h_lib = dbrl0200.B2DepLib;
    //**                EXSR      StatMsg
    exsr PBFill;
    exsr PBFillKey;
    exsr PBFillSel;
  endfor;

  //  Bei erstem Datensatz, ...
  if (*in80 = *off);
    //  ... die physische Datei anzeigen
    clear dbrl0200;
    h_file = i_file;
    h_lib = i_lib;
    dbrl0200.B2LNmeUsed = i_lib;
    //**                EXSR      StatMsg
    exsr PBFill;
    exsr PBFillKey;
    exsr PBFillSel;
  endif;

endsr;

//============================================================*
//    StatMsg       Statusnachricht ausgeben                  *
//============================================================*

begsr StatMsg;

  //  Nachricht ausgeben ...
  clear usr8172;
  usr8172.var1 = %trimr(h_lib) + '/' + h_file;
  p_sndStsMg('USR8172': usr8172);

endsr;

//============================================================*
//    BzToScreen    Übertragen Bezugszahlen in Bildschirm     *
//============================================================*

begsr BzToScreen;

  *in20 = h_in20;
  *in71 = h_in71;

endsr;

//============================================================*
//    BzToSubf      Übertragen Bezugszahlen in Subfile        *
//============================================================*

begsr BzToSubf;

  h_in20 = *in20;
  h_in71 = *in71;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  //  Datensatz komplett anzeigen ...
  *in71 = '0';

  //  Abhängigkeit prüfen ...
  if (dbrl0200.B2LNmeUsed = h_lib or
     *in80 = '0');
    *in20 = '0';
  else;
    *in20 = '1';
  endif;

  //  Einlesen der Dateiinformationen ...
  YQFile.name = h_file;
  YQFile.lib = h_lib;
  peek41(YQFile
        : '*FIRST': '*CREATE': rc: YData);
  //  ... Bezeichnung
  peek41(YQFile
        : '*FIRST': '*READTEXT': rc: YData);
  $$ftxt = YData;

  //  Schreiben der Subfile ...
  exsr PbWrite;

endsr;

//============================================================*
//    PBFillKey     Füllen Subfilesatz, Schlüsselfelder       *
//============================================================*

begsr PBFillKey;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Schlüsselinformationen ...
  peek41(YQFile
        : '*FIRST': '*KEY': numKey: YData);

  Buffer = *blanks;

  for do_x4 = 1 to numKey;
    peek41(YQFile
          : '*FIRST': '*READKEY': rc: YData);
    keyl0100 = YData;

    if (keyl0100.apkseq = 'D');
      Buffer = %trimr(Buffer) + COLOR_white;
    else;
      Buffer = %trimr(Buffer) + COLOR_green;
    endif;

    Buffer = %trimr(Buffer) + keyl0100.apkeyf;
  endfor;

  if (numKey >= 1 and
     keyl0100.apuniq = 'Y');
    Buffer = %trimr(Buffer) + COLOR_white + UNIQUE;
  endif;

  Buffer = %trimr(Buffer) + COLOR_green;

  strPos = 1;
  dou (strPos = 0);
    $$ftxt = f_wordWrap(
                  Buffer: %len($$ftxt): strPos);
    //  Schreiben der Subfile ...
    exsr PbWrite;
    if (strPos > 0 and
       %subst(Buffer: 1: strPos-1) < x'40');
      //     Positionieren auf Farb-Attribut
      strPos = strPos - 1;
    endif;
  enddo;

endsr;

//============================================================*
//    PBFillSel     Füllen Subfilesatz, SELECT/OMIT           *
//============================================================*

begsr PBFillSel;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Select/Omit Informationen ...
  peek41(YQFile
        : '*FIRST': '*SELECT': numSel: YData);

  for do_x5 = 1 to numSel;
    peek41(YQFile
          : '*FIRST': '*READSEL': rc: YData);
    sell0100 = YData;

    //  Wenn das Ende der Liste rreicht ist, ...
    if (sell0100.socomp = 'AL');
    //  ... dann den Eintrag überlesen
    else;
      //  ... ansonsten den Eintrag aufbereiten und anzeigen
      select;
      when (sell0100.sorule = 'S');
        Buffer = COLOR_white + '*SELECT';
      when (sell0100.sorule = 'O');
        Buffer = COLOR_white + '*OMIT';
      other;
        Buffer = COLOR_white;
      endsl;

      %subst(Buffer: 10: %len(sell0100.sofld)) =
       sell0100.sofld;
      %subst(Buffer: 21: %len(sell0100.socomp)) =
       sell0100.socomp;
      Buffer = %trimr(Buffer) + ' ' +
              sell0100.sovalu + COLOR_green;
      $$ftxt = Buffer;
      //  Schreiben der Subfile ...
      exsr PbWrite;
    endif;

  endfor;

endsr;

//============================================================*
//    PBWrite       Schreiben der Subfile                     *
//============================================================*

begsr PbWrite;

  //  Datensatz nicht komplett anzeigen ...
  if (*in71 = *on);
    $$File = *blanks;
    $$Lib = *blanks;
  else;
    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      $$File = h_file;
      $$Lib = h_lib;
    else;
      $$File = ' ' + h_file;
      $$Lib = h_lib;
    endif;
  endif;

  //  Anzeigen der Subfile ...
  *in80 = '1';

  //  Löschen Subfileauswahl ...
  exsr VSfpauClr;

  //  Schreiben des Subfilesatzes ...
  SflRec = SflRec + 1;
  exsr BzToSubf;
  write pbsfl;
  SflNbrRcd = SflRec;
  sfl_files(SflRec) = $$File;

  if (h_file = i_file and h_lib = i_lib and *in71 = *off);
    sfsanr = SflRec;
  endif;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  YQFile.name = pFile;
  YQFile.lib = plib;
  YMbr = pMbr;

  peek39(YQFile: YMbr
        : '*CREATE': numRel: dbrl0200);

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 2;
  endif;

  SflPage = *hival;
  SflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peek40fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##File = *blanks;
  R_File = ##File;

  // - Rückkehrcode
  o_file = *blanks;
  o_lib = *blanks;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Dateityp feststellen
  pFile = i_file;
  plib = i_lib;
  pMbr = i_mbr;
  PFmtName = i_rcdFmt;

  //   ... Einlesen der Dateiinformationen
  YQFile.name = pFile;
  YQFile.lib = plib;
  peek41(YQFile
        : PFmtName: '*CREATE': rc: YData);

  if (rc = *zeros);
    //       ... Fehler
    o_msgID = 'USR0008';
    clear usr0008;
    usr0008.var1 = YQFile.name;
    usr0008.var2 = YQFile.lib;
    o_msgDta = usr0008;
  else;
    //       ... kein Fehler
    fild0100 = YData;
    if (fild0100.atfila = '*LGL');
      //           ... logical file
      peek41(YQFile
            : PFmtName: '*BASED-ON': rc: YData);
      if (rc = *zeros);
        //               ... Fehler
        o_msgID = 'USR0008';
        clear usr0008;
        usr0008.var1 = YQFile.name;
        usr0008.var2 = YQFile.lib;
        o_msgDta = usr0008;
      else;
        if (i_basePhyF = bTrue);
          //                   ... based-on
          pFile = %subst(YData: 1: 10);
          plib  = %subst(YData: 11: 10);
          pMbr = '*FIRST';
        else;
        //               ... no based-on
        endif;
      endif;
    else;
    //           ... physical file
    endif;
  endif;

  if (o_msgID <> *blanks);
  //   ... Fehler
  else;

    // - Darstellung der Subfile
    sflmde = '1';

    // -  Darstellung der Auswahlen/Funktionstasten
    SFTop = 1;
    sfbot = 1;

    // - Einstellen der Bildschirmauflösung 80/132-Zeichen
    exsr SetScreen;

    // - Anzuzeigender Subfilesatz
    sfsanr = 1;

    // - Subfile füllen
    exsr C_Refresh;

    // - Copyright
    p_sndPgmMg('USR9999': i_copyright: sds.pgmName);
  endif;

endsr;

//====================================================*
//  InzSr --  Initialize program                      *
//====================================================*

begsr inzsr;

  if (isInzSr = bTrue);
    leavesr;
  endif;

  isInzSr = bTrue;

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek27_name = f_pgmCallN('PEEK27');
  peek39_name = f_pgmCallN('PEEK39');
  peek41_name = f_pgmCallN('PEEK41');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: YChoice: YNbrOfCh);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorHandler;
  dcl-pi *n;
    i_condToken    likeds(cee_fc_t) value;
    i_pCommArea    int(10) value;
    o_action       int(10);
    o_newCondToken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

