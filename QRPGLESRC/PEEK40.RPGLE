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

dcl-f peek40fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

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
dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

dcl-s yChoice char(75) dim(32);
dcl-s yNbrOfCh like(int4_t) inz;

dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-ds yQFile likeds(qObj_t) inz;
dcl-s yMbr char(10) inz(*blanks);
dcl-s yData char(512) inz(*blanks);

dcl-s isNewPos char(1) inz(bFalse);
dcl-s isFound char(1) inz(bFalse);
dcl-s isSflError char(1) inz(bFalse);

dcl-s rc like(int4_t) inz;
dcl-s numRel like(int4_t) inz;
dcl-s numKey like(int4_t) inz;
dcl-s numSel like(int4_t) inz;

dcl-s sflPage like(int4_t) inz;
dcl-s sfTop like(int4_t) inz;
dcl-s sflPageDDS inz(0) like(sflPage);
dcl-s sflRec inz(0) like(sflPage);
dcl-s sflNbrRcd inz(0) like(sflPage);
dcl-s sfBot like(int4_t) inz;
dcl-c NbrFKeys 2;
dcl-s sfl_cmd char(10) inz(*blanks);

dcl-c UNIQUE '*UNIQUE';

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek39_name like(pgmCallN_t) inz;
dcl-s peek41_name like(pgmCallN_t) inz;

