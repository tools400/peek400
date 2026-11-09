**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Erweiterte PIN-Funktion                      *
      //%EMETADATA                                                     *
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
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek50fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-f peekFldL1 keyed usropn infds(peek_01_ds) rename(fpeekfld: fpeekfldl1) prefix(f_);

dcl-f peekFld usropn infds(peek_00_ds) prefix(f_);

dcl-f peekWrk usage(*update: *delete) keyed usropn infds(work_00_ds) prefix(w_);

dcl-f peekWrk_ disk(1024) usage(*update: *delete: *output) usropn infds(work_01_ds);

dcl-ds workstn likeds(workstn_t);

dcl-ds peek_00_ds likeds(infds_t);
dcl-ds peek_01_ds likeds(infds_t);
dcl-ds work_00_ds likeds(infds_t);
dcl-ds work_01_ds likeds(infds_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/wrk0002.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8110.rpgleinc'
/copy 'qcopyle/usr8136.rpgleinc'
/copy 'qcopyle/usr8205.rpgleinc'
/copy 'qcopyle/usr8209.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek50.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-ds fldl0100 likeds(fldl0100_t) inz;

dcl-ds ds_peekWrk extname('PEEKWRK') inz len(1024) prefix(w_);
end-ds;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s sflPage like(int4_t);
dcl-s sflPageDDS like(sflPage);
dcl-s sflRec like(sflPage);
dcl-s sflNbrRcd like(sflPage);

dcl-s sfBot like(int4_t);
dcl-c NbrFKeys 3;
dcl-s sfl_cmd char(10);

dcl-s isSflError char(1) inz(bFalse);
dcl-s isNewPos char(1) inz(bFalse);
dcl-s isFound char(1) inz(bFalse);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);

