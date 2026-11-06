**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK37                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 12.02.1998  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Feldauswahl                                       *
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

dcl-f peek37fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);
dcl-f peekfld usage(*update: *delete) keyed usropn prefix(f_);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8209

/define internal_prototype
/copy QCOPYLE,PPEEK37
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-s yFKeys char(18) dim(32) inz;
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-s YChoice char(75) dim(32);
dcl-s YNbrOfCh like(int4_t) inz;

dcl-s IsNewPos char(1) inz(bFalse);
dcl-s IsFound char(1) inz(bFalse);
dcl-s IsSflError char(1) inz(bFalse);

dcl-s SFTop like(int4_t) inz;
dcl-s SflPage like(int4_t) inz;
dcl-s SflPageDDS like(SflPage) inz;
dcl-s SflRec like(SflPage) inz;
dcl-s SflNbrRcd like(SflPage) inz;
dcl-s sfbot like(int4_t) inz;
dcl-c NbrFKeys 2;
dcl-s Sfl_Cmd char(10) inz(*blanks);

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;

dcl-s R_Field inz(*blanks) like(##Field);
dcl-s LstField inz(*blanks) like(##Field);
dcl-s LstNbrRcd inz(0) like(SflPage);
dcl-s srchrec inz(0) like(SflPage);
//  Feldnamen der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fnme) dim(9999);

dcl-s Wrk_SFSANR inz(*zeros) like(sfsanr);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek37;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  o_feld      like(fieldNme_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds f_key likerec(fpeekfld: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

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
    if (o_feld = *blanks);
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

close peek37fm;
close peekfld;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr VReadC;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##Field <> *blanks and IsSflError = bFalse);
    exsr C_Search;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr C_Search;

  if (##Field <> *blanks);
    LstField = ##Field;
    ##Field = *blanks;
  endif;

  if (LstField = *blanks);
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

  if (LstField <> R_Field);
    LstNbrRcd = 0;
  endif;

  if (LstField = *blanks);
    IsNewPos = bFalse;
    LstNbrRcd = 0;
  else;

    exsr SrchField;
    if (IsFound = bFalse);
      IsNewPos = bFalse;
      clear usr8136;
      usr8136.var1 = LstField;
      p_sndPgmMg('USR8136': usr8136: sds.pgmName);
    else;
      IsNewPos = bTrue;
    endif;
  endif;

  R_Field = LstField;

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
    //  Feldnamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
    for srchrec = LstNbrRcd to SflNbrRcd;
      if (LstField =
          %subst(sfl_fnmes(srchrec): 1:(f_scan(' ':
                                LstField) - 1)));
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

  LstField  = ' ';
  LstNbrRcd = 0;
  R_Field   = LstField;

endsr;

//============================================================*
//    VReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr VReadC;

  IsSflError = bFalse;
  o_feld = *blanks;

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
        if (o_feld = *blanks);
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
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endsl;

      update pbsfl;
    endfor;

    //  Ungültige Auswahl: keine Auswahl übernehmen und den Cursor auf
    //  die erste fehlerhafte Zeile setzen (sfsanr wird sonst nur nach
    //  der Anzeige aus SFLCSRRRN gesetzt)
    if (IsSflError = bTrue);
      o_feld = *blanks;
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
  exsr PBInitKey;
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

  o_feld = $$fnme;

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
//    PBInitKey     Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile                    *
//============================================================*

begsr PBInitKey;

  clear f_key;

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

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  dow ('1');
    read(n) fpeekfld;
    if (%eof(peekfld));
      *in83 = bTrue;
      leave;
    endif;

    exsr PBFill;

    SflRec = SflRec + 1;
    write pbsfl;
    SflNbrRcd = SflRec;
    sfl_fnmes(SflRec) = $$fnme;

    if (SflRec >= SflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  fldl0100 = f_ffd;
  //  ... Feldname
  $$fnme = fldl0100.f1fnme;
  //  ... Feldbezeichnung
  $$ftxt = fldl0100.f1ftxt;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  setll %kds(f_key) fpeekfld;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 5;
    pos = 35;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 3;
    pos = 23;
  endif;

  SflPage = *hival;
  SflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peek37fm;
  open peekfld;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##Field = *blanks;

  // - Rückkehrcode
  o_feld = *blanks;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
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

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: YChoice: YNbrOfCh: *omit: %len($$choice));

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