dcl-s r_file inz(*blanks) like(##file);
dcl-s lstFile inz(*blanks) like(##file);
dcl-s lstNbrRcd inz(0) like(sflPage);
dcl-s sPos like(int4_t) inz;
dcl-s srchRec inz(0) like(sflPage);
//  Dateinamen der Subfile-Sätze für die Suche
dcl-s sfl_files like($$file) dim(9999);

dcl-s wrk_sfsanr inz(*zeros) like(sfsanr);

dcl-s buffer char(2000);

dcl-s strPos like(uint4_t) inz;

dcl-s pFile inz(*blanks) like(i_file);
dcl-s pLib inz(*blanks) like(i_lib);
dcl-s pMbr inz(*blanks) like(i_mbr);
dcl-s pFmtName inz(*blanks) like(i_rcdFmt);

dcl-ds fild0100 likeds(fild0100_t) inz;
dcl-ds keyl0100 likeds(keyl0100_t) inz;
dcl-ds dbrl0200 likeds(dbrl0200_t) inz;
dcl-ds sell0100 likeds(sell0100_t) inz;

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

exsr first;
if (o_msgID = '');

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
    when ((sfBot = 9) and
       (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
      write pbbot#9;
    when ((sfBot = 10) and
       (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
      write pbbot#10;
    when ((sfBot = 11) and
       (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
      write pbbot#11;
    when ((sfBot = 12) and
       (yNbrOfKeys > NbrFKeys * (sfBot - 1)));
      write pbbot#12;
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
      if (o_file = *blanks);
      //  ... keine Auswahl getroffen, weiter machen
      else;
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

endif;

close peek40fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr vReadC;

  //  Erst die ungültigen Auswahlen korrigieren, dann suchen; der
  //  Suchbegriff bleibt bis dahin stehen.
  if (##file <> *blanks and isSflError = bFalse);
    exsr c_search;
  endif;

endsr;

//============================================================*
//    c_search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##file <> *blanks);
    lstFile = ##file;
    ##file = *blanks;
  endif;

  if (lstFile = *blanks);
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

  if (lstFile <> r_file);
    lstNbrRcd = 0;
  endif;

  if (lstFile = *blanks);
    isNewPos = bFalse;
    lstNbrRcd = 0;
  else;

    exsr srchField;
    if (isFound = bFalse);
      isNewPos = bFalse;
      //  USR8194: Datei '&1' nicht gefunden. (##file ist schon gelöscht)
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
//    srchField     Suchen Feld in Subfile                    *
//============================================================*

begsr srchField;

  if (*in80 = *off);
    isFound = bFalse;
  else;

    isFound = bFalse;
    lstNbrRcd = lstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten
    //  Dateinamen: Nach einem CHAIN auf die Subfile lieferte READC
    //  Zeilen mit Eingabefehlern (SFLNXTCHG) nicht mehr.
    for srchRec = lstNbrRcd to sflNbrRcd;
      sPos = %check(' ': sfl_files(srchRec));
      if (sPos <= 0);
        sPos = 1;
      endif;

      if (lstFile  =
          %subst(sfl_files(srchRec): sPos:(f_scan(' ':
                            lstFile) - 1)));
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

  lstFile   = ' ';
  lstNbrRcd = 0;
  r_file    = lstFile;

endsr;

//============================================================*
//    vReadC        Verarbeiten der Subfileauswahlen          *
//============================================================*

begsr vReadC;

  isSflError = bFalse;
  o_file = *blanks;

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

      exsr bzToScreen;

      //  Cursorpositionierung ...
      if (isSflError = bFalse);
        sflCsr = sflRec;
      else;
      //  Subfile nicht neu positionieren
      endif;

      //  Linksbündig setzen ...
      sfpau = %triml(sfpau);

      //  Leere Auswahl wird nicht geprüft. Nur eine alte
      //  Fehlermarkierung (RI, SFLNXTCHG) wird entfernt.
      if (sfpau = *blanks);
        exsr vSfpauClr;
        exsr bzToSubf;
        update pbSfl;
        iter;
      endif;

      //  Zuordnung AUSWAHL => Befehl ...
      peek21('#' + sfpau: sds.pgmName
            : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
      if (yMsgID <> *blanks);
        //  Fehlermeldung ...
        p_sndPgmMg('USR8110': sfpau: sds.pgmName);
        exsr vSfpauErr;

        exsr bzToSubf;
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
      when (sfl_cmd = '*SELECT');
        //  Die erste Auswahl merken. Ausgeführt wird sie nur, wenn keine
        //  Zeile eine ungültige Auswahl enthält.
        if (o_file = *blanks);
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

        exsr bzToSubf;
        update pbSfl;
        isSflError = bTrue;
        iter;
      endsl;

      exsr bzToSubf;
      update pbSfl;
    endfor;

    //  Ungültige Auswahl: keine Auswahl übernehmen und den Cursor auf
    //  die erste fehlerhafte Zeile setzen (sfsanr wird sonst nur nach
    //  der Anzeige aus SFLCSRRRN gesetzt)
    if (isSflError = bTrue);
      o_file = *blanks;
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

  o_file = h_file;
  o_lib = h_lib;

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
  $$depFile = 0;

endsr;

//============================================================*
//    pbReadUp      Vorwärts füllen der Subfile               *
//============================================================*

begsr pbReadUp;

  for do_x3 = 1 to numRel;

    peek39(yQFile: yMbr
          : '*READ': rc: dbrl0200);

    if (dbrl0200.b2DepFile = '*NONE');
      iter;
    endif;

    if (dbrl0200.b2DepType <> 'D');
      iter;
    endif;

    $$depFile = $$depFile + 1;

    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      //  ... die physische Datei anzeigen
      h_file = dbrl0200.b2FNmeUsed;
      h_lib = dbrl0200.b2LNmeUsed;
      //**                EXSR      statMsg
      exsr pbFill;
      exsr pbFillKey;
      exsr pbFillSel;
    endif;

    //  Anzeigen der logischen Sichten
    h_file = dbrl0200.b2DepFile;
    h_lib = dbrl0200.b2DepLib;
    //**                EXSR      statMsg
    exsr pbFill;
    exsr pbFillKey;
    exsr pbFillSel;
  endfor;

  //  Bei erstem Datensatz, ...
  if (*in80 = *off);
    //  ... die physische Datei anzeigen
    clear dbrl0200;
    h_file = i_file;
    h_lib = i_lib;
    dbrl0200.b2LNmeUsed = i_lib;
    //**                EXSR      statMsg
    exsr pbFill;
    exsr pbFillKey;
    exsr pbFillSel;
  endif;

endsr;

//============================================================*
//    statMsg       Statusnachricht ausgeben                  *
//============================================================*

begsr statMsg;

  //  Nachricht ausgeben ...
  clear usr8172;
  usr8172.var1 = %trimr(h_lib) + '/' + h_file;
  p_sndStsMg('USR8172': usr8172);

endsr;

//============================================================*
//    bzToScreen    Übertragen Bezugszahlen in Bildschirm     *
//============================================================*

begsr bzToScreen;

  *in20 = h_in20;
  *in71 = h_in71;

endsr;

//============================================================*
//    bzToSubf      Übertragen Bezugszahlen in Subfile        *
//============================================================*

begsr bzToSubf;

  h_in20 = *in20;
  h_in71 = *in71;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  //  Datensatz komplett anzeigen ...
  *in71 = '0';

  //  Abhängigkeit prüfen ...
  if (dbrl0200.b2LNmeUsed = h_lib or
     *in80 = '0');
    *in20 = '0';
  else;
    *in20 = '1';
  endif;

  //  Einlesen der Dateiinformationen ...
  yQFile.name = h_file;
  yQFile.lib = h_lib;
  peek41(yQFile
        : '*FIRST': '*CREATE': rc: yData);
  //  ... Bezeichnung
  peek41(yQFile
        : '*FIRST': '*READTEXT': rc: yData);
  $$fTxt = yData;

  //  Schreiben der Subfile ...
  exsr pbWrite;

endsr;

//============================================================*
//    pbFillKey     Füllen Subfilesatz, Schlüsselfelder       *
//============================================================*

begsr pbFillKey;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Schlüsselinformationen ...
  peek41(yQFile
        : '*FIRST': '*KEY': numKey: yData);

  buffer = *blanks;

  for do_x4 = 1 to numKey;
    peek41(yQFile
          : '*FIRST': '*READKEY': rc: yData);
    keyl0100 = yData;

    if (keyl0100.apkseq = 'D');
      buffer = %trimr(buffer) + COLOR_white;
    else;
      buffer = %trimr(buffer) + COLOR_green;
    endif;

    buffer = %trimr(buffer) + keyl0100.apkeyf;
  endfor;

  if (numKey >= 1 and
     keyl0100.apuniq = 'Y');
    buffer = %trimr(buffer) + COLOR_white + UNIQUE;
  endif;

  buffer = %trimr(buffer) + COLOR_green;

  strPos = 1;
  dou (strPos = 0);
    $$fTxt = f_wordWrap(
                  buffer: %len($$fTxt): strPos);
    //  Schreiben der Subfile ...
    exsr pbWrite;
    if (strPos > 0 and
       %subst(buffer: 1: strPos-1) < x'40');
      //     Positionieren auf Farb-Attribut
      strPos = strPos - 1;
    endif;
  enddo;

endsr;

//============================================================*
//    pbFillSel     Füllen Subfilesatz, SELECT/OMIT           *
//============================================================*

begsr pbFillSel;

  //  Datensatz nicht komplett anzeigen ...
  *in71 = '1';

  //  Einlesen der Select/Omit Informationen ...
  peek41(yQFile
        : '*FIRST': '*SELECT': numSel: yData);

  for do_x5 = 1 to numSel;
    peek41(yQFile
          : '*FIRST': '*READSEL': rc: yData);
    sell0100 = yData;

    //  Wenn das Ende der Liste rreicht ist, ...
    if (sell0100.socomp = 'AL');
    //  ... dann den Eintrag überlesen
    else;
      //  ... ansonsten den Eintrag aufbereiten und anzeigen
      select;
      when (sell0100.sorule = 'S');
        buffer = COLOR_white + '*SELECT';
      when (sell0100.sorule = 'O');
        buffer = COLOR_white + '*OMIT';
      other;
        buffer = COLOR_white;
      endsl;

      %subst(buffer: 10: %len(sell0100.sofld)) =
       sell0100.sofld;
      %subst(buffer: 21: %len(sell0100.socomp)) =
       sell0100.socomp;
      buffer = %trimr(buffer) + ' ' +
              sell0100.sovalu + COLOR_green;
      $$fTxt = buffer;
      //  Schreiben der Subfile ...
      exsr pbWrite;
    endif;

  endfor;

endsr;

//============================================================*
//    pbWrite       Schreiben der Subfile                     *
//============================================================*

begsr pbWrite;

  //  Datensatz nicht komplett anzeigen ...
  if (*in71 = *on);
    $$file = *blanks;
    $$lib = *blanks;
  else;
    //  Bei erstem Datensatz, ...
    if (*in80 = *off);
      $$file = h_file;
      $$lib = h_lib;
    else;
      $$file = ' ' + h_file;
      $$lib = h_lib;
    endif;
  endif;

  //  Anzeigen der Subfile ...
  *in80 = '1';

  //  Löschen Subfileauswahl ...
  exsr vSfpauClr;

  //  Schreiben des Subfilesatzes ...
  sflRec = sflRec + 1;
  exsr bzToSubf;
  write pbSfl;
  sflNbrRcd = sflRec;
  sfl_files(sflRec) = $$file;

  if (h_file = i_file and h_lib = i_lib and *in71 = *off);
    sfsanr = sflRec;
  endif;

endsr;

//============================================================*
//    pbSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr pbSetLL;

  yQFile.name = pFile;
  yQFile.lib = pLib;
  yMbr = pMbr;

  peek39(yQFile: yMbr
        : '*CREATE': numRel: dbrl0200);

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

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

  sflPage = *hival;
  sflPageDDS = 6;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek40fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  ##file = *blanks;
  r_file = ##file;

  // - Rückkehrcode
  o_file = *blanks;
  o_lib = *blanks;
  o_msgID = *blanks;
  o_msgDta = *blanks;

  // - Dateityp feststellen
  pFile = i_file;
  pLib = i_lib;
  pMbr = i_mbr;
  pFmtName = i_rcdFmt;

  //   ... Einlesen der Dateiinformationen
  yQFile.name = pFile;
  yQFile.lib = pLib;
  peek41(yQFile
        : pFmtName: '*CREATE': rc: yData);

  if (rc = *zeros);
    //       ... Fehler
    o_msgID = 'USR0008';
    clear usr0008;
    usr0008.var1 = yQFile.name;
    usr0008.var2 = yQFile.lib;
    o_msgDta = usr0008;
  else;
    //       ... kein Fehler
    fild0100 = yData;
    if (fild0100.atfila = '*LGL');
      //           ... logical file
      peek41(yQFile
            : pFmtName: '*BASED-ON': rc: yData);
      if (rc = *zeros);
        //               ... Fehler
        o_msgID = 'USR0008';
        clear usr0008;
        usr0008.var1 = yQFile.name;
        usr0008.var2 = yQFile.lib;
        o_msgDta = usr0008;
      else;
        if (i_basePhyF = bTrue);
          //                   ... based-on
          pFile = %subst(yData: 1: 10);
          pLib  = %subst(yData: 11: 10);
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
    sflMde = '1';

    // -  Darstellung der Auswahlen/Funktionstasten
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

  pgmQ = '*';

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');
  peek27_name = f_pgmCallN('PEEK27');
  peek39_name = f_pgmCallN('PEEK39');
  peek41_name = f_pgmCallN('PEEK41');

  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

  peek27(sds.pgmName: yChoice: yNbrOfCh);

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

