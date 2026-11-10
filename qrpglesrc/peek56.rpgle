**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Auswählen 'Arbeitsumgebung'                  *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK56                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 05.04.1999  Raddatz                               *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Auswählen "Arbeitsumgebung"                       *
//                                                               *
//===============================================================*
/copy 'qcopyle/h_spec.rpgleinc'
/copy 'qcopyle/copyright.rpgleinc'

dcl-f peek56fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbSfl: sflRec);

dcl-f peekEnv keyed usropn extfile(g_envFile) extmbr(g_envMbr) prefix(en_);

dcl-ds workstn likeds(workstn_t);

dcl-s g_envFile char(21);
dcl-s g_envMbr char(10);

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/mbrl0200.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/set0015.rpgleinc'

/copy 'qcopyle/usr8100.rpgleinc'
/copy 'qcopyle/usr8110.rpgleinc'
/copy 'qcopyle/usr8180.rpgleinc'
/copy 'qcopyle/usr8181.rpgleinc'
/copy 'qcopyle/usr8182.rpgleinc'
/copy 'qcopyle/usr8184.rpgleinc'
/copy 'qcopyle/usr8209.rpgleinc'
/copy 'qcopyle/usr8233.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek56.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek27.rpgleinc'
/copy 'qcopyle/ppeek46.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s yExclKeys like(pgmCmd_t) dim(25);
dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

//  Peek46:
dcl-ds yQFile;
  yFile char(10) inz;
  yLib  char(10) inz;
end-ds;
dcl-s numMbr like(int4_t) inz;

dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-s yChoice char(75) dim(32);
dcl-s yNbrOfCh like(int4_t) inz;

dcl-s isNewPos char(1) inz(bFalse);
dcl-s isFound char(1) inz(bFalse);
dcl-s isSflError char(1) inz(bFalse);
dcl-s isCtlError char(1) inz(bFalse);
dcl-s isDirty char(1) inz(bFalse);

dcl-s sfTop like(int4_t) inz;
dcl-s sflPage like(int4_t) inz;
dcl-s sflPageDDS like(sflPage) inz;
dcl-s sflRec like(sflPage) inz;
dcl-s sflNbrRcd like(sflPage) inz;
dcl-s sfBot like(int4_t) inz;
dcl-s sfl_cmd char(10) inz(*blanks);
dcl-s ctl_cmd char(10) inz(*blanks);
dcl-c NbrFKeys 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek46_name like(pgmCallN_t) inz;

