**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Layout                                       *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK34                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 22.12.1997  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Layout                                                       *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek34fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-f peekWrk usage(*update: *delete) keyed usropn infds(work_00_ds) prefix(w_);

dcl-f peekWrk_ disk(1024) usage(*update: *delete: *output) usropn infds(work_01_ds);

dcl-f peekFldL1 usage(*input) keyed usropn infds(peek_01_ds) rename(fpeekfld: fpeekfldl1) prefix(f_)
  ;

dcl-f peekFld usage(*update: *delete) usropn infds(peek_00_ds) prefix(f_);

dcl-ds workstn likeds(workstn_t);

dcl-ds work_00_ds likeds(infds_t);
dcl-ds work_01_ds likeds(infds_t);
dcl-ds peek_00_ds likeds(infds_t);
dcl-ds peek_01_ds likeds(infds_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/d_infds.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/wrk0001.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8110.rpgleinc'
/copy 'qcopyle/usr8136.rpgleinc'
/copy 'qcopyle/usr8209.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek34.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek25.rpgleinc'
/copy 'qcopyle/ppeek35.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

//----------------------------------------------------*
//  I N F D S - D E F I N I T I O N E N               *
//----------------------------------------------------*

dcl-ds ds_peekWrk extname('PEEKWRK') inz len(1024) prefix(w_);
end-ds;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s yField char(10);

dcl-s yColorAttr char(1);

dcl-s sflPage like(int4_t);
dcl-s sflPageDDS like(sflPage);
dcl-s sflRec like(sflPage);
dcl-s sflNbrRcd like(sflPage);
dcl-c NbrFKeys 3;

dcl-s sfBot like(int4_t);
dcl-s sfl_cmd char(10);

dcl-s isSflError char(1) inz(bFalse);
dcl-s isNewPos char(1) inz(bFalse);
dcl-s isFound char(1) inz(bFalse);
dcl-s isBatch char(1) inz(bFalse);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);
dcl-s peek25_name like(pgmCallN_t);
dcl-s peek35_name like(pgmCallN_t);

