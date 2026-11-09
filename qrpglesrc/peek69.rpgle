**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Auswahl Datei                                *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 3.2.4                               *
//  Programm : PEEK69                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 05.11.2010  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Auswahl Datei                                     *
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

dcl-f peek69fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-ds workstn likeds(workstn_t);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/objl0200.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/usr0010.rpgleinc'
/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8110.rpgleinc'
/copy 'qcopyle/usr8194.rpgleinc'
/copy 'qcopyle/usr8209.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek69.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek27.rpgleinc'
/copy 'qcopyle/ppeek70.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

//  Retrieve Display Mode       Return value: Display Mode
dcl-pr QsnRtvMod char(1) extproc('QsnRtvMod');
  o_dspMode    char(1) options(*omit);
  i_hLowLvlEnv int(10) options(*omit) const;
  io_errCode   char(32767) options(*omit: *varsize);
end-pr;

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s yChoice char(75) dim(32);
dcl-s yNbrOfCh like(int4_t);

dcl-ds yQFile likeds(qObj_t) inz;
dcl-ds rtnFile likeds(qObj_t) inz;

dcl-s isNewPos char(1) inz(bFalse);
dcl-s isFound char(1) inz(bFalse);
dcl-s isSflError char(1) inz(bFalse);

dcl-s sfTop like(int4_t) inz;
dcl-s sflPage like(int4_t) inz;
dcl-s sflPageDDS like(sflPage) inz;
dcl-s sflRec like(sflPage) inz;
dcl-s sflNbrRcd like(sflPage) inz;
dcl-s sfBot like(int4_t) inz;
dcl-s sfl_cmd char(10) inz(*blanks);
dcl-c NbrFKeys 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek70_name like(pgmCallN_t) inz;