dcl-s r_mbr inz(*blanks) like(##mbr);
dcl-s lstMbr inz(*blanks) like(##mbr);
dcl-s lstNbrRcd inz(0) like(sflPage);
dcl-s srchRec inz(0) like(sflPage);
//  Namen der Umgebungen (Teildateien) der Subfile-Sätze für die Suche
dcl-s sfl_mbrs like($$mNme) dim(9999);

dcl-s wrk_sfsanr inz(*zeros) like(sfsanr);

dcl-s lastFile like(##file) inz;
dcl-s lastLib like(##lib) inz;
dcl-s isPrdLib like(bool_t) inz(bFalse);

dcl-s rcdFmtID like(fmtId_t);
dcl-ds mbrl0200 likeds(mbrl0200_t) inz;

dcl-pr f_isVldOpt like(bool_t);
  i_option like(sfpau);
  o_msgID  like(msgId_t);
  o_msgDta like(msgDta_t);
end-pr;

dcl-pr f_loadRcdFmtID like(fmtId_t);
end-pr;

dcl-ds set0015 likeds(set0015_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek56;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  i_mode      like(mode_t) const;
  i_envFile   like(file_t) const;
  i_envLib    like(lib_t) const;
  i_envMbr    like(mbr_t) const;
  i_rcdFmtID  like(fmtId_t) const;
  o_qFile     likeds(qObj_t);
  o_mbr       like(mbr_t);
  o_text      like(text_t);
  o_option    like(option_t);
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

  //  Anzeigen der Einzelauswahlen
  if (sfTop > 32 or sfTop > yNbrOfCh);
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

  //  Bezugszahlen löschen
  exsr clrIndCtl;

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
    if (isCtlError = bFalse);
      exsr setUsrSetg;
    endif;
    if (o_mbr = *blanks
        or isCtlError = bTrue
        or isSflError = bTrue);
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

if (workstn.isOpen = '1');
  close peek56fm;
endif;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  isCtlError = bFalse;
  isDirty = bFalse;

  //  Prüfen der Eingaben im Kontrollsatz
  exsr vCtl;

  //  Wenn alles OK ist und die Subfile weiterhin gültig ist, ...
  if (isCtlError = bFalse and isDirty = bFalse);
    // ... dann
    //     Wenn der Teildateiname gefüllt ist, ...
    if (##mnme <> '');
      // ... dann
      //     füllen der Rückgabeparameter
      o_qFile.name = ##file;
      o_qFile.lib = ##lib;
      o_mbr    = ##mnme;
      o_text   = ##mtxt;
      o_option = ctl_cmd;
    else;
      // ... sonst
      //     prüfen der Subfile
      exsr vReadC;

    endif;
  endif;

  // Wenn die Subfile ungültig ist, ...
  if (isDirty = bTrue);
    // ... dann
    //     aktualisieren der Subfile
    exsr c_refresh;
  else;
    // ... sonst
    //     Wenn die Teildatei ausgefüllt ist, ...
    if (##mbr <> '');
      // ... dann
      //     ausführen Suchfunktion
      exsr c_search;
    else;
      // ... sonst
      //     prüfen der Dateiangaben
      exsr chkFile;
    endif;
  endif;

endsr;

//============================================================*
//    c_search      F16 - Suchen                              *
//============================================================*

begsr c_search;

  if (##mbr <> '');
    lstMbr = ##mbr;
    ##mbr = *blanks;
  endif;

  if (lstMbr = '');
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

  if (lstMbr <> r_mbr);
    lstNbrRcd = 0;
  endif;

  if (lstMbr = '');
    isNewPos = bFalse;
    lstNbrRcd = 0;
  else;

    exsr srchMbr;
    if (isFound = bFalse);
      isNewPos = bFalse;
      clear usr8180;
      usr8180.var1 = lstMbr;
      p_sndPgmMg('USR8180': usr8180: sds.pgmName);
    else;
      isNewPos = bTrue;
    endif;
  endif;

  r_mbr = lstMbr;

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

    //  Die Suche liest die Subfile nicht, sondern die gemerkten Namen:
    //  Die Sätze bleiben unverändert, auch Auswahlen und deren
    //  Fehlermarkierungen.
    for srchRec = lstNbrRcd to sflNbrRcd;
      if (lstMbr = %subst(sfl_mbrs(srchRec): 1:(f_scan(' ': lstMbr) - 1)));
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

  lstMbr = '';
  lstNbrRcd = 0;
  r_mbr = lstMbr;

endsr;

//============================================================*
//    vCtl          Verarbeiten der Eingaben Kontrollsatz     *
//============================================================*

begsr vCtl;

  // - Funktion nicht freigeschaltet
  if (##file = '' or ##lib  = '' or set0015.set_envena = bFalse);
    clear usr8184;
    p_sndPgmMg('USR8184': usr8184: sds.pgmName);
    isCtlError = bTrue;
    exsr posCsr;
    leavesr;
  endif;

  //  ##lib
  exsr prf41;
  if (isCtlError = bTrue);
    leavesr;
  endif;

  //  ##file
  exsr prf40;
  if (isCtlError = bTrue);
    leavesr;
  endif;

  if (isDirty = bFalse);
    //  ##CTLAU
    exsr prf20;
    if (isCtlError = bTrue);
      leavesr;
    endif;

    if (##ctlau <> '' or ##mnme  <> '' or ##mtxt  <> '');
      //  ##MNME
      exsr prf21;
      if (isCtlError = bTrue);
        leavesr;
      endif;

      //  ##MTXT
      exsr prf22;
      if (isCtlError = bTrue);
        leavesr;
      endif;

    endif;
  endif;

endsr;

//============================================================*
//    Prf40         Prüfen ##file                             *
//============================================================*

begsr prf40;

  dou ('1');

    //  gültiger Name ?
    if (f_vldName(##file: yMsgID: yMsgDta) = bTrue);
      isCtlError = bFalse;
    else;
      isCtlError = bTrue;
      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
      leave;
    endif;

    //  Prüfen Datei
    //  ------------
    f_exist(##file: ##lib: '*FILE': '*NONE': yMsgID: yMsgDta);

    if (yMsgID <> '');
      isCtlError = bTrue;
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      leave;
    else;
      isCtlError = bFalse;
    endif;

    //  Datei geändert ?
    if (##file <> lastFile);
      isDirty = bTrue;
      leave;
    endif;


  enddo;

  if (isCtlError = bTrue);
    *in40 = *on;
    *in50 = *on;
  endif;

endsr;

//============================================================*
//    Prf41         Prüfen ##lib                              *
//============================================================*

begsr prf41;

  dou ('1');

    //  gültiger Name ?
    if (f_vldName(##lib: yMsgID: yMsgDta) = bTrue);
      isCtlError = bFalse;
    else;
      isCtlError = bTrue;
      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
      leave;
    endif;

    //  Prüfen Bibliothek
    //  -----------------
    f_exist(##lib: *omit: '*LIB': *omit: yMsgID: yMsgDta);
    if (yMsgID <> '');
      isCtlError = bTrue;
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      leave;
    else;
      isCtlError = bFalse;
    endif;

    //  Bibliothek geändert ?
    if (##lib <> lastLib);
      isDirty = bTrue;
      leave;
    endif;

  enddo;

  if (isCtlError = bTrue);
    *in41 = *on;
    *in51 = *on;
  endif;

endsr;

//============================================================*
//    Prf20         Prüfen ##CTLAU                            *
//============================================================*

begsr prf20;

  dou ('1');

    //  Zuordnung AUSWAHL => Befehl ...
    isCtlError =
     f_isVldOpt(##ctlau: yMsgID: yMsgDta);
    if (isCtlError = bTrue);
      ctl_cmd = ' ';
      if (yMsgID <> '');
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
      endif;
      leave;
    endif;

    ctl_cmd = yPgmCmd;

    if ((##mnme  <> '' or ##mtxt  <> '') and ##ctlau = ' ');
      clear usr8110;
      usr8110.var1   = ##ctlau;
      p_sndPgmMg('USR8110': usr8110: sds.pgmName);
      isCtlError = bTrue;
      leave;
    endif;

  enddo;

  if (isCtlError = bTrue);
    *in20 = *on;
    *in30 = *on;
  endif;

endsr;

//============================================================*
//    Prf21         Prüfen ##MNME                             *
//============================================================*

begsr prf21;

  //  gültiger Name ?
  if (f_vldName(##mnme: yMsgID: yMsgDta) = bTrue);
    isCtlError = bFalse;
  else;
    isCtlError = bTrue;
    if (yMsgID <> '');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
    endif;
  endif;


  if (yMsgID = 'CPD0078');
    p_sndPgmMg('CPD0078': yMsgDta: sds.pgmName);
    isCtlError = bTrue;
  endif;

  if (isCtlError = bTrue);
    *in21 = *on;
    *in31 = *on;
  endif;

endsr;

//============================================================*
//    Prf22         Prüfen ##MTXT                             *
//============================================================*

begsr prf22;

  if (isCtlError = bTrue);
    *in22 = *on;
    *in32 = *on;
  endif;

endsr;

//============================================================*
//    chkFile       Prüfen/Anlegen Env.Datei                  *
//============================================================*

begsr chkFile;

  if (o_qFile.name = '' and o_qFile.lib  = '' and o_mbr  = '');
    exsr clrFileP;
    leavesr;
  endif;

  //  Prüfen Datei
  //  ------------
  f_exist(o_qFile.name: o_qFile.lib: '*FILE': '*NONE': yMsgID: yMsgDta);

  //  Wenn die Datei nicht gefunden werden konnte, ...
  if (yMsgID = 'CPF9801');
    //  ... dann
    //      anlegen Datei
    f_execute('CRTDUPOBJ'         +
              ' OBJ('             +
               'PEEKENV'          +
              ')'                 +
              ' FROMLIB('         +
              %trim(sds.pgmLib)   +
              ')'                 +
              ' OBJTYPE('         +
              '*FILE'             +
              ')'                 +
              ' TOLIB('           +
              %trim(o_qFile.lib ) +
              ')'                 +
              ' NEWOBJ('          +
              %trim(o_qFile.name) +
              ')'                 :
              yMsgID              :
              yMsgDta             );

    if (yMsgID = '');
      f_execute('RMVM'              +
                ' FILE('            +
                %trim(o_qFile.lib ) +
                '/'                 +
                %trim(o_qFile.name) +
                ')'                 +
                ' MBR('             +
                 '*ALL'             +
                ')'                 :
                yMsgID              :
                yMsgDta             );

      yMsgID  = '';
      yMsgDta = '';
    endif;
  endif;

  if (yMsgID <> '');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    exsr clrFileP;
    leavesr;
  endif;

  //  Prüfen Teildatei
  //  ----------------
  f_exist(o_qFile.name: o_qFile.lib: '*FILE': o_mbr: yMsgID: yMsgDta);

  //  Wenn die Teildatei nicht gefunden werden konnte, ...
  if (yMsgID = 'CPF9815');
    //  ... dann
    //      anlegen Teildatei
    f_execute('ADDPFM'            +
              ' FILE('            +
              %trim(o_qFile.lib ) +
              '/'                 +
              %trim(o_qFile.name) +
              ')'                 +
              ' MBR('             +
              %trim(o_mbr )       +
              ')'                 :
              yMsgID              :
              yMsgDta             );
  endif;

  if (yMsgID <> '');
    p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
    yMsgID = '';
    yMsgDta = '';
    exsr clrFileP;
    leavesr;
  endif;

  //  Ändern Teildateitext
  //  --------------------
  if (o_text <> '');
    f_execute('CHGPFM'            +
              ' FILE('            +
              %trim(o_qFile.lib ) +
              '/'                 +
              %trim(o_qFile.name) +
              ')'                 +
              ' MBR('             +
              %trim(o_mbr )       +
              ')'                 +
              ' TEXT('''          +
              %scanrpl('''': '''''': %trim(o_text)) +
              ''')'               :
              yMsgID              :
              yMsgDta             );

    if (yMsgID <> '');
      p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
      yMsgID = '';
      yMsgDta = '';
      exsr clrFileP;
      leavesr;
    endif;
  endif;

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
        update pbSfl;
        iter;
      endif;

      *in85 = '0'; // DSPATR(RI)

      //  Zuordnung AUSWAHL => Befehl ...
      //  (Ein Fehler bleibt bestehen, auch wenn eine spätere Zeile
      //  gültig ist.)
      if (f_isVldOpt(sfpau: yMsgID: yMsgDta) = bTrue);
        isSflError = bTrue;
        p_sndPgmMg(yMsgID: yMsgDta: sds.pgmName);
        yMsgID = '';
        yMsgDta = '';
        exsr vSfpauErr;
        update pbSfl;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      sfl_cmd = yPgmCmd;

      select;
      when (sfl_cmd = '*NONE');
      when (sfl_cmd = '*SLCENV');
        exsr vPos;
      when (sfl_cmd = '*SLCLAYOUT');
        exsr vPos;
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
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  // - Kontrollsatz füllen
  exsr ctFill;

  // - Subfile neu aufbauen
  exsr pbInitKey;
  exsr pbInit;
  exsr pbSetLL;
  exsr pbReadUp;

  exsr srchInit;

  exsr posCsr;

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

  if (i_mode = '*LOAD' and sfl_cmd = '*SLCLAYOUT');
    rcdFmtID = f_loadRcdFmtID();
    if (rcdFmtID <> '' and i_rcdFmtID <> rcdFmtID);
      isSflError = bTrue;
      clear usr8233;
      p_sndPgmMg('USR8233': usr8233: sds.pgmName);
      exsr vSfpauErr;
      leavesr;
    endif;
  endif;

  o_qFile.name = ##file;
  o_qFile.lib = ##lib;
  o_mbr = $$mNme;
  o_text = $$mTxt;
  o_option = sfl_cmd;

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
//    clrIndCtl     Löschen Bezugszahlen Kontrollsatz         *
//============================================================*

begsr clrIndCtl;

  *in20 = '0'; // ##CTLAU.PC
  *in30 = '0'; // ##CTLAU.RI

  *in21 = '0'; // ##MNME.PC
  *in31 = '0'; // ##MNME.RI

  *in22 = '0'; // ##MTXT.PC
  *in32 = '0'; // ##MTXT.RI

  *in40 = '0'; // ##FILE.PC
  *in50 = '0'; // ##FILE.RI

  *in41 = '0'; // ##LIB.PC
  *in51 = '0'; // ##LIB.RI

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

  if (##file <> ' ' and ##lib  <> ' ');

    lastFile = ##file;
    lastLib  = ##lib;

    yFile = ##file;
    yLib = ##lib;
    peek46(yQFile: '*ALL':  '*CREATE': numMbr: mbrl0200);

    set0015.set_envFil = ##file;
    set0015.set_envLib = ##lib;

  else;
    clear usr8181;
    p_sndPgmMg('USR8181': usr8181: sds.pgmName);
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

  dow (numMbr > 0);
    peek46(yQFile: '*ALL':  '*READ'
          : numMbr: mbrl0200);

    exsr pbFill;

    sflRec = sflRec + 1;
    write pbSfl;
    sflNbrRcd = sflRec;
    sfl_mbrs(sflRec) = $$mNme;

    if (sflRec >= sflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    pbFill        Füllen Subfilesatz                        *
//============================================================*

begsr pbFill;

  //  ... Membername
  $$mNme = mbrl0200.m2MNme;
  //  ... Memberbezeichnung
  $$mTxt = mbrl0200.m2MTxt;

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
//    ctFill        Füllen Kontrollsatz                       *
//============================================================*

begsr ctFill;

  ##ctlau = '';
  ##mnme  = '';
  ##mtxt  = '';

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
    pos = 5;
  endif;

  sflPage = 9999;
  sflPageDDS = 6;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  //  *ENVFILE
  set0015 = f_getUsrSg('*ENVFILE'  );

endsr;

//============================================================*
//    setUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr setUsrSetg;

  //  *ENVFILE
  if (isPrdLib = bTrue);
    set0015.set_envLib = '*PRDLIB';
  endif;
  p_updUsrSg('*ENVFILE': set0015);

endsr;

//============================================================*
//    clrFileP      Löschen Dateiangaben (Rückkehrwerte)      *
//============================================================*

begsr clrFileP;

  o_qFile.name = '';
  o_qFile.lib = '';
  o_mbr = '';
  o_text = '';
  o_option = '';

endsr;

//============================================================*
//    posCrs        Positionieren Cursor                      *
//============================================================*

begsr posCsr;

  if (*in72 = '0'); // Eingeblendet
    *in20 = *on;
  else;
    *in20 = *off;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Einlesen Subfileauswahlen
  select;
  when (i_mode = '*SAVE');
    yExclKeys(1) = '*SLCLAYOUT';
  when (i_mode = '*DELETE');
    yExclKeys(1) = '*SLCLAYOUT';
  other;
    //           keine Ausschlüsse
    yExclKeys(*) = '';
  endsl;

  peek27(sds.pgmName: yChoice: yNbrOfCh: yExclKeys: %len($$choice));

  // - Öffnen Bildschirmdatei
  if (workstn.isOpen = '0');
    open peek56fm;
  endif;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  exsr getUsrSetg;

  select;
  when (i_envFile = '*NONE');
    ##file = ' ';
  other;
    ##file = i_envFile;
  endsl;

  select;
  when (i_envLib = '*NONE');
    ##lib = '';
    isPrdLib = bFalse;
  when (i_envLib = '*PRDLIB');
    ##lib = sds.pgmLib;
    isPrdLib = bTrue;
  other;
    ##lib = i_envLib;
    isPrdLib = bFalse;
  endsl;

  if (set0015.set_envChg =  bFalse or set0015.set_envena =  bFalse );
    *in71 = *on;
  else;
    *in71 = *off;
  endif;

  if (i_mode = '*SAVE');
    *in72 = '0'; // Einblenden
  else;
    *in72 = '1'; // Ausblenden
  endif;

  // - Rückkehrcode
  o_msgID = *blanks;
  o_msgDta = *blanks;
  exsr clrFileP;

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
  peek46_name = f_pgmCallN('PEEK46');

  peek23(sds.pgmName: '*ALL': NbrFKeys: yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

endsr;

//===================================================================*
//  Prozedur:  f_isVldOpt                                 (Body)     *
//===================================================================*

dcl-proc f_isVldOpt;
  dcl-pi *n like(bool_t);
    i_option like(sfpau);
    o_msgID  like(msgId_t);
    o_msgDta like(msgDta_t);
  end-pi;

  //  Funktionswert ...
  dcl-s isError like(bool_t) inz(bFalse);
  //---------------------------------------------------*

  peek21('#' + i_option: sds.pgmName
        : yPgmCmd: yCmdDta: yMsgID: yMsgDta);
  if (yMsgID <> ' ');
    //  Fehlermeldung ...
    clear usr8110;
    usr8110.var1 = i_option;
    o_msgID  = 'USR8110';
    o_msgDta = usr8110;
    isError  = bTrue;
  else;
    o_msgID  = ' ';
    o_msgDta = ' ';
    isError  = bFalse;
  endif;

  return isError;

end-proc;

//===================================================================*
//  Prozedur:  f_loadRcdFmtID                             (Body)     *
//===================================================================*
dcl-proc f_loadRcdFmtID;
  dcl-pi *n like(fmtId_t);
  end-pi;

  //  definieren Arbeitsfelder ...
  dcl-s rcdFmtID like(fmtId_t);

  dcl-ds en_key2 likerec(fpeekenv: *key);
  //---------------------------------------------------*

  //  Die Umgebungsdatei aus dem Fenster: Der Benutzer kann Datei und
  //  Bibliothek ändern, i_envLib kann auch '*PRDLIB' sein.
  g_envFile = %trim(##lib) + '/' +
              %trim(##file);
  g_envMbr = $$mNme;
  open(e) peekEnv;
  if (%error());
    return '';
  endif;

  rcdFmtID = '';
  clear en_key2;
  en_key2.en_user = '*ALL';
  en_key2.en_section = '*RCDFMTID';
  chain %kds(en_key2: 2) fpeekenv;
  if (%found(peekEnv));
    rcdFmtID = en_data;
  endif;

  close peekEnv;

  return rcdFmtID;
end-proc;

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

