**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Änderung der Farbeinstellung                 *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK24                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 31.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Änderung der Farbeinstellung                                 *
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

dcl-f peek24fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/copy 'qcopyle/d_vardef.rpgleinc'
/copy 'qcopyle/fldl0100.rpgleinc'
/copy 'qcopyle/d_workstn.rpgleinc'
/copy 'qcopyle/d_coloratr.rpgleinc'
/copy 'qcopyle/shortcmd_d.rpgleinc'
/copy 'qcopyle/sds.rpgleinc'
/copy 'qcopyle/scrnfkeys.rpgleinc'
/copy 'qcopyle/ceecndhdlr.rpgleinc'

/copy 'qcopyle/set0001.rpgleinc'

/define internal_prototype
/copy 'qcopyle/ppeek24.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/usr8100.rpgleinc'

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'
/copy 'qcopyle/ppeek25.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s yMsgID char(7) inz(*blanks);
dcl-s yMsgDta char(512) inz(*blanks);

dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;

dcl-s yPgmCmd char(10) inz(*blanks);
dcl-s yCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-s sfBot like(int4_t) inz;
dcl-c NBR_F_KEYS 2;

dcl-s wrk_field char(10) inz(*blanks);
dcl-s wrk_color char(1) inz(*blanks);

//  Farbe in SET0001, die mit PEEK25 geändert wird (aus PRF20)
dcl-s pSetColor pointer inz(*null);
dcl-s setColor char(1) based(pSetColor);

