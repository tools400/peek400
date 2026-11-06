**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.5.0                               *
//  Programm : PEEK68                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 11.08.2008  Thomas Raddatz                        *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Matchcode Subfile-Auswahl                         *
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

dcl-f peek68fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/define internal_prototype
/copy QCOPYLE,PPEEK68
/undefine internal_prototype

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8136
/copy QCOPYLE,USR8209

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s yChoice char(75) dim(32);
dcl-s yNbrOfCh like(int4_t);

dcl-s isSflError char(1) inz(bFalse);

dcl-s sfTop like(int4_t);
dcl-s sflPage like(int4_t);
dcl-s sflPageDDS like(sflPage);
dcl-s sflRec like(sflPage);
dcl-s sflNbrRcd like(sflPage);
dcl-s sfBot like(int4_t);
dcl-c nbrFKeys 2;
dcl-s sfl_cmd char(10);

dcl-s peek21_name like(pgmCallN_t);
dcl-s peek23_name like(pgmCallN_t);
dcl-s peek27_name like(pgmCallN_t);

dcl-s isEOF like(bool_t) inz(bFalse);
dcl-s key like(key_t);
dcl-s data like(set0000_t);

dcl-s wrk_msgID like(msgId_t);
dcl-s wrk_msgTxt like(msgDta_t);

dcl-ds usrKey qualified inz;
  section like(section_t);
  key     like(key_t);
end-ds;

dcl-ds sflLine qualified inz;
  opt  char(2);
  text char(28) pos(6);
end-ds;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek68;
  i_dsp80     like(dsp80_t) const;
  i_pgm       like(pgm_t) const;
  i_copyright like(copyright_t) const;
  o_sflOpt    like(sfpau_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;

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
  write msgctl;

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
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#6;
  when ((sfBot = 7) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#7;
  when ((sfBot = 8) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#8;
  when ((sfBot = 9) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#9;
  when ((sfBot = 10) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#10;
  when ((sfBot = 11) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#11;
  when ((sfBot = 12) and
     (yNbrOfKeys > nbrFKeys * (sfBot - 1)));
    write pbbot#12;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;
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
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;
  when (yPgmCmd = '*TOP');
    exsr c_top;
    iter;
  when (yPgmCmd = '*BOT');
    exsr c_bot;
    iter;
  when (yPgmCmd = '*MOREOPT');
    exsr c_moreOpt;
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
    if (o_sflOpt = *blanks);
    //  ... keine Auswahl getroffen, weiter machen
    else;
      leave;
    endif;
  when (yPgmCmd = '*PAGEUP');
  when (yPgmCmd = '*PAGEDOWN');

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek68fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vReadC;

endsr;

//============================================================*
//    vReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vReadC;

  isSflError = bFalse;
  o_sflOpt = *blanks;

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
        if (o_sflOpt = *blanks);
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

    //  Ungültige Auswahl: keine Auswahl übernehmen und den
    //  Cursor auf die erste fehlerhafte Zeile setzen
    if (isSflError = bTrue);
      o_sflOpt = *blanks;
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
  exsr pbInit;
  //   Einlesen Subfileauswahlen
  exsr pbInitKey;
  exsr pbSetLL;
  exsr pbReadUp;
  //   Einlesen Kurzbefehle
  if (i_pgm = 'PEEK05');
    exsr pbSeperator;
    exsr pbInitKeyCmd;
    exsr pbSetLL;
    exsr pbReadUp;
  endif;

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

  sflLine = $$line;
  o_sflOpt = sflLine.opt;

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

  usrKey.section = '*' + i_pgm;
  usrKey.key     = '';

endsr;

//============================================================*
//    pbInitKeyCmd  Initialisieren der Schlüsselfelder        *
//                  zum Füllen der Subfile (Kurzbefehle)      *
//============================================================*

begsr pbInitKeyCmd;

  usrKey.section = '*CMD';
  usrKey.key     = '';

endsr;

//============================================================*
//    pbInit        Initialisieren der Subfile zur Anzeige    *
//                  der nächsten Seite                        *
//============================================================*

begsr pbInit;

  *in89 = '0';
  write msgctl;

  *in80 = '0'; // SFLDSP
  *in81 = '1'; // SFLDSPCTL
  *in82 = '1'; // SFLCLR
  *in83 = '1'; // SFLEND
  write pbctl;

  *in82 = '0'; // SFLCLR

  sflRec = *zeros;
  sflNbrRcd = *zeros;

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  dow ('1');
    isEOF = f_readeUsr(usrKey.section: key: data);
    if (isEOF = bTrue);
      leave;
    endif;

    if (key = '' or %subst(key: 1: 1) = '*');
      iter;
    endif;

    exsr pbFill;

    sflRec = sflRec + 1;
    write pbSfl;
    sflNbrRcd = sflRec;

    if (sflRec >= sflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    pbSeperator   Einfügen Trennlinie für Kurzbefehle       *
//============================================================*

begsr pbSeperator;

  if (sflRec >= sflPage);
    leavesr;
  endif;

  clear sflLine;
  sflLine = f_msgText('TXT0141': '');
  $$line = sflLine;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr vSfpauClr;

  //  ... Sperren Eingabefeld
  *in90 = '1'; // SFPAU(PR)

  sflRec = sflNbrRcd + 1;
  write pbSfl;
  sflNbrRcd = sflRec;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  wrk_msgID = f_mapCmdToMsg(data: usrKey.section);
  if (wrk_msgID <> '');
    wrk_msgID  = 'KEY' + wrk_msgID;
    wrk_msgTxt = f_msgText(wrk_msgID: ' ');
  else;
    //  Kurzbefehl ohne eigene Nachricht: Befehl anzeigen
    wrk_msgTxt = data;
  endif;

  clear sflLine;
  sflLine.opt  = key;
  sflLine.text = wrk_msgTxt;
  $$line = sflLine;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Freigeben Eingabefeld
  *in90 = '0'; // SFPAU(PR)

  //  ... Löschen Subfileauswahl
  exsr vSfpauClr;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  p_setllUsr(usrKey.section: usrKey.key);

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

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

  sflPage = *hival;
  sflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek68fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Rückkehrcode
  o_sflOpt = *blanks;
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

  PGMQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek27_name = f_pgmCallN('PEEK27');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: yChoice: yNbrOfCh: *omit: %len($$choice));

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

