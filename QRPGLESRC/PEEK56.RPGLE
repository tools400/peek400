**free
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

dcl-f peek56fm workstn(*ext) usage(*input: *output) usropn infds(workstn) sfile(pbsfl: SflRec);

dcl-f peekenv keyed usropn extfile(g_envFile) extmbr(g_envMbr) prefix(en_);

dcl-ds workstn likeds(workstn_t);

dcl-s g_envFile char(21);
dcl-s g_envMbr char(10);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,MBRL0200
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,SET0015

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8110
/copy QCOPYLE,USR8180
/copy QCOPYLE,USR8181
/copy QCOPYLE,USR8182
/copy QCOPYLE,USR8184
/copy QCOPYLE,USR8209
/copy QCOPYLE,USR8233

/define internal_prototype
/copy QCOPYLE,PPEEK56
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK27
/copy QCOPYLE,PPEEK46

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;
dcl-s yExclKeys like(pgmCmd_t) dim(25);
dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

//  Peek46:
dcl-ds YQFile;
  YFile char(10) inz;
  YLib  char(10) inz;
end-ds;
dcl-s numMbr like(int4_t) inz;

dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-s YChoice char(75) dim(32);
dcl-s YNbrOfCh like(int4_t) inz;

dcl-s IsNewPos char(1) inz(bFalse);
dcl-s IsFound char(1) inz(bFalse);
dcl-s IsSflError char(1) inz(bFalse);
dcl-s isCtlError char(1) inz(bFalse);
dcl-s isDirty char(1) inz(bFalse);

dcl-s SFTop like(int4_t) inz;
dcl-s SflPage like(int4_t) inz;
dcl-s SflPageDDS like(SflPage) inz;
dcl-s SflRec like(SflPage) inz;
dcl-s SflNbrRcd like(SflPage) inz;
dcl-s sfbot like(int4_t) inz;
dcl-s Sfl_Cmd char(10) inz(*blanks);
dcl-s ctl_cmd char(10) inz(*blanks);
dcl-c NbrFKeys 3;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek27_name like(pgmCallN_t) inz;
dcl-s peek46_name like(pgmCallN_t) inz;