dcl-ds set0001 likeds(set0001_t) inz;

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;
dcl-s peek25_name like(pgmCallN_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek24;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyright_t) const;
  o_set0001   likeds(set0001_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr first;

//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgCtl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfBot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#2;
  when ((sfBot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#3;
  when ((sfBot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#4;
  when ((sfBot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#5;
  when ((sfBot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfBot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfBot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Beibehalten der Cursorosition
  csrRow = cursorPosition.row - zei;
  csrCol = cursorPosition.column - pos;
  csrCol = csrCol - 1;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

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
  when (yPgmCmd = '*SAVE_EXIT');
    exsr c_exit;
    leave;
  when (yPgmCmd = '*EXIT');
    exsr c_endPgm;
    leave;
  when (yPgmCmd = '*REFRESH');
    exsr c_refresh;
    iter;
  when (yPgmCmd = '*CANCEL');
    exsr c_endPgm;
    leave;
  when (yPgmCmd = '*MOREKEYS');
    exsr c_moreKeys;
  when (yPgmCmd = '*ENTER');
    exsr c_enter;
  other;
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

// - Dateien schließen
close peek24fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfB1;
  if (*in99 = *off);
    exsr getColor;
  else;
  //          Fehlernachricht ausgeben
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfB1;

  dou ('1');

    exsr prf20;
    if (*in99 = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PRF20         Prüfen:  Feldauswahl                      *
//============================================================*

begsr prf20;

  dou ('1');

    wrk_field = %subst(scnFld:3:6);

    select;
    when (wrk_field = 'KEYCOL'); // Schlüsselfelder
      pSetColor = %addr(set0001.set_keyCol);
    when (wrk_field = 'HEDCOL'); // Überschrift
      pSetColor = %addr(set0001.set_hedCol);
    when (wrk_field = 'PINCOL'); // Pined-Daten
      pSetColor = %addr(set0001.set_pinCol);
    when (wrk_field = 'CLMCOL'); // SpaltenMark
      pSetColor = %addr(set0001.set_clmCol);
    when (wrk_field = 'STDCOL'); // Standard
      pSetColor = %addr(set0001.set_stdCol);
    when (wrk_field = 'NMLCOL'); // Normale Suche
      pSetColor = %addr(set0001.set_nmlCol);
    when (wrk_field = 'UNDCOL'); // Unterstrichen
      pSetColor = %addr(set0001.set_undCol);
    when (wrk_field = 'REVCOL'); // Reverse Suche
      pSetColor = %addr(set0001.set_revCol);
    when (wrk_field = 'TBLCOL'); // Tabellierpap.
      pSetColor = %addr(set0001.set_tblCol);
    when (wrk_field = 'EXCCOL'); // Exception
      pSetColor = %addr(set0001.set_excCol);
    other;
      pSetColor = *null;
      *in99 = '1';
      p_sndPgmMg('USR8146': '': sds.pgmName);
      leave;
    endsl;

    wrk_color = setColor;

  enddo;

  if (*in99 = *on);
  //               ??????????
  endif;

endsr;

//============================================================*
//    c_exit        F3     - Speichern und beenden            *
//============================================================*

begsr c_exit;

  exsr setUsrSetg;

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    c_endPgm      F12    - Programm beenden                 *
//============================================================*

begsr c_endPgm;

  p_rmvPgmMg(sds.pgmName);

  o_msgID = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgDta = usr8100;

endsr;

//============================================================*
//    c_refresh     F5  - Änderungen verwerfen                *
//============================================================*

begsr c_refresh;

  //  Nicht gespeicherte Änderungen zurücknehmen
  exsr getUsrSetg;
  exsr fill##;

endsr;

//============================================================*
//    c_moreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_moreKeys;

  sfBot = sfBot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  set_keyCol
  $$keyCol = set0001.set_keyCol;
  //*                 CAT       'KeyField':0  $$KEYCOL
  $$keyCol = %trimr($$keyCol) + 'KeyField';

  //  set_hedCol
  $$hedCol = set0001.set_hedCol;
  //*                 CAT       'Headline':0  $$HEDCOL
  $$hedCol = %trimr($$hedCol) + 'Headline';

  //  set_pinCol
  $$pincol1 = set0001.set_pinCol;
  $$pincol2 = $$pincol1;
  //*                 CAT       'Pin-Record':0$$PINCOL1
  $$pincol1 = %trimr($$pincol1) + 'Pin-Record';

  //*   ' ':'x'       XLATE     $$PINCOL2     $$PINCOL2
  $$pincol2 = %xlate(' ': 'x': $$pincol2);
  $$pincol3 = $$pincol2;
  $$pincol4 = $$pincol2;

  //  set_stdCol
  $$stdcol1 = set0001.set_stdCol;
  $$stdcol2 = $$stdcol1;
  //*                 CAT       'Std.Color':0 $$STDCOL1
  $$stdcol1 = %trimr($$stdcol1) + 'Std.Color';

  //*   ' ':'x'       XLATE     $$STDCOL2     $$STDCOL2
  $$stdcol2 = %xlate(' ': 'x': $$stdcol2);
  $$stdcol3 = $$stdcol2;
  $$stdcol4 = $$stdcol2;
  $$stdcol5 = $$stdcol2;
  $$stdcol6 = $$stdcol2;

  //  set_clmCol
  $$clmcol1 = set0001.set_clmCol;
  $$clmcol2 = $$clmcol1;
  //*                 CAT       'Mark Clm':0  $$CLMCOL1
  $$clmcol1 = %trimr($$clmcol1) + 'Mark Clm';

  //*   ' ':'x'       XLATE     $$CLMCOL2     $$CLMCOL2
  $$clmcol2 = %xlate(' ': 'x': $$clmcol2);
  $$clmcol3 = $$clmcol2;
  $$clmcol4 = $$clmcol2;
  $$clmcol5 = $$clmcol2;
  $$clmcol6 = $$clmcol2;
  $$clmcol7 = $$clmcol2;

  //  set_nmlCol
  $$nmlCOL1 = set0001.set_nmlCol;
  $$nmlCOL2 = $$nmlCOL1;
  //*                 CAT       'Search':0    $$nmlCOL1
  $$nmlCOL1 = %trimr($$nmlCOL1) + 'Search';

  //*   ' ':'x'       XLATE     $$nmlCOL2     $$nmlCOL2
  $$nmlCOL2 = %xlate(' ': 'x': $$nmlCOL2);
  $$nmlcol3 = $$nmlCOL2;
  $$nmlCOL4 = $$nmlCOL2;

  //  set_undCol
  $$undcol1 = set0001.set_undCol;
  $$undcol2 = $$undcol1;
  //*                 CAT       'Search-Und':0$$UNDCOL1
  $$undcol1 = %trimr($$undcol1) + 'Search-Und';

  //*   ' ':'x'       XLATE     $$UNDCOL2     $$UNDCOL2
  $$undcol2 = %xlate(' ': 'x': $$undcol2);
  $$undcol3 = $$undcol2;
  $$undcol4 = $$undcol2;

  //  set_revCol
  $$revcol1 = set0001.set_revCol;
  $$revcol2 = $$revcol1;
  //*                 CAT       'Search-Rev':0$$REVCOL1
  $$revcol1 = %trimr($$revcol1) + 'Search-Rev';

  //*   ' ':'x'       XLATE     $$REVCOL2     $$REVCOL2
  $$revcol2 = %xlate(' ': 'x': $$revcol2);
  $$revcol3 = $$revcol2;
  $$revcol4 = $$revcol2;

  //  set_tblCol
  $$tblcol1 = set0001.set_tblCol;
  $$tblcol2 = $$tblcol1;
  //*                 CAT       'Tabulated':0 $$TBLCOL1
  $$tblcol1 = %trimr($$tblcol1) + 'Tabulated';

  //*   ' ':'x'       XLATE     $$TBLCOL2     $$TBLCOL2
  $$tblcol2 = %xlate(' ': 'x': $$tblcol2);
  $$tblcol3 = $$tblcol2;
  $$tblcol4 = $$tblcol2;

  //  set_excCol
  $$exccol1 = set0001.set_excCol;
  $$exccol2 = $$exccol1;
  //*                 CAT       'Exception':0 $$EXCCOL1
  $$exccol1 = %trimr($$exccol1) + 'Exception';

  //*   ' ':'x'       XLATE     $$EXCCOL2     $$EXCCOL2
  $$exccol2 = %xlate(' ': 'x': $$exccol2);

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 6;
    pos = 26;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 4;
    pos = 7;
  endif;

endsr;

//============================================================*
//    getUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getUsrSetg;

  set0001 = o_set0001;

endsr;

//============================================================*
//    setUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr setUsrSetg;

  o_set0001 = set0001;

endsr;

//============================================================*
//    getColor      Auswählen neue Farbe                      *
//============================================================*

begsr getColor;

  monitor;
    peek25(i_dsp80: wrk_color: yMsgID: yMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
  // Fehler aufgetreten
  else;

    //  Neue Farbe in das Feld von SET0001 übernehmen
    setColor = wrk_color;

    exsr fill##;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Dateien öffnen
  open peek24fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Benutzervoreinstellungen
  exsr getUsrSetg;

  // - Bildschirmfelder füllen
  exsr fill##;

  o_msgID = *blanks;
  o_msgDta = *blanks;

  //  Löschen der Cursorosition
  csrRow = *zeros;
  csrCol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

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

  //  0 statt NBR_F_KEYS: Keinen Platz für "F24=Weitere Tasten"
  //  reservieren, damit F3 und F5 nebeneinander in die Tastenleiste
  //  passen. Die übrigen Tasten (z.B. F12) erscheinen nach F24.
  peek23(sds.pgmName: '*ALL': 0
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

