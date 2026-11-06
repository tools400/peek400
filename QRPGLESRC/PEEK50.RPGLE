**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK50                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 11.02.1999  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Erweiterte PIN-Funktion                           *
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

dcl-f peek50fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-f peekfldl1 keyed usropn infds(Peek_01_DS) rename(fpeekfld: fpeekfldl1) prefix(f_);

dcl-f peekfld usropn infds(Peek_00_DS) prefix(f_);

dcl-f peekwrk usage(*update: *delete) keyed usropn infds(Work_00_DS) prefix(w_);

dcl-f peekwrk_ disk(1024) usage(*update: *delete: *output) usropn infds(Work_01_DS);

dcl-ds workstn likeds(workstn_t);

dcl-ds Peek_00_DS likeds(infds_t);
dcl-ds Peek_01_DS likeds(infds_t);
dcl-ds Work_00_DS likeds(infds_t);
dcl-ds Work_01_DS likeds(infds_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,D_INFDS
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,WRK0002
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8205
/copy QCOPYLE,USR8209

/define internal_prototype
/copy QCOPYLE,PPEEK50
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds ds_peekwrk extname('PEEKWRK') inz len(1024) prefix(w_);
end-ds;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s YMsgID char(7);
dcl-s YMsgDta char(512);

dcl-s YPgmCmd char(10);
dcl-s YCmdDta like(pgmCmdDt_t);

dcl-s SflPage like(int4_t);
dcl-s SflPageDDS like(SflPage);
dcl-s SflRec like(SflPage);
dcl-s SflNbrRcd like(SflPage);

dcl-s sfbot like(int4_t);
dcl-c NbrFKeys 3;
dcl-s Sfl_Cmd char(10);

dcl-s IsSflError char(1) inz(bFalse);
dcl-s IsNewPos char(1) inz(bFalse);
dcl-s IsFound char(1) inz(bFalse);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s R_Field like(##Field);
dcl-s LstField like(##Field);
dcl-s LstNbrRcd like(SflPage);
dcl-s srchrec like(SflPage);
//  Feldnamen der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fnme) dim(9999);

dcl-s Wrk_SFSANR like(sfsanr);
dcl-s x like(int4_t);
dcl-s NbrPinCol like(int4_t);

dcl-ds wrk0002 likeds(WRK0002_t) inz(*likeds);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek50;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  io_pinTabC  like(fieldNme_t) dim(12);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds F1Key likerec(fpeekfldl1: *key);
dcl-ds W0Key likerec(fpeekwrk: *key);
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

  //  Warnung, bei mehr als 12 Spalten
  if (NbrPinCol > %elem(io_pinTabC));
    clear usr8205;
    usr8205.var1 = %elem(io_pinTabC);
    p_sndPgmMg('USR8205': usr8205: sds.pgmName);
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

  //  Anzeigen der Befehlstasten
  write pbbot#0;

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

  //  F3  - Sichern & beenden
  //  (erst die Eingaben seit dem letzten ENTER übernehmen)
  when (YPgmCmd = '*SAVE_EXIT');
    exsr C_Enter;
    if (IsSflError = bFalse);
      exsr C_SaveExit;
      leave;
    endif;

  //  F5  - Aktualisieren
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;

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

  //  F22 - Alle Löschen
  when (YPgmCmd = '*CLRALL');
    exsr C_ClrAll;
    iter;

  //  F12 - Ende
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;

  //  F24 - Weitere Tasten
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;

  //  Datenfreigabe
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
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

close peek50fm;
close peekfld;
close peekfldl1;
close peekwrk;
close peekwrk_;

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
    //  Feldnamen: Ein UPDATE der durchsuchten Zeilen verwarf bei F16
    //  ohne ENTER die eingegebenen Folgenummern.
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

      exsr SflBzoff;

      //  Cursorpositionierung ...
      if (IsSflError = bFalse);
        SflCsr = SflRec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmName
            : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
      if (YMsgID <> *blanks);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8110': sfpau: sds.pgmName);
        exsr VSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr PBSetBZ;
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
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = YPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr VSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr PBSetBZ;
        update pbsfl;
        IsSflError = bTrue;
        iter;
      endsl;

      //----------------------------*
      //  Verarbeiten               *
      //  Datensatzänderungen       *
      //----------------------------*
      exsr VPos;
      exsr VSfpauClr;

      //  Setzen Bezugszahlen ...
      exsr PBSetBZ;
      update pbsfl;
    endfor;

    //  Ungültige Auswahl: Cursor auf die erste fehlerhafte Zeile setzen
    //  (sfsanr wird sonst nur nach der Anzeige aus SFLCSRRRN gesetzt)
    if (IsSflError = bTrue);
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
//    C_SaveExit    F3     - Sichern und beenden              *
//============================================================*

begsr C_SaveExit;

  clear io_pinTabC;
  x = 0;

  clear W0Key;
  W0Key.W_Key = 0;
  setll %kds(W0Key) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = W_Data;

    if (x < %elem(io_pinTabC) and wrk0002.WRK_Seq <> 0);
      x = x + 1;
      io_pinTabC(x) = wrk0002.Wrk_FNme;
    endif;
  enddo;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  // - Subfile neu aufbauen
  clear W0Key;
  W0Key.W_Key = 0;
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
//    C_ClrAll      F22 - Löschen alle Einträge               *
//                        der Pintabelle                      *
//============================================================*

begsr C_ClrAll;

  clear W0Key;
  W0Key.W_Key = 0;
  setll %kds(W0Key) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = W_Data;

    ##Seq = 0;
    exsr FillRecord;
    exsr FillKey;

    W_Data = wrk0002;
    update fpeekwrk;
  enddo;

  exsr C_Refresh;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr FillRecord;

  if (##Seq <> 0 and wrk0002.WRK_Seq  = 0);
    NbrPinCol = NbrPinCol + 1;
  endif;

  if (##Seq = 0 and wrk0002.WRK_Seq <> 0);
    NbrPinCol = NbrPinCol - 1;
  endif;

  wrk0002.WRK_Seq = ##Seq;

endsr;

//============================================================*
//    FillKey       Füllen Schlüsselfelder in PEEKWRK         *
//============================================================*

begsr FillKey;

  if (wrk0002.WRK_Seq = 0);
    W_Key = *hival;
  else;
    W_Key = wrk0002.WRK_Seq;
  endif;

endsr;

//============================================================*
//    SflBzoff      Aussetzen aller Subfilebezugszahlen       *
//                  für die MArkierung von Eingabefehlern     *
//============================================================*

begsr SflBzoff;

  //  DSPATR(PC)
  %subarr(*in: 20: 10) = '0';
  //  DSPATR(RI)
  %subarr(*in: 30: 10) = '0';

endsr;

//============================================================*
//    VPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr VPos;

  chain recordnbr peekwrk_ ds_peekwrk;
  *in11 = not %found;
  if (*in11 = *on);
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0002 = W_Data;
    exsr FillRecord;
    exsr FillKey;
    W_Data = wrk0002;
    update peekwrk_ ds_peekwrk;
  endif;

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

endsr;

//============================================================*
//    PBReadUP      Vorwärts füllen der Subfile               *
//============================================================*

begsr PBReadUp;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekwrk));
      *in83 = *on;
      leave;
    endif;

    exsr PBFill;

    SflRec = SflRec + 1;
    //  Setzen Bezugszahlen ...
    exsr PBSetBZ;
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

  exsr SflBzoff;

  recordnbr = Work_00_DS.RcdNbr;

  wrk0002 = W_Data;

  chain wrk0002.WRK_RcdNbr fpeekfld;
  *in11 = not %found;

  fldl0100 = f_ffd;

  //  ... Folgenummer
  ##Seq = wrk0002.WRK_Seq;
  //  ... Feldname
  $$fnme = wrk0002.Wrk_FNme;
  //  ... Feldbezeichnung
  $$ftxt = wrk0002.WRK_FTxt;
  //  ... Keyfeldnummer
  if (F_KSeq <> 0);
    $$KSeq = 'K'+%editc(%dec(F_KSeq: 3: 0): 'X');
  else;
    $$KSeq = '';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

  setll %kds(W0Key) fpeekwrk;

endsr;

//============================================================*
//    PBSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr PBSetBZ;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 2;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 2;
  endif;

  SflPage = *hival;
  SflPageDDS = 4;

endsr;

//============================================================*
//    ClrPeekWrk    Löschen der Datei PEEKWRK                 *
//============================================================*

begsr ClrPeekWrk;

  f_execute('CLRPFM FILE(' +
              %trimr(WORK_FILE_LIBRARY) + '/' +
              %trimr(WORK_FILE_NAME) +
            ') MBR(' + %trimr(WORK_FILE_MEMBER) + ')'
            :YMsgID: YMsgDta);
  YMsgID = '';
  YMsgDta = '';

endsr;

//============================================================*
//    CopyToWork    Kopieren PEEKFLD nach PEEKWRK             *
//============================================================*

begsr CopyToWork;

  NbrPinCol = 0;

  clear F1Key;
  F1Key.F_Seq = 0;
  setll %kds(F1Key) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekfldl1));
      leave;
    endif;

    clear wrk0002;
    clear ds_peekwrk;

    fldl0100 = f_ffd;

    //  ... Folgenummer
    x = %lookup(fldl0100.f1fnme: io_pinTabC: 1);
    if (x > 0);
      //  ... gefunden
      ##Seq   = x * 10;
      W_Key   = x * 10;
    else;
      //  ... nicht gefunden
      ##Seq   = 0;
      W_Key   = *hival;
    endif;

    exsr FillRecord;

    //  ... sonstige Felder
    wrk0002.WRK_RcdNbr = Peek_01_DS.RcdNbr;
    wrk0002.Wrk_FNme = fldl0100.f1fnme;
    wrk0002.WRK_FTxt = fldl0100.f1ftxt;

    W_Format = 'WRK0002';
    W_Data = wrk0002;

    write peekwrk_ ds_peekwrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Öffnen der Dateien
  open peekfld;
  open peekfldl1;

  exsr ClrPeekWrk;
  open peekwrk;
  open peekwrk_;
  exsr CopyToWork;

  open peek50fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##Field = *blanks;

  // - Rückkehrcode
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Subfile
  sflmde = '1';

  // - Darstellung der Befehlstasten
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

  peek23(sds.pgmName: '*ALL': NbrFKeys
        : yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

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