dcl-s r_field like(##field);
dcl-s lstField like(##field);
dcl-s lstNbrRcd like(sflPage);
dcl-s srchRec like(sflPage);
//  Feldnamen der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fNme) dim(9999);

dcl-s wrk_sfsanr like(sfsanr);
dcl-s x like(int4_t);
dcl-s nbrPinCol like(int4_t);

dcl-ds wrk0002 likeds(wrk0002_t) inz(*likeds);

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

dcl-ds f1Key likerec(fpeekfldl1: *key);
dcl-ds w0Key likerec(fpeekwrk: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

dow ('1');

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= *zeros);
    sfsanr = 1;
  endif;

  //  Warnung, bei mehr als 12 Spalten
  if (nbrPinCol > %elem(io_pinTabC));
    clear usr8205;
    usr8205.var1 = %elem(io_pinTabC);
    p_sndPgmMg('USR8205': usr8205: sds.pgmName);
  endif;

  //  Modus: DROP/FOLD
  *in86 = sflMde;

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  "Keine Sätze ..."
  if (*in80 = *off);
    write pbleer;
  endif;

  //  Anzeigen der Befehlstasten
  write pbbot#0;

  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbCtl;
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Aktuelle Satz-Nr.
  if (sflCsr > *zeros);
    sfsanr = sflCsr;
  endif;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> *blanks);
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  //  F3  - Ende
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;

  //  F3  - Sichern & beenden
  //  (erst die Eingaben seit dem letzten ENTER übernehmen)
  when (yPgmCmd = '*SAVE_EXIT');
    exsr c_enter;
    if (isSflError = bFalse);
      exsr c_saveExit;
      leave;
    endif;

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F16 - Suchen
  when (yPgmCmd = '*SEARCH');
    exsr c_search;
    iter;

  //   F17 - Anfang Datensatz
  when (yPgmCmd = '*TOP');
    exsr c_top;
    iter;
  //   F18 - Ende Datensatz
  when (yPgmCmd = '*BOT');
    exsr c_bot;
    iter;

  //  F22 - Alle Löschen
  when (yPgmCmd = '*CLRALL');
    exsr c_clrAll;
    iter;

  //  F12 - Ende
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
  //  Page up
  when (yPgmCmd = '*PAGEUP');
  //  Page down
  when (yPgmCmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek50fm;
close peekFld;
close peekFldL1;
close peekWrk;
close peekWrk_;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vReadC;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##field <> *blanks and isSflError = bFalse);
    exsr c_search;
  endif;

endsr;

//============================================================*
//    c_search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##field <> *blanks);
    lstField = ##field;
    ##field = *blanks;
  endif;

  if (lstField = *blanks);
    *in70 = '1';
    clear usr8209;
    p_sndPgmMg('USR8209': usr8209: sds.pgmName);
  else;
    exsr posToField;
    if (isNewPos = bTrue);
      sfsanr = wrk_sfsanr;
    endif;
  endif;

endsr;

//============================================================*
//    posToField    Subfile neu positionieren                 *
//============================================================*

begsr posToField;

  if (lstField <> r_field);
    lstNbrRcd = 0;
  endif;

  if (lstField = *blanks);
    isNewPos = bFalse;
    lstNbrRcd = 0;
  else;

    exsr srchField;
    if (isFound = bFalse);
      isNewPos = bFalse;
      clear usr8136;
      usr8136.var1 = lstField;
      p_sndPgmMg('USR8136': usr8136: sds.pgmName);
    else;
      isNewPos = bTrue;
    endif;
  endif;

  r_field = lstField;

endsr;

//============================================================*
//    srchField     Suchen Feld in Subfile                    *
//============================================================*

begsr srchField;

  if (*in80 = *off);
    isFound = bFalse;
  else;

    isFound = bFalse;
    lstNbrRcd = lstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Feldnamen: Ein UPDATE der durchsuchten Zeilen verwarf bei F16
    //  ohne ENTER die eingegebenen Folgenummern.
    for srchRec = lstNbrRcd to sflNbrRcd;
      if (lstField =
          %subst(sfl_fnmes(srchRec): 1:(f_scan(' ':
                                lstField) - 1)));
        isFound = bTrue;
        leave;
      endif;

    endfor;

    if (isFound = bTrue);
      wrk_sfsanr = srchRec;
      lstNbrRcd = srchRec;
    else;
      wrk_sfsanr = *zeros;
      lstNbrRcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    srchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr srchInit;

  lstField  = ' ';
  lstNbrRcd = 0;
  r_field   = lstField;

endsr;

//============================================================*
//    vReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vReadC;

  isSflError = bFalse;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to sflNbrRcd;
      readc pbSfl;
      *in11 = %eof;
      if (*in11 = *on);
        leave;
      endif;

      chain sflRec pbSfl;
      *in11 = not %found;

      exsr sflBzoff;

      //  Cursorpositionierung ...
      if (isSflError = bFalse);
        sflCsr = sflRec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmName
            : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
      if (yMsgID <> *blanks);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8110': sfpau: sds.pgmName);
        exsr vSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr pbSetBZ;
        update pbSfl;
        isSflError = bTrue;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      sfl_cmd = yPgmCmd;

      select;
      when (sfl_cmd = '*NONE');
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = yPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr vSfpauErr;
        //  Setzen Bezugszahlen ...
        exsr pbSetBZ;
        update pbSfl;
        isSflError = bTrue;
        iter;
      endsl;

      //----------------------------*
      //  Verarbeiten               *
      //  Datensatzänderungen       *
      //----------------------------*
      exsr vPos;
      exsr vSfpauClr;

      //  Setzen Bezugszahlen ...
      exsr pbSetBZ;
      update pbSfl;
    endfor;

    //  Ungültige Auswahl: Cursor auf die erste fehlerhafte Zeile setzen
    //  (sfsanr wird sonst nur nach der Anzeige aus SFLCSRRRN gesetzt)
    if (isSflError = bTrue);
      sfsanr = sflCsr;
    endif;

  endif;

endsr;

//============================================================*
//    c_endPgm      F3/F12 - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';
  usr8100.var1 = yPgmCmd;
  o_msgDta = usr8100;

endsr;

//============================================================*
//    c_saveExit    F3     - Sichern und beenden              *
//============================================================*

begsr c_saveExit;

  clear io_pinTabC;
  x = 0;

  clear w0Key;
  w0Key.w_key = 0;
  setll %kds(w0Key) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekWrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = w_data;

    if (x < %elem(io_pinTabC) and wrk0002.wrk_seq <> 0);
      x = x + 1;
      io_pinTabC(x) = wrk0002.wrk_fNme;
    endif;
  enddo;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Subfile neu aufbauen
  clear w0Key;
  w0Key.w_key = 0;
  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

  exsr srchInit;

endsr;

//============================================================*
//    c_top         F17 - Anfang der Subfile                  *
//============================================================*

begsr c_top;

  sfsanr = 1;

endsr;

//============================================================*
//    c_bot         F18 - Ende der Subfile                    *
//============================================================*

begsr c_bot;

  sfsanr = sflNbrRcd;

endsr;

//============================================================*
//    c_clrAll      F22 - Löschen alle Einträge               *
//                        der Pintabelle                      *
//============================================================*

begsr c_clrAll;

  clear w0Key;
  w0Key.w_key = 0;
  setll %kds(w0Key) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekWrk));
      *in83 = *on;
      leave;
    endif;

    wrk0002 = w_data;

    ##seq = 0;
    exsr fillRecord;
    exsr fillKey;

    w_data = wrk0002;
    update fpeekwrk;
  enddo;

  exsr c_refresh;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    fillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr fillRecord;

  if (##seq <> 0 and wrk0002.wrk_seq  = 0);
    nbrPinCol = nbrPinCol + 1;
  endif;

  if (##seq = 0 and wrk0002.wrk_seq <> 0);
    nbrPinCol = nbrPinCol - 1;
  endif;

  wrk0002.wrk_seq = ##seq;

endsr;

//============================================================*
//    fillKey       Füllen Schlüsselfelder in PEEKWRK         *
//============================================================*

begsr fillKey;

  if (wrk0002.wrk_seq = 0);
    w_key = *hival;
  else;
    w_key = wrk0002.wrk_seq;
  endif;

endsr;

//============================================================*
//    sflBzoff      Aussetzen aller Subfilebezugszahlen       *
//                  für die MArkierung von Eingabefehlern     *
//============================================================*

begsr sflBzoff;

  //  DSPATR(PC)
  %subarr(*in: 20: 10) = '0';
  //  DSPATR(RI)
  %subarr(*in: 30: 10) = '0';

endsr;

//============================================================*
//    vPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vPos;

  chain recordNbr peekWrk_ ds_peekWrk;
  *in11 = not %found;
  if (*in11 = *on);
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0002 = w_data;
    exsr fillRecord;
    exsr fillKey;
    w_data = wrk0002;
    update peekWrk_ ds_peekWrk;
  endif;

endsr;

//============================================================*
//    vSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr vSfpauClr;

  sfpau = *blanks;
  *in85 = '0'; // DSPATR(RI)
  *in84 = '0'; // SFLNXTCHG

endsr;

//============================================================*
//    vSfpauErr     Anzeigen fehlerhafter Subfileauswahl      *
//============================================================*

begsr vSfpauErr;

  *in85 = '1'; // DSPATR(RI)
  exsr vSfpauChg;

endsr;

//============================================================*
//    vSfpauChg     Datensatz in Subfile als geändert         *
//                  markieren                                 *
//============================================================*

begsr vSfpauChg;

  *in84 = '1'; // SFLNXTCHG

endsr;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  *in89 = '0';
  write msgCtl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbCtl;

  *in82 = '0'; // SFLCLR

  sflRec = 0;
  sflNbrRcd = 0;

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekWrk));
      *in83 = *on;
      leave;
    endif;

    exsr pbFill;

    sflRec = sflRec + 1;
    //  Setzen Bezugszahlen ...
    exsr pbSetBZ;
    write pbSfl;
    sflNbrRcd = sflRec;
    sfl_fnmes(sflRec) = $$fNme;

    if (sflRec >= sflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  exsr sflBzoff;

  recordNbr = work_00_ds.rcdNbr;

  wrk0002 = w_data;

  chain wrk0002.wrk_rcdNbr fpeekfld;
  *in11 = not %found;

  fldl0100 = f_ffd;

  //  ... Folgenummer
  ##seq = wrk0002.wrk_seq;
  //  ... Feldname
  $$fNme = wrk0002.wrk_fNme;
  //  ... Feldbezeichnung
  $$fTxt = wrk0002.wrk_fTxt;
  //  ... Keyfeldnummer
  if (f_kSeq <> 0);
    $$kSeq = 'K'+%editc(%dec(f_kSeq: 3: 0): 'X');
  else;
    $$kSeq = '';
  endif;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr vSfpauClr;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  setll %kds(w0Key) fpeekwrk;

endsr;

//============================================================*
//    pbSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr pbSetBZ;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

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

  sflPage = *hival;
  sflPageDDS = 4;

endsr;

//============================================================*
//    clrPeekWrk    Löschen der Datei PEEKWRK                 *
//============================================================*

begsr clrPeekWrk;

  f_execute('CLRPFM FILE(' +
              %trimr(WORK_FILE_LIBRARY) + '/' +
              %trimr(WORK_FILE_NAME) +
            ') MBR(' + %trimr(WORK_FILE_MEMBER) + ')'
            :yMsgID: yMsgDta);
  yMsgID = '';
  yMsgDta = '';

endsr;

//============================================================*
//    copyToWork    Kopieren PEEKFLD nach PEEKWRK             *
//============================================================*

begsr copyToWork;

  nbrPinCol = 0;

  clear f1Key;
  f1Key.f_seq = 0;
  setll %kds(f1Key) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekFldL1));
      leave;
    endif;

    clear wrk0002;
    clear ds_peekWrk;

    fldl0100 = f_ffd;

    //  ... Folgenummer
    x = %lookup(fldl0100.f1FNme: io_pinTabC: 1);
    if (x > 0);
      //  ... gefunden
      ##seq   = x * 10;
      w_key   = x * 10;
    else;
      //  ... nicht gefunden
      ##seq   = 0;
      w_key   = *hival;
    endif;

    exsr fillRecord;

    //  ... sonstige Felder
    wrk0002.wrk_rcdNbr = peek_01_ds.rcdNbr;
    wrk0002.wrk_fNme = fldl0100.f1FNme;
    wrk0002.wrk_fTxt = fldl0100.f1FTxt;

    w_format = 'WRK0002';
    w_data = wrk0002;

    write peekWrk_ ds_peekWrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peekFld;
  open peekFldL1;

  exsr clrPeekWrk;
  open peekWrk;
  open peekWrk_;
  exsr copyToWork;

  open peek50fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##field = *blanks;

  // - Rückkehrcode
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Subfile
  sflMde = '1';

  // - Darstellung der Befehlstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

  // - Anzuzeigender Subfilesatz
  sfsanr = 1;

  // - Subfile füllen
  exsr c_refresh;

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

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

  peek23(sds.pgmName: '*ALL': NbrFKeys
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

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

