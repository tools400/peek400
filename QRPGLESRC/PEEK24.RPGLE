**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek24fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,D_COLORATR
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,SET0001

/define internal_prototype
/copy QCOPYLE,PPEEK24
/undefine internal_prototype

/copy QCOPYLE,USR8100

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23
/copy QCOPYLE,PPEEK25

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s YMsgID char(7) inz(*blanks);
dcl-s YMsgDta char(512) inz(*blanks);

dcl-s yFKeys char(18) dim(32) inz(*blanks);
dcl-s yNbrOfKeys like(int4_t) inz;

dcl-s YPgmCmd char(10) inz(*blanks);
dcl-s YCmdDta like(pgmCmdDt_t) inz(*blanks);

dcl-s sfbot like(int4_t) inz;
dcl-c NBR_F_KEYS 2;

dcl-s Wrk_Field char(10) inz(*blanks);
dcl-s Wrk_Color char(1) inz(*blanks);

//  Farbe in SET0001, die mit PEEK25 geändert wird (aus PRF20)
dcl-s pSetColor pointer inz(*null);
dcl-s setColor char(1) based(pSetColor);

dcl-ds set0001 likeds(SET0001_t) inz;

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
  o_set0001   likeds(SET0001_t);
  o_msgID     like(msgId_t);
  o_msgDta    like(msgDta_t);
end-pi;
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

exsr First;

//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when ((sfbot = 2) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (yNbrOfKeys > NBR_F_KEYS * (sfbot - 1)));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorPosition.row = workstn.csrPos / 256;
  cursorPosition.column = %rem(workstn.csrPos: 256);

  //  Beibehalten der Cursorosition
  CsrRow = cursorPosition.row - zei;
  CsrCol = cursorPosition.column - pos;
  CsrCol = CsrCol - 1;

  //  Nachrichten löschen
  p_rmvPgmMg(sds.pgmName);

  //  Bezugszahlen löschen
  exsr bzoff1;

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
  when (YPgmCmd = '*SAVE_EXIT');
    exsr C_Exit;
    leave;
  when (YPgmCmd = '*EXIT');
    exsr C_EndPgm;
    leave;
  when (YPgmCmd = '*REFRESH');
    exsr C_Refresh;
    iter;
  when (YPgmCmd = '*CANCEL');
    exsr C_EndPgm;
    leave;
  when (YPgmCmd = '*MOREKEYS');
    exsr C_MoreKeys;
  when (YPgmCmd = '*ENTER');
    exsr C_Enter;
  other;
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

// - Dateien schließen
close peek24fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr C_Enter;

  exsr prfb1;
  if (*in99 = *off);
    exsr GetColor;
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

begsr prfb1;

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

    Wrk_Field = %subst(ScnFld:3:6);

    select;
    when (Wrk_Field = 'KEYCOL'); // Schlüsselfelder
      pSetColor = %addr(set0001.SET_KeyCol);
    when (Wrk_Field = 'HEDCOL'); // Überschrift
      pSetColor = %addr(set0001.SET_HedCol);
    when (Wrk_Field = 'PINCOL'); // Pined-Daten
      pSetColor = %addr(set0001.SET_PinCol);
    when (Wrk_Field = 'CLMCOL'); // SpaltenMark
      pSetColor = %addr(set0001.SET_ClmCol);
    when (Wrk_Field = 'STDCOL'); // Standard
      pSetColor = %addr(set0001.SET_StdCol);
    when (Wrk_Field = 'NMLCOL'); // Normale Suche
      pSetColor = %addr(set0001.SET_NmlCol);
    when (Wrk_Field = 'UNDCOL'); // Unterstrichen
      pSetColor = %addr(set0001.SET_UndCol);
    when (Wrk_Field = 'REVCOL'); // Reverse Suche
      pSetColor = %addr(set0001.SET_RevCol);
    when (Wrk_Field = 'TBLCOL'); // Tabellierpap.
      pSetColor = %addr(set0001.SET_TblCol);
    when (Wrk_Field = 'EXCCOL'); // Exception
      pSetColor = %addr(set0001.SET_ExcCol);
    other;
      pSetColor = *null;
      *in99 = '1';
      p_sndPgmMg('USR8146': '': sds.pgmName);
      leave;
    endsl;

    Wrk_Color = setColor;

  enddo;

  if (*in99 = *on);
  //               ??????????
  endif;

endsr;

//============================================================*
//    C_Exit        F3     - Speichern und beenden            *
//============================================================*

begsr C_Exit;

  exsr SetUsrSetg;

  o_msgID = 'USR8112';
  o_msgDta = *blanks;

endsr;

//============================================================*
//    C_EndPgm      F12    - Programm beenden                 *
//============================================================*

begsr C_EndPgm;

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
//    C_Refresh     F5  - Änderungen verwerfen                *
//============================================================*