dcl-s r_file inz(*blanks) like(##file);
dcl-s lstFile inz(*blanks) like(##file);
dcl-s lstNbrRcd inz(0) like(sflPage);
dcl-s srchRec like(sflPage);

//  Dateinamen der Subfile für die Suche
dcl-s sfl_files like($$fNme) dim(9999);

dcl-s wrk_sfsanr like(sfsanr);

dcl-s numFiles like(int4_t);
dcl-ds objl0200 likeds(objl0200_t) inz;

dcl-s dspModeRaw char(1);
dcl-ds errCode likeds(errCode_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek69;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  o_qFile     like(qObj_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

dcl-s do_x1 packed(7);
dcl-s do_x2 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= *zeros);
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

  //  Anzeigen der Einzelauswahlen
  if (sfTop > 32
      or sfTop > yNbrOfCh);
    sfTop = 1;
  endif;
  $$choice = yChoice(sfTop);

  //  Trennlinie
  write pbbot#0;
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
  when ((sfBot = 7) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#7;
  when ((sfBot = 8) and
     (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
    write pbbot#8;
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

  //  F5  - Aktualisieren
  when (yPgmCmd = '*REFRESH');
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

  //  F23 - Weitere Auswahlen
  when (yPgmCmd = '*MOREOPT');
    exsr c_moreOpt;

  //  F24 - Weitere Tasten
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;

  //  Datenfreigabe
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (rtnFile.name = *blanks);
    //  ... keine Auswahl getroffen, weiter machen
    else;
      o_qFile = rtnFile;
      leave;
    endif;
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

close peek69fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vReadC;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##file <> '' and isSflError = bFalse);
    exsr c_search;
  endif;

endsr;

//============================================================*
//    c_search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##file <> '');
    lstFile = ##file;
    ##file = '';
  endif;

  if (lstFile = '');
    *in70 = '1';
    clear usr8209;
    p_sndPgmMg('USR8209': usr8209: sds.pgmName);
  else;
    exsr posToMbr;
    if (isNewPos = bTrue);
      sfsanr = wrk_sfsanr;
    endif;
  endif;

endsr;

//============================================================*
//    posToMbr      Subfile neu positionieren                 *
//============================================================*

begsr posToMbr;

  if (lstFile <> r_file);
    lstNbrRcd = 0;
  endif;

  if (lstFile = *blanks);
    isNewPos = bFalse;
    lstNbrRcd = 0;
  else;

    exsr srchMbr;
    if (isFound = bFalse);
      isNewPos = bFalse;
      clear usr8194;
      usr8194.var1 = lstFile;
      p_sndPgmMg('USR8194': usr8194: sds.pgmName);
    else;
      isNewPos = bTrue;
    endif;
  endif;

  r_file = lstFile;

endsr;

//============================================================*
//    srchMbr       Suchen Member in Subfile                  *
//============================================================*

begsr srchMbr;

  if (*in80 = *off);
    isFound = bFalse;
  else;

    isFound = bFalse;
    lstNbrRcd = lstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Dateinamen: CHAIN und UPDATE auf die Subfile setzten die
    //  Markierung ungültiger Auswahlen (*IN85) zurück.
    for srchRec = lstNbrRcd to sflNbrRcd;
      if (srchRec > %elem(sfl_files));
        leave;
      endif;

      if (lstFile =
          %subst(sfl_files(srchRec): 1: %len(%trimr(lstFile))));
        isFound = bTrue;
        leave;
      endif;
    endfor;

    if (isFound = bTrue);
      wrk_sfsanr = srchRec;
      lstNbrRcd = srchRec;
    else;
      wrk_sfsanr = 0;
      lstNbrRcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    srchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr srchInit;

  lstFile   = '';
  lstNbrRcd = 0;
  r_file    = lstFile;

endsr;

//============================================================*
//    vReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vReadC;

  isSflError = bFalse;
  clear rtnFile;

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
        //  Leere Auswahl: Markierung eines früheren Fehlers
        //  löschen
        exsr vSfpauClr;
      when (sfl_cmd = '*SELECT');
        //  Die erste Auswahl merken. Ausgeführt wird sie nur,
        //  wenn keine Zeile eine ungültige Auswahl enthält.
        if (rtnFile.name = *blanks);
          exsr vPos;
        endif;
        *in85 = '0'; // DSPATR(RI)
        exsr vSfpauChg;
      other;
        //  Unbekannter Programmbefehl
        clear usr8110;
        usr8110.var1 = yPgmCmd;
        p_sndPgmMg('USR8110': usr8110: sds.pgmName);
        exsr vSfpauErr;
        update pbSfl;
        isSflError = bTrue;
        iter;
      endsl;

      update pbSfl;
    endfor;

    //  Ungültige Auswahl: keine Datei übernehmen und den
    //  Cursor auf die erste fehlerhafte Zeile setzen
    if (isSflError = bTrue);
      clear rtnFile;
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
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Subfile neu aufbauen
  exsr pbInitKey;
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
//    c_moreOpt     F23 - Weitere Auswahlen                   *
//============================================================*

begsr c_moreOpt;

  sfTop = sfTop + 1;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    vPos          Verarbeiten der Eingaben                  *
//============================================================*

begsr vPos;

  rtnFile.name = $$fNme;
  rtnFile.lib = $$lNme;

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
//    pbInitKey     Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile                    *
//============================================================*

begsr pbInitKey;

  yQFile = o_qFile;

  if (yQFile.name = '');
    yQFile.name = '*ALL';
  endif;

  if (yQFile.lib = '');
    yQFile.lib = '*LIBL';
  endif;

  //  Bibliothek prüfen (nicht die Sonderwerte wie *LIBL): PEEK70
  //  liefert für eine unbekannte Bibliothek nur eine leere Liste.
  if (%subst(yQFile.lib: 1: 1) <> '*' and
      not f_exist(yQFile.lib: 'QSYS': '*LIB'));
    clear usr0010;
    usr0010.var1 = yQFile.lib;
    p_sndPgmMg('USR0010': usr0010: sds.pgmName);
    numFiles = 0;
  else;
    peek70(yQFile: '*CREATE': numFiles: objl0200);
  endif;

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

  dow (numFiles > 0);
    peek70(yQFile: '*READ': numFiles: objl0200);
    if (not (objl0200.o2xatr = 'PF' or
          objl0200.o2xatr = 'LF'));
      iter;
    endif;

    exsr pbFill;

    sflRec = sflRec + 1;
    write pbSfl;
    sflNbrRcd = sflRec;
    if (sflRec <= %elem(sfl_files));
      sfl_files(sflRec) = $$fNme;
    endif;

    if (sflRec >= sflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  //  ... File name
  $$fNme = objl0200.o2ONme;
  //  ... Library name
  $$lNme = objl0200.o2LNme;
  //  ... Text description
  $$fTxt = objl0200.o2Text;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr vSfpauClr;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  clear errCode;
  QsnRtvMod(dspModeRaw: *omit: errCode);

  if (dspModeRaw = '4');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 2;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 2;
    pos = 5;
  endif;

  sflPage = 9999;
  sflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek69fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##file = *blanks;

  // - Rückkehrcode
  clear rtnFile;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Darstellung der Subfile
  sflMde = '1';

  // - Darstellung der Befehlstasten
  sfTop = 1;
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
  peek27_name = f_pgmCallN('PEEK27');
  peek70_name = f_pgmCallN('PEEK70');

  peek23(sds.pgmName: '*ALL': NbrFKeys
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: yChoice: yNbrOfCh: *omit
        : %len($$choice));

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