dcl-s r_field like(##field);
dcl-s r_seq like(f_seq);
dcl-s lstField like(##field);
dcl-s lstNbrRcd like(sflPage);
dcl-s srchRec like(sflPage);
//  Feldnamen und Satznummern der Subfile-Sätze für die Suche
dcl-s sfl_fnmes like($$fNme) dim(9999);
dcl-s sfl_rcdNbrs like(recordNbr) dim(9999);

//  Prüfung auf doppelte Folgenummern
dcl-s isDupSeq like(bool_t) inz(bFalse);
dcl-s isFirst like(bool_t) inz(bFalse);
dcl-s lstSeq like(wrk0001_t.wrk_seq) inz;
dcl-s lstRcdNbr like(int4_t) inz;
dcl-s dupNbr like(int4_t) inz;
dcl-s dupRrn like(int4_t) inz;
//  Zeilen der Subfile: als doppelte Folgenummer markiert (bisher/neu)
//  und in diesem Durchlauf von vReadC verarbeitet
dcl-s isDupRow ind dim(9999) inz(*off);
dcl-s isNewDup ind dim(9999) inz(*off);
dcl-s isReadRow ind dim(9999) inz(*off);
//  Feld mit Eingabefehler je Zeile und ob es in diesem Durchlauf von
//  vReadC Eingabefehler gab: Sie behalten Markierung und Cursor, auch
//  wenn die Zeile zusätzlich eine doppelte Folgenummer hat.
dcl-s errField like(yField) dim(9999) inz;
dcl-s isInpErr like(bool_t) inz(bFalse);
dcl-s wrk_sfsanr like(sfsanr);


dcl-ds fldl0100 likeds(fldl0100_t) inz;
dcl-ds wrk0001 likeds(wrk0001_t) inz(*likeds);

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek34;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_function  like(option_t) const;
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x2 packed(7);

dcl-ds w0Key likerec(fpeekwrk: *key);
dcl-ds f1Key likerec(fpeekfldl1: *key);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;
if (isBatch = bFalse);

  dow ('1');

    //  Prüfen Positionierung der Subfile
    if (sfsanr <= 0);
      sfsanr = 1;
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
    if (sflCsr > 0);
      sfsanr = sflCsr;
    endif;

    //  Mappen der gedrückten Taste
    //  in Programmbefehl
    peek21(workstn.aid: sds.pgmName
          : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
    if (yMsgID <> '');
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

    //  F11 - Float Keys
    when (yPgmCmd = '*FLOATKEYS');
      exsr c_floatKey;
      exsr c_refresh;
      iter;

    //  F12 - Ende
    when (yPgmCmd = '*CANCEL');
      exsr c_endPgm;
      leave;

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

  close peek34fm;
endif;

close peekFldL1;
close peekFld;

close peekWrk;
close peekWrk_;
exsr clrPeekWrk;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vReadC;

  if (##field <> '');
    exsr c_search;
  endif;

endsr;

//============================================================*
//    c_search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##field <> '');
    lstField = ##field;
    ##field = '';
  endif;

  if (lstField = '');
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

  if (lstField = '');
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
    //  Feldnamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
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
  isReadRow(*) = *off;
  errField(*) = '';
  isInpErr = bFalse;

  if (*in80 = *off);
  //   keine Einträge in Subfile vorhanden ...
  else;

    for do_x2 = 1 to sflNbrRcd;
      readc pbSfl;
      if (%eof());
        leave;
      endif;

      chain sflRec pbSfl;
      isReadRow(sflRec) = *on;

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
        clear usr8110.var1;
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
      exsr getColor;
      exsr fillRecord;
      //  Prüfen, Datensatz ...
      monitor;
        peek35(recordNbr: wrk0001: yField
              : yMsgID: yMsgDta);
        *in99 = bFalse;
      on-error;
        *in99 = bTrue;
      endmon;
      //  ... Fehler beim Programmaufruf
      if (*in99 = *on);
        exsr vSfpauErr;
      else;
        //  ... Programaufruf war OK
        if (yMsgID = *blanks);
          //      ... Prüfung ist OK
          exsr vPos;
          exsr vSfpauClr;
        else;
          //      ... Fehler bei der Prüfung
          exsr vPosCsr;
          exsr vSfpauErr;
          *in85 = '0'; // DSPATR(RI)
          p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
          yMsgID = '';
          yMsgDta = '';
          isSflError = bTrue;
          errField(sflRec) = yField;
          isInpErr = bTrue;
        endif;
      endif;

      //  Setzen Bezugszahlen ...
      exsr pbSetBZ;
      update pbSfl;
    endfor;

    //  Doppelte Folgenummern erst nach allen Änderungen prüfen,
    //  damit zwei Felder ihre Nummern tauschen können.
    exsr chkDupSeq;

  endif;

endsr;

//============================================================*
//    chkDupSeq     Prüfen auf doppelte Folgenummern          *
//============================================================*

begsr chkDupSeq;

  isDupSeq = bFalse;
  isFirst = bTrue;
  isNewDup(*) = *off;

  //  PEEKWRK ist nach der Folgenummer sortiert: Doppelte
  //  Nummern liegen direkt hintereinander.
  clear w0Key;
  w0Key.w_key = *loval;
  setll %kds(w0Key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekWrk));
      leave;
    endif;

    if (isFirst = bFalse and w_key = lstSeq);
      isDupSeq = bTrue;
      dupNbr = lstRcdNbr;
      exsr markDupSeq;
      dupNbr = work_00_ds.rcdNbr;
      exsr markDupSeq;
    endif;

    isFirst = bFalse;
    lstSeq = w_key;
    lstRcdNbr = work_00_ds.rcdNbr;
  enddo;

  if (isDupSeq = bTrue);
    p_sndPgmMg('USR8167': '': sds.pgmName);
    isSflError = bTrue;
  endif;

  //  Markierungen entfernen, die nicht mehr zutreffen. READC liefert
  //  nicht jede markierte Zeile wieder; Zeilen aus diesem Durchlauf hat
  //  vReadC neu geschrieben.
  for sflRec = 1 to sflNbrRcd;
    if (isDupRow(sflRec) and not isNewDup(sflRec)
        and not isReadRow(sflRec));
      chain(e) sflRec pbSfl;
      if (not %error() and %found());
        exsr sflBzoff;
        exsr vSfpauClr;
        exsr pbSetBZ;
        update pbSfl;
      endif;
    endif;
  endfor;

  isDupRow = isNewDup;

endsr;

//============================================================*
//    markDupSeq    Markieren Folgenummer von Satz dupNbr     *
//============================================================*

begsr markDupSeq;

  //  Die Zeile über die gemerkten Satznummern suchen, statt jede
  //  Zeile per CHAIN zu lesen.
  dupRrn = 0;
  if (sflNbrRcd > 0);
    dupRrn = %lookup(dupNbr: sfl_rcdNbrs: 1: sflNbrRcd);
  endif;

  if (dupRrn > 0);
    sflRec = dupRrn;
    chain(e) sflRec pbSfl;
    if (not %error() and %found());
      isNewDup(sflRec) = *on;
      exsr sflBzoff;
      //  Ein Eingabefehler dieser Zeile bleibt markiert. Gibt es
      //  Eingabefehler, bekommen sie den Cursor, nicht die doppelte
      //  Folgenummer.
      if (errField(sflRec) <> '');
        yField = errField(sflRec);
        exsr vPosCsr;
      endif;
      if (isInpErr = bFalse);
        *in20 = '1';       // DSPATR(PC)
      endif;
      *in30 = '1';         // DSPATR(RI)
      *in85 = '0';         // DSPATR(RI) Auswahl
      exsr vSfpauChg;
      exsr pbSetBZ;
      update pbSfl;
    endif;
  endif;

endsr;

//============================================================*
//    getColor      Auswählen neue Farbe                      *
//============================================================*

begsr getColor;

  if (##color <> *blanks);

    yColorAttr = $$color;

    monitor;
      peek25(i_dsp80: yColorAttr: yMsgID: yMsgDta);
      *in99 = bFalse;
    on-error;
      *in99 = bTrue;
    endmon;

    if (*in99 = *on);
    // Fehler aufgetreten
    else;
      $$color = yColorAttr;
    endif;

  else;
  //  Cursor steht auf falschem Feld ...
  endif;

  ##color = *blanks;

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

  r_seq = *zeros;

  clear w0Key;
  w0Key.w_key = 0;
  setll %kds(w0Key: 1) fpeekwrk;

  dow ('1');
    read(n) fpeekwrk;
    if (%eof(peekWrk));
      leave;
    endif;

    r_seq = r_seq + 1;

    wrk0001 = w_data;

    chain wrk0001.wrk_rcdNbr fpeekfld;
    if (not %found(peekFld));
      //  Feld nicht mehr vorhanden, z.B. Feldliste neu aufgebaut
      iter;
    endif;

    f_seq = r_seq;
    f_hidden = wrk0001.wrk_hidden;
    f_color = wrk0001.wrk_color;
    f_markCol = wrk0001.wrk_mrkCol;
    f_maxSize = wrk0001.wrk_maxSiz;
    f_edtCde = wrk0001.wrk_edtCde;

    update fpeekfld;
  enddo;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8112';
  o_msgDta = '';

endsr;

//============================================================*
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Abrufen der Subfiletexte
  exsr pbSflTxt;

  // - Subfile neu aufbauen
  clear w0Key;
  w0Key.w_key = 0;

  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

  exsr srchInit;

endsr;

//============================================================*
//    c_floatKey    F11 - Schlüsselfelder an den Anfang       *
//============================================================*

begsr c_floatKey;

  //  Alle nicht Schlüsselfelder mit
  //  negativen Folgenummern versehen ...
  clear w0Key;
  w0Key.w_key = 0;
  setll %kds(w0Key: 1) fpeekwrk;

  dow ('1');
    read fpeekwrk;
    if (%eof(peekWrk));
      leave;
    endif;

    wrk0001 = w_data;

    if (wrk0001.wrk_kSeq = 0);
      wrk0001.wrk_seq = wrk0001.wrk_seq * -1;
    else;
      wrk0001.wrk_seq = 0;
    endif;

    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update fpeekwrk;
  enddo;

  //  Nun alle negative Folgenummern neu
  //  durchnummerieren ...
  r_seq = 0;

  clear w0Key;
  w0Key.w_key = *hival;
  setgt %kds(w0Key: 1) fpeekwrk;

  dow ('1');
    readp fpeekwrk;
    if (%eof(peekWrk));
      leave;
    endif;

    wrk0001 = w_data;

    //  Schlüsselfelder? ...
    if (wrk0001.wrk_kSeq = 0);
      //  ... nein, kein Schlüsselfeld
      r_seq = r_seq + 10;
      wrk0001.wrk_seq = r_seq;
    else;
      //  ... ja, Schlüsselfeld
      wrk0001.wrk_seq = wrk0001.wrk_kSeq * 10;
      if (wrk0001.wrk_seq > r_seq);
        r_seq = wrk0001.wrk_seq;
      else;
      //    r_seq stehenlassen ...
      endif;
    endif;

    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update fpeekwrk;
  enddo;

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
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    fillRecord    Füllen Datensatz in PEEKWRK               *
//============================================================*

begsr fillRecord;

  wrk0001.wrk_seq = ##seq;

  select;
  when (##hidden = bTrue);
    wrk0001.wrk_hidden = bFalse;
  when (##hidden = bFalse);
    wrk0001.wrk_hidden = bTrue;
  other;
    wrk0001.wrk_hidden = ##hidden;
  endsl;

  wrk0001.wrk_color = $$color;
  wrk0001.wrk_mrkCol = ##markCol;
  wrk0001.wrk_maxSiz = ##maxSize;
  wrk0001.wrk_edtCde = ##edtCde;

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
//    vPosCsr       Positionieren Cursor auf fehlerhaftes     *
//                  Feld in der Subfile                       *
//============================================================*

begsr vPosCsr;

  select;
  when (yField = 'SEQ');
    *in20 = '1';         // DSPATR(PC)
    *in30 = '1';         // DSPATR(RI)
  when (yField = 'HIDDEN');
    *in21 = '1';         // DSPATR(PC)
    *in31 = '1';         // DSPATR(RI)
  when (yField = 'COLOR');
    *in22 = '1';         // DSPATR(PC)
    *in32 = '1';         // DSPATR(RI)
  when (yField = 'MARKCOL');
    *in23 = '1';         // DSPATR(PC)
    *in33 = '1';         // DSPATR(RI)
  when (yField = 'MAXSIZE');
    *in24 = '1';         // DSPATR(PC)
    *in34 = '1';         // DSPATR(RI)
  when (yField = 'EDTCDE');
    *in25 = '1';         // DSPATR(PC)
    *in35 = '1';
  other;
  //  Weiß noch nicht
  endsl;

endsr;

//============================================================*
//    vPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vPos;

  chain recordNbr peekWrk_ ds_peekWrk;
  if (not %found(peekWrk_));
  //  Weiß noch nicht, was zu tun ist ...
  else;
    wrk0001 = w_data;
    exsr fillRecord;
    w_key = wrk0001.wrk_seq;
    w_data = wrk0001;
    update peekWrk_ ds_peekWrk;
  endif;

endsr;

//============================================================*
//    vSfpauClr     Löschen Subfileauswahl                    *
//============================================================*

begsr vSfpauClr;

  sfpau = '';
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

  //  Neue Subfile: keine Markierungen für doppelte Folgenummern
  isDupRow(*) = *off;

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
    sfl_rcdNbrs(sflRec) = recordNbr;

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

  wrk0001 = w_data;

  chain(n) wrk0001.wrk_rcdNbr fpeekfld;

  fldl0100 = f_ffd;

  //  ... Anzeigereihenfolge
  ##seq = wrk0001.wrk_seq;
  //  ... Feldname
  $$fNme = fldl0100.f1FNme;
  //  ... Feldbezeichnung
  $$fTxt = fldl0100.f1FTxt;
  //  ... Datentyp
  $$dTyp = fldl0100.f1DTyp;

  //  ... Anzahl Dezimalstellen
  if ((f_isNumFld(fldl0100) = bTrue) and
      (f_isFloatFld(fldl0100) = bFalse));
    $$digt = fldl0100.f1Digt;
    //      ... Anzahl Nachkommastellen
    $$decP = fldl0100.f1DecP;
    isDecimal = bTrue;
  else;
    $$digt = f_buffLn(fldl0100);
    $$decP = 0;
    isDecimal = bFalse;
  endif;

  //  ... Variable Feldlänge
  if (f_isVarLen(fldl0100) = bTrue);
    isVarLen = bTrue;
  else;
    isVarLen = bFalse;
  endif;

  //  ... Unbekannte Feldart
  if (f_unKnown = bTrue);
    isUnKnown = bTrue;
  else;
    isUnKnown = bFalse;
  endif;

  //  ... Startposition
  $$iBuf = fldl0100.f1IBuf;
  //  ... Keyfeldnummer
  if (f_kSeq <> *zeros);
    $$kSeq = 'K'+%editc(%dec(f_kSeq: 3: 0): 'X');
  else;
    $$kSeq = '';
  endif;
  //  ... Sichtbar
  select;
  when (wrk0001.wrk_hidden = bTrue);
    ##hidden = bFalse;
  when (wrk0001.wrk_hidden = bFalse);
    ##hidden = bTrue;
  other;
    ##hidden = wrk0001.wrk_hidden;
  endsl;
  //  ... Farbe
  ##color = '';
  $$color = wrk0001.wrk_color;
  //  ... Farbmarkierung
  ##markCol = wrk0001.wrk_mrkCol;
  //  ... Max. Anzeigebreite (Größe)
  ##maxSize = wrk0001.wrk_maxSiz;
  //  ... Editcode
  ##edtCde = wrk0001.wrk_edtCde;
  //  ... Original-Editcode
  if (fldl0100.f1EdtC <> '');
    $$edtc = '(' + %trim(fldl0100.f1EdtC) + ')';
    isEditcode = '1';
  else;
    $$edtc = '';
    isEditcode = '0';
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

  setll %kds(w0Key: 1) fpeekwrk;

endsr;

//============================================================*
//    pbSetBZ       Setzen Bezugszahlen                       *
//============================================================*

begsr pbSetBZ;

  //  Editcode
  if (isDecimal = bFalse);
    *in71 = '0';
  else;
    *in71 = '1';
  endif;

  //  Dezimalstellen
  if (isDecimal = bFalse);
    *in72 = '0';
  else;
    *in72 = '1';
  endif;

  //  Kennzeichnung für variable Länge
  if (isVarLen = bFalse);
    *in73 = '0';
  else;
    *in73 = '1';
  endif;

  //  Unbekannter Feldtyp
  if (isUnKnown = bFalse);
    *in74 = '0';
  else;
    *in74 = '1';
  endif;

endsr;

//============================================================*
//    pbSflTxt      Abrufen der Subfiletexte                  *
//============================================================*

begsr pbSflTxt;

  txt0080 = f_msgText('TXT0080': ' ');
  txt0081 = f_msgText('TXT0081': ' ');
  txt0082 = f_msgText('TXT0082': ' ');
  txt0083 = f_msgText('TXT0083': ' ');
  txt0084 = f_msgText('TXT0084': ' ');

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

  r_seq = 0;

  clear f1Key;
  f1Key.f_seq = 0;
  setll %kds(f1Key: 1) fpeekfldl1;

  dow ('1');
    read fpeekfldl1;
    if (%eof(peekFldL1));
      leave;
    endif;

    clear wrk0001;
    clear ds_peekWrk;

    r_seq = r_seq + 10;

    w_key = r_seq;

    wrk0001.wrk_rcdNbr = peek_01_ds.rcdNbr;
    wrk0001.wrk_seq = r_seq;
    wrk0001.wrk_kSeq = f_kSeq;
    wrk0001.wrk_hidden = f_hidden;
    wrk0001.wrk_color = f_color;
    wrk0001.wrk_mrkCol = f_markCol;
    wrk0001.wrk_maxSiz = f_maxSize;
    wrk0001.wrk_edtCde = f_edtCde;

    w_format = 'WRK0001';
    w_data = wrk0001;

    write peekWrk_ ds_peekWrk;
  enddo;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peekFldL1;
  open peekFld;

  exsr clrPeekWrk;
  open peekWrk;
  open peekWrk_;
  exsr copyToWork;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##field = '';

  // - Rückkehrcode
  o_msgID = '';
  o_msgDta = '';

  // - Batchverarbeitung
  select;
  when (i_function = '*FLOATKEYS');
    exsr c_floatKey;
    exsr c_saveExit;
    isBatch = bTrue;
    leavesr;
  other;
    isBatch = bFalse;
    open peek34fm;
  endsl;

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
  peek25_name = f_pgmCallN('PEEK25');
  peek35_name = f_pgmCallN('PEEK35');

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