begsr C_Refresh;

  //  Nicht gespeicherte Änderungen zurücknehmen
  exsr GetUsrSetg;
  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr C_MoreKeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  SET_KeyCol
  $$keycol = set0001.SET_KeyCol;
  //*                 CAT       'KeyField':0  $$KEYCOL
  $$keycol = %trimr($$keycol) + 'KeyField';

  //  SET_HedCol
  $$hedcol = set0001.SET_HedCol;
  //*                 CAT       'Headline':0  $$HEDCOL
  $$hedcol = %trimr($$hedcol) + 'Headline';

  //  SET_PinCol
  $$pincol1 = set0001.SET_PinCol;
  $$pincol2 = $$pincol1;
  //*                 CAT       'Pin-Record':0$$PINCOL1
  $$pincol1 = %trimr($$pincol1) + 'Pin-Record';

  //*   ' ':'x'       XLATE     $$PINCOL2     $$PINCOL2
  $$pincol2 = %xlate(' ': 'x': $$pincol2);
  $$pincol3 = $$pincol2;
  $$pincol4 = $$pincol2;

  //  SET_StdCol
  $$stdcol1 = set0001.SET_StdCol;
  $$stdcol2 = $$stdcol1;
  //*                 CAT       'Std.Color':0 $$STDCOL1
  $$stdcol1 = %trimr($$stdcol1) + 'Std.Color';

  //*   ' ':'x'       XLATE     $$STDCOL2     $$STDCOL2
  $$stdcol2 = %xlate(' ': 'x': $$stdcol2);
  $$stdcol3 = $$stdcol2;
  $$stdcol4 = $$stdcol2;
  $$stdcol5 = $$stdcol2;
  $$stdcol6 = $$stdcol2;

  //  SET_ClmCol
  $$clmcol1 = set0001.SET_ClmCol;
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

  //  SET_NmlCol
  $$NmlCOL1 = set0001.SET_NmlCol;
  $$NmlCOL2 = $$NmlCOL1;
  //*                 CAT       'Search':0    $$NmlCOL1
  $$NmlCOL1 = %trimr($$NmlCOL1) + 'Search';

  //*   ' ':'x'       XLATE     $$NmlCOL2     $$NmlCOL2
  $$NmlCOL2 = %xlate(' ': 'x': $$NmlCOL2);
  $$nmlcol3 = $$NmlCOL2;
  $$NmlCOL4 = $$NmlCOL2;

  //  SET_UndCol
  $$undcol1 = set0001.SET_UndCol;
  $$undcol2 = $$undcol1;
  //*                 CAT       'Search-Und':0$$UNDCOL1
  $$undcol1 = %trimr($$undcol1) + 'Search-Und';

  //*   ' ':'x'       XLATE     $$UNDCOL2     $$UNDCOL2
  $$undcol2 = %xlate(' ': 'x': $$undcol2);
  $$undcol3 = $$undcol2;
  $$undcol4 = $$undcol2;

  //  SET_RevCol
  $$revcol1 = set0001.SET_RevCol;
  $$revcol2 = $$revcol1;
  //*                 CAT       'Search-Rev':0$$REVCOL1
  $$revcol1 = %trimr($$revcol1) + 'Search-Rev';

  //*   ' ':'x'       XLATE     $$REVCOL2     $$REVCOL2
  $$revcol2 = %xlate(' ': 'x': $$revcol2);
  $$revcol3 = $$revcol2;
  $$revcol4 = $$revcol2;

  //  SET_TblCol
  $$tblcol1 = set0001.SET_TblCol;
  $$tblcol2 = $$tblcol1;
  //*                 CAT       'Tabulated':0 $$TBLCOL1
  $$tblcol1 = %trimr($$tblcol1) + 'Tabulated';

  //*   ' ':'x'       XLATE     $$TBLCOL2     $$TBLCOL2
  $$tblcol2 = %xlate(' ': 'x': $$tblcol2);
  $$tblcol3 = $$tblcol2;
  $$tblcol4 = $$tblcol2;

  //  SET_ExcCol
  $$exccol1 = set0001.SET_ExcCol;
  $$exccol2 = $$exccol1;
  //*                 CAT       'Exception':0 $$EXCCOL1
  $$exccol1 = %trimr($$exccol1) + 'Exception';

  //*   ' ':'x'       XLATE     $$EXCCOL2     $$EXCCOL2
  $$exccol2 = %xlate(' ': 'x': $$exccol2);

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr SetScreen;

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
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr GetUsrSetg;

  set0001 = o_set0001;

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr SetUsrSetg;

  o_set0001 = set0001;

endsr;

//============================================================*
//    GetColor      Auswählen neue Farbe                      *
//============================================================*

begsr GetColor;

  monitor;
    peek25(i_dsp80: Wrk_Color: YMsgID: YMsgDta);
    *in99 = bFalse;
  on-error;
    *in99 = bTrue;
  endmon;

  if (*in99 = *on);
  // Fehler aufgetreten
  else;

    //  Neue Farbe in das Feld von SET0001 übernehmen
    setColor = Wrk_Color;

    exsr fill##;
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr First;

  // - Dateien öffnen
  open peek24fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Benutzervoreinstellungen
  exsr GetUsrSetg;

  // - Bildschirmfelder füllen
  exsr fill##;

  o_msgID = *blanks;
  o_msgDta = *blanks;

  //  Löschen der Cursorosition
  CsrRow = *zeros;
  CsrCol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr SetScreen;

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
  peek25_name = f_pgmCallN('PEEK25');

  //  0 statt NBR_F_KEYS: Keinen Platz für "F24=Weitere Tasten"
  //  reservieren, damit F3 und F5 nebeneinander in die Tastenleiste
  //  passen. Die übrigen Tasten (z.B. F12) erscheinen nach F24.
  peek23(sds.pgmName: '*ALL': 0
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