dcl-s R_Mbr inz(*blanks) like(##Mbr);
dcl-s LstMbr inz(*blanks) like(##Mbr);
dcl-s LstNbrRcd inz(0) like(SflPage);
dcl-s srchrec inz(0) like(SflPage);
//  Namen der Umgebungen (Teildateien) der Subfile-Sätze für die Suche
dcl-s sfl_mbrs like($$mnme) dim(9999);

dcl-s Wrk_SFSANR inz(*zeros) like(sfsanr);

dcl-s lastFile like(##File) inz;
dcl-s LastLib like(##Lib) inz;
dcl-s isPrdLib like(bool_t) inz(bFalse);

dcl-s rcdFmtID like(fmtId_t);
dcl-ds mbrl0200 likeds(MBRL0200_t) inz;

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
  o_Text      like(text_t);
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

exsr First;

dow ('1');

  //  Prüfen Positionierung der Subfile
  if (sfsanr <= 0);
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
  if (SFTop > 32 or SFTop > YNbrOfCh);
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
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeige der Subfile
  exfmt pbctl;
  *in70 = '0';

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr clrIndCtl;

  //  Aktuelle Satz-Nr.
  if (SflCsr > 0);
    sfsanr = SflCsr;
  endif;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> '');
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
    if (isCtlError = bFalse);
      exsr SetUsrSetg;
    endif;
    if (o_mbr = *blanks
        or isCtlError = bTrue
        or IsSflError = bTrue);
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

if (workstn.IsOpen = '1');
  close peek56fm;
endif;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  isCtlError = bFalse;
  isDirty = bFalse;

  //  Prüfen der Eingaben im Kontrollsatz
  exsr VCtl;

  //  Wenn alles OK ist und die Subfile weiterhin gültig ist, ...
  if (isCtlError = bFalse and isDirty = bFalse);
    // ... dann
    //     Wenn der Teildateiname gefüllt ist, ...
    if (##mnme <> '');
      // ... dann
      //     füllen der Rückgabeparameter
      o_qFile.name = ##File;
      o_qFile.lib = ##Lib;
      o_mbr    = ##mnme;
      o_Text   = ##mtxt;
      o_option = ctl_cmd;
    else;
      // ... sonst
      //     prüfen der Subfile
      exsr VReadC;

    endif;
  endif;

  // Wenn die Subfile ungültig ist, ...
  if (isDirty = bTrue);
    // ... dann
    //     aktualisieren der Subfile
    exsr C_Refresh;
  else;
    // ... sonst
    //     Wenn die Teildatei ausgefüllt ist, ...
    if (##Mbr <> '');
      // ... dann
      //     ausführen Suchfunktion
      exsr C_Search;
    else;
      // ... sonst
      //     prüfen der Dateiangaben
      exsr ChkFile;
    endif;
  endif;

endsr;

//============================================================*
//    C_Search      F16 - Suchen                              *
//============================================================*

begsr C_Search;

  if (##Mbr <> '');
    LstMbr = ##Mbr;
    ##Mbr = *blanks;
  endif;

  if (LstMbr = '');
    *in70 = '1';
    clear usr8209;
    p_sndPgmMg('USR8209': usr8209: sds.pgmName);
  else;
    exsr PosToMbr;
    if (IsNewPos = bTrue);
      sfsanr = Wrk_SFSANR;
    endif;
  endif;

endsr;

//============================================================*
//    PosToMbr      Subfile neu positionieren                 *
//============================================================*

begsr PosToMbr;

  if (LstMbr <> R_Mbr);
    LstNbrRcd = 0;
  endif;

  if (LstMbr = '');
    IsNewPos = bFalse;
    LstNbrRcd = 0;
  else;

    exsr SrchMbr;
    if (IsFound = bFalse);
      IsNewPos = bFalse;
      clear usr8180;
      usr8180.var1 = LstMbr;
      p_sndPgmMg('USR8180': usr8180: sds.pgmName);
    else;
      IsNewPos = bTrue;
    endif;
  endif;

  R_Mbr = LstMbr;

endsr;

//============================================================*
//    SrchMbr       Suchen Member in Subfile                  *
//============================================================*

begsr SrchMbr;

  if (*in80 = *off);
    IsFound = bFalse;
  else;

    IsFound = bFalse;
    LstNbrRcd = LstNbrRcd + 1;

    //  Die Suche liest die Subfile nicht, sondern die gemerkten Namen:
    //  Die Sätze bleiben unverändert, auch Auswahlen und deren
    //  Fehlermarkierungen.
    for srchrec = LstNbrRcd to SflNbrRcd;
      if (LstMbr = %subst(sfl_mbrs(srchrec): 1:(f_scan(' ': LstMbr) - 1)));
        IsFound = bTrue;
        leave;
      endif;
    endfor;

    if (IsFound = bTrue);
      Wrk_SFSANR = srchrec;
      LstNbrRcd = srchrec;
    else;
      Wrk_SFSANR = 0;
      LstNbrRcd = 0;
    endif;

  endif;

endsr;

//============================================================*
//    SrchInit      Initialisieren Suchfunktion               *
//============================================================*

begsr SrchInit;

  LstMbr = '';
  LstNbrRcd = 0;
  R_Mbr = LstMbr;

endsr;

//============================================================*
//    VCtl          Verarbeiten der Eingaben Kontrollsatz     *
//============================================================*

begsr VCtl;

  // - Funktion nicht freigeschaltet
  if (##File = '' or ##Lib  = '' or set0015.set_envena = bFalse);
    clear usr8184;
    p_sndPgmMg('USR8184': usr8184: sds.pgmName);
    isCtlError = bTrue;
    exsr posCsr;
    leavesr;
  endif;

  //  ##Lib
  exsr Prf41;
  if (isCtlError = bTrue);
    leavesr;
  endif;

  //  ##File
  exsr Prf40;
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
//    Prf40         Prüfen ##File                             *
//============================================================*

begsr Prf40;

  dou ('1');

    //  gültiger Name ?
    if (f_vldName(##File: YMsgID: YMsgDta) = bTrue);
      isCtlError = bFalse;
    else;
      isCtlError = bTrue;
      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
      leave;
    endif;

    //  Prüfen Datei
    //  ------------
    f_exist(##File: ##Lib: '*FILE': '*NONE': YMsgID: YMsgDta);

    if (YMsgID <> '');
      isCtlError = bTrue;
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      leave;
    else;
      isCtlError = bFalse;
    endif;

    //  Datei geändert ?
    if (##File <> lastFile);
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
//    Prf41         Prüfen ##Lib                              *
//============================================================*

begsr Prf41;

  dou ('1');

    //  gültiger Name ?
    if (f_vldName(##Lib: YMsgID: YMsgDta) = bTrue);
      isCtlError = bFalse;
    else;
      isCtlError = bTrue;
      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
      leave;
    endif;

    //  Prüfen Bibliothek
    //  -----------------
    f_exist(##Lib: *omit: '*LIB': *omit: YMsgID: YMsgDta);
    if (YMsgID <> '');
      isCtlError = bTrue;
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      leave;
    else;
      isCtlError = bFalse;
    endif;

    //  Bibliothek geändert ?
    if (##Lib <> LastLib);
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
     f_isVldOpt(##ctlau: YMsgID: YMsgDta);
    if (isCtlError = bTrue);
      ctl_cmd = ' ';
      if (YMsgID <> '');
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
      endif;
      leave;
    endif;

    ctl_cmd = YPgmCmd;

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
  if (f_vldName(##mnme: YMsgID: YMsgDta) = bTrue);
    isCtlError = bFalse;
  else;
    isCtlError = bTrue;
    if (YMsgID <> '');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
    endif;
  endif;


  if (YMsgID = 'CPD0078');
    p_sndPgmMg('CPD0078': YMsgDta: sds.pgmName);
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
//    ChkFile       Prüfen/Anlegen Env.Datei                  *
//============================================================*

begsr ChkFile;

  if (o_qFile.name = '' and o_qFile.lib  = '' and o_mbr  = '');
    exsr clrFileP;
    leavesr;
  endif;

  //  Prüfen Datei
  //  ------------
  f_exist(o_qFile.name: o_qFile.lib: '*FILE': '*NONE': YMsgID: YMsgDta);

  //  Wenn die Datei nicht gefunden werden konnte, ...
  if (YMsgID = 'CPF9801');
    //  ... dann
    //      anlegen Datei
    f_execute('CRTDUPOBJ'         +
              ' OBJ('             +
               'PEEKENV'          +
              ')'                 +
              ' FROMLIB('         +
              %trim(sds.PgmLib)   +
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
              YMsgID              :
              YMsgDta             );

    if (YMsgID = '');
      f_execute('RMVM'              +
                ' FILE('            +
                %trim(o_qFile.lib ) +
                '/'                 +
                %trim(o_qFile.name) +
                ')'                 +
                ' MBR('             +
                 '*ALL'             +
                ')'                 :
                YMsgID              :
                YMsgDta             );

      YMsgID  = '';
      YMsgDta = '';
    endif;
  endif;

  if (YMsgID <> '');
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    exsr clrFileP;
    leavesr;
  endif;

  //  Prüfen Teildatei
  //  ----------------
  f_exist(o_qFile.name: o_qFile.lib: '*FILE': o_mbr: YMsgID: YMsgDta);

  //  Wenn die Teildatei nicht gefunden werden konnte, ...
  if (YMsgID = 'CPF9815');
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
              YMsgID              :
              YMsgDta             );
  endif;

  if (YMsgID <> '');
    p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
    YMsgID = '';
    YMsgDta = '';
    exsr clrFileP;
    leavesr;
  endif;

  //  Ändern Teildateitext
  //  --------------------
  if (o_Text <> '');
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
              %scanrpl('''': '''''': %trim(o_Text)) +
              ''')'               :
              YMsgID              :
              YMsgDta             );

    if (YMsgID <> '');
      p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
      YMsgID = '';
      YMsgDta = '';
      exsr clrFileP;
      leavesr;
    endif;
  endif;

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

      *in85 = '0'; // DSPATR(RI)

      //  Zuordnung AUSWAHL => Befehl ...
      //  (Ein Fehler bleibt bestehen, auch wenn eine spätere Zeile
      //  gültig ist.)
      if (f_isVldOpt(sfpau: YMsgID: YMsgDta) = bTrue);
        IsSflError = bTrue;
        p_sndPgmMg(YMsgID: YMsgDta: sds.pgmName);
        YMsgID = '';
        YMsgDta = '';
        exsr VSfpauErr;
        update pbsfl;
        iter;
      endif;

      //----------------------------*
      //  Ausführen SFL-Befehl ...  *
      //----------------------------*
      Sfl_Cmd = YPgmCmd;

      select;
      when (Sfl_Cmd = '*NONE');
      when (Sfl_Cmd = '*SLCENV');
        exsr VPos;
      when (Sfl_Cmd = '*SLCLAYOUT');
        exsr VPos;
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
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr C_Refresh;

  // - Kontrollsatz füllen
  exsr ctfill;

  // - Subfile neu aufbauen
  exsr PBInitKey;
  exsr PBInit;
  exsr PBSetLL;
  exsr PBReadUp;

  exsr SrchInit;

  exsr posCsr;

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

  if (i_mode = '*LOAD' and Sfl_Cmd = '*SLCLAYOUT');
    rcdFmtID = f_loadRcdFmtID();
    if (rcdFmtID <> '' and i_rcdFmtID <> rcdFmtID);
      IsSflError = bTrue;
      clear usr8233;
      p_sndPgmMg('USR8233': usr8233: sds.pgmName);
      exsr VSfpauErr;
      leavesr;
    endif;
  endif;

  o_qFile.name = ##File;
  o_qFile.lib = ##Lib;
  o_mbr = $$mnme;
  o_Text = $$MTxt;
  o_option = Sfl_Cmd;

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

  if (##File <> ' ' and ##Lib  <> ' ');

    lastFile = ##File;
    LastLib  = ##Lib;

    YFile = ##File;
    YLib = ##Lib;
    peek46(YQFile: '*ALL':  '*CREATE': numMbr: mbrl0200);

    set0015.set_envfil = ##File;
    set0015.set_envlib = ##Lib;

  else;
    clear usr8181;
    p_sndPgmMg('USR8181': usr8181: sds.pgmName);
  endif;

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

  dow (numMbr > 0);
    peek46(YQFile: '*ALL':  '*READ'
          : numMbr: mbrl0200);

    exsr PBFill;

    SflRec = SflRec + 1;
    write pbsfl;
    SflNbrRcd = SflRec;
    sfl_mbrs(SflRec) = $$mnme;

    if (SflRec >= SflPage);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PBFill        Füllen Subfilesatz                        *
//============================================================*

begsr PBFill;

  //  ... Membername
  $$mnme = mbrl0200.M2MNme;
  //  ... Memberbezeichnung
  $$MTxt = mbrl0200.M2MTxt;

  //  ... anzeigen Subfile
  *in80 = '1'; // SFLDSP

  //  ... Löschen Subfileauswahl
  exsr VSfpauClr;

endsr;

//============================================================*
//    PBSetLL       Setzen Dateizeiger                        *
//============================================================*

begsr PBSetLL;

endsr;

//============================================================*
//    CTFill        Füllen Kontrollsatz                       *
//============================================================*

begsr ctfill;

  ##ctlau = '';
  ##mnme  = '';
  ##mtxt  = '';

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
    pos = 5;
  endif;

  SflPage = 9999;
  SflPageDDS = 6;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  //  *ENVFILE
  set0015 = f_getUsrSg('*ENVFILE'  );

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr SetUsrSetg;

  //  *ENVFILE
  if (isPrdLib = bTrue);
    set0015.set_envlib = '*PRDLIB';
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
  o_Text = '';
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

begsr First;

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

  peek27(sds.pgmName: YChoice: YNbrOfCh: yExclKeys: %len($$choice));

  // - Öffnen Bildschirmdatei
  if (workstn.IsOpen = '0');
    open peek56fm;
  endif;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  exsr GetUsrSetg;

  select;
  when (i_envFile = '*NONE');
    ##File = ' ';
  other;
    ##File = i_envFile;
  endsl;

  select;
  when (i_envLib = '*NONE');
    ##Lib = '';
    isPrdLib = bFalse;
  when (i_envLib = '*PRDLIB');
    ##Lib = sds.PgmLib;
    isPrdLib = bTrue;
  other;
    ##Lib = i_envLib;
    isPrdLib = bFalse;
  endsl;

  if (set0015.set_envchg =  bFalse or set0015.set_envena =  bFalse );
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
  peek46_name = f_pgmCallN('PEEK46');

  peek23(sds.pgmName: '*ALL': NbrFKeys: yFKeys: yNbrOfKeys);
  ScrnFKeys = %subarr(yFKeys: 1);

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
  dcl-s IsError like(bool_t) inz(bFalse);
  //---------------------------------------------------*

  peek21('#' + i_option: sds.pgmName
        : YPgmCmd: YCmdDta: YMsgID: YMsgDta);
  if (YMsgID <> ' ');
    //  Fehlermeldung ...
    clear usr8110;
    usr8110.var1 = i_option;
    o_msgID  = 'USR8110';
    o_msgDta = usr8110;
    IsError  = bTrue;
  else;
    o_msgID  = ' ';
    o_msgDta = ' ';
    IsError  = bFalse;
  endif;

  return IsError;

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
  //  Bibliothek ändern, i_envlib kann auch '*PRDLIB' sein.
  g_envFile = %trim(##Lib) + '/' +
              %trim(##File);
  g_envMbr = $$mnme;
  open(e) peekenv;
  if (%error());
    return '';
  endif;

  rcdFmtID = '';
  clear en_key2;
  en_key2.en_user = '*ALL';
  en_key2.en_section = '*RCDFMTID';
  chain %kds(en_key2: 2) fpeekenv;
  if (%found(peekenv));
    rcdFmtID = en_data;
  endif;

  close peekenv;

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

