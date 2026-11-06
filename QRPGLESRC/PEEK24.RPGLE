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

dcl-s ymsgid char(7) inz(*blanks);
dcl-s ymsgdta char(512) inz(*blanks);

dcl-s yfkeys char(18) dim(32) inz(*blanks);
dcl-s ynbrofkeys like(int4_t) inz;

dcl-s ypgmcmd char(10) inz(*blanks);
dcl-s ycmddta like(pgmcmddt_t) inz(*blanks);

dcl-s sfbot like(int4_t) inz;
dcl-c NBR_F_KEYS 2;

dcl-s wrk_field char(10) inz(*blanks);
dcl-s wrk_color char(1) inz(*blanks);

//  Farbe in SET0001, die mit PEEK25 geändert wird (aus PRF20)
dcl-s pSetColor pointer inz(*null);
dcl-s setColor char(1) based(pSetColor);

dcl-ds set0001 likeds(set0001_t) inz;

dcl-s peek21_name like(pgmcalln_t) inz;
dcl-s peek23_name like(pgmcalln_t) inz;
dcl-s peek25_name like(pgmcalln_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek24;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  o_set0001   likeds(set0001_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
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
  write msgctl;

  //  Anzeigen der Befehlstasten
  select;
  when (sfbot = 2) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (ynbrofkeys > NBR_F_KEYS * (sfbot - 1));
    write pbbot#6;
  other;
    write pbbot#1;
    sfbot = 1;
  endsl;

  //  Anzeigen Bildschirm
  exfmt bild01;

  //  Berechnen Zeile/Spalte
  cursorposition.row = workstn.csrpos / 256;
  cursorposition.column = %rem(workstn.csrpos: 256);

  //  Beibehalten der Cursorosition
  csrrow = cursorposition.row - zei;
  csrcol = cursorposition.column - pos;
  csrcol = csrcol - 1;

  //  Nachrichten löschen
  p_rmvpgmmg(sds.pgmname);

  //  Bezugszahlen löschen
  exsr bzoff1;

  //  Mappen der gedrückten Taste
  //  in Programmbefehl
  peek21(workstn.aid: sds.pgmname
        : ypgmcmd: ycmddta: ymsgid: ymsgdta);
  if (ymsgid <> *blanks);
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  when (ypgmcmd = '*SAVE_EXIT');
    exsr c_exit;
    leave;
  when (ypgmcmd = '*EXIT');
    exsr c_endpgm;
    leave;
  when (ypgmcmd = '*REFRESH');
    exsr c_refresh;
    iter;
  when (ypgmcmd = '*CANCEL');
    exsr c_endpgm;
    leave;
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;
  when (ypgmcmd = '*ENTER');
    exsr c_enter;
  other;
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

// - Dateien schließen
close peek24fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfb1;
  if (*in99 = *off);
    exsr getcolor;
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

    wrk_field = %subst(scnfld:3:6);

    select;
    when (wrk_field = 'KEYCOL'); // Schlüsselfelder
      pSetColor = %addr(set0001.set_keycol);
    when (wrk_field = 'HEDCOL'); // Überschrift
      pSetColor = %addr(set0001.set_hedcol);
    when (wrk_field = 'PINCOL'); // Pined-Daten
      pSetColor = %addr(set0001.set_pincol);
    when (wrk_field = 'CLMCOL'); // SpaltenMark
      pSetColor = %addr(set0001.set_clmcol);
    when (wrk_field = 'STDCOL'); // Standard
      pSetColor = %addr(set0001.set_stdcol);
    when (wrk_field = 'NMLCOL'); // Normale Suche
      pSetColor = %addr(set0001.set_nmlcol);
    when (wrk_field = 'UNDCOL'); // Unterstrichen
      pSetColor = %addr(set0001.set_undcol);
    when (wrk_field = 'REVCOL'); // Reverse Suche
      pSetColor = %addr(set0001.set_revcol);
    when (wrk_field = 'TBLCOL'); // Tabellierpap.
      pSetColor = %addr(set0001.set_tblcol);
    when (wrk_field = 'EXCCOL'); // Exception
      pSetColor = %addr(set0001.set_exccol);
    other;
      pSetColor = *null;
      *in99 = '1';
      p_sndpgmmg('USR8146': '': sds.pgmname);
      leave;
    endsl;

    wrk_color = setColor;

  enddo;

  if (*in99 = *on);
  //               ??????????
  endif;

endsr;

//============================================================*
//    C_Exit        F3     - Speichern und beenden            *
//============================================================*

begsr c_exit;

  exsr setusrsetg;

  o_msgid = 'USR8112';
  o_msgdta = *blanks;

endsr;

//============================================================*
//    C_EndPgm      F12    - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8100';

  select;
  when (workstn.aid = k_f3);
    usr8100.var1 = 'F3';
  when (workstn.aid = k_f12);
    usr8100.var1 = 'F12';
  other;
    usr8100.var1 = 'Fxx';
  endsl;

  o_msgdta = usr8100;

endsr;

//============================================================*
//    C_Refresh     F5  - Änderungen verwerfen                *
//============================================================*

begsr c_refresh;

  //  Nicht gespeicherte Änderungen zurücknehmen
  exsr getusrsetg;
  exsr fill##;

endsr;

//============================================================*
//    C_MoreKeys    F24 - Weitere Tasten                      *
//============================================================*

begsr c_morekeys;

  sfbot = sfbot + 1;

endsr;

//============================================================*
//    FILL##        Füllen Bildschirm                         *
//============================================================*

begsr fill##;

  //  SET_KeyCol
  $$keycol = set0001.set_keycol;
  //*                 CAT       'KeyField':0  $$KEYCOL
  $$keycol = %trimr($$keycol) + 'KeyField';

  //  SET_HedCol
  $$hedcol = set0001.set_hedcol;
  //*                 CAT       'Headline':0  $$HEDCOL
  $$hedcol = %trimr($$hedcol) + 'Headline';

  //  SET_PinCol
  $$pincol1 = set0001.set_pincol;
  $$pincol2 = $$pincol1;
  //*                 CAT       'Pin-Record':0$$PINCOL1
  $$pincol1 = %trimr($$pincol1) + 'Pin-Record';

  //*   ' ':'x'       XLATE     $$PINCOL2     $$PINCOL2
  $$pincol2 = %xlate(' ': 'x': $$pincol2);
  $$pincol3 = $$pincol2;
  $$pincol4 = $$pincol2;

  //  SET_StdCol
  $$stdcol1 = set0001.set_stdcol;
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
  $$clmcol1 = set0001.set_clmcol;
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
  $$nmlcol1 = set0001.set_nmlcol;
  $$nmlcol2 = $$nmlcol1;
  //*                 CAT       'Search':0    $$NmlCOL1
  $$nmlcol1 = %trimr($$nmlcol1) + 'Search';

  //*   ' ':'x'       XLATE     $$NmlCOL2     $$NmlCOL2
  $$nmlcol2 = %xlate(' ': 'x': $$nmlcol2);
  $$nmlcol3 = $$nmlcol2;
  $$nmlcol4 = $$nmlcol2;

  //  SET_UndCol
  $$undcol1 = set0001.set_undcol;
  $$undcol2 = $$undcol1;
  //*                 CAT       'Search-Und':0$$UNDCOL1
  $$undcol1 = %trimr($$undcol1) + 'Search-Und';

  //*   ' ':'x'       XLATE     $$UNDCOL2     $$UNDCOL2
  $$undcol2 = %xlate(' ': 'x': $$undcol2);
  $$undcol3 = $$undcol2;
  $$undcol4 = $$undcol2;

  //  SET_RevCol
  $$revcol1 = set0001.set_revcol;
  $$revcol2 = $$revcol1;
  //*                 CAT       'Search-Rev':0$$REVCOL1
  $$revcol1 = %trimr($$revcol1) + 'Search-Rev';

  //*   ' ':'x'       XLATE     $$REVCOL2     $$REVCOL2
  $$revcol2 = %xlate(' ': 'x': $$revcol2);
  $$revcol3 = $$revcol2;
  $$revcol4 = $$revcol2;

  //  SET_TblCol
  $$tblcol1 = set0001.set_tblcol;
  $$tblcol2 = $$tblcol1;
  //*                 CAT       'Tabulated':0 $$TBLCOL1
  $$tblcol1 = %trimr($$tblcol1) + 'Tabulated';

  //*   ' ':'x'       XLATE     $$TBLCOL2     $$TBLCOL2
  $$tblcol2 = %xlate(' ': 'x': $$tblcol2);
  $$tblcol3 = $$tblcol2;
  $$tblcol4 = $$tblcol2;

  //  SET_ExcCol
  $$exccol1 = set0001.set_exccol;
  $$exccol2 = $$exccol1;
  //*                 CAT       'Exception':0 $$EXCCOL1
  $$exccol1 = %trimr($$exccol1) + 'Exception';

  //*   ' ':'x'       XLATE     $$EXCCOL2     $$EXCCOL2
  $$exccol2 = %xlate(' ': 'x': $$exccol2);

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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

begsr getusrsetg;

  set0001 = o_set0001;

endsr;

//============================================================*
//    SetUsrSetg    Speichern der Benutzervoreinstellungen    *
//============================================================*

begsr setusrsetg;

  o_set0001 = set0001;

endsr;

//============================================================*
//    GetColor      Auswählen neue Farbe                      *
//============================================================*

begsr getcolor;

  monitor;
    peek25(i_dsp80: wrk_color: ymsgid: ymsgdta);
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
  p_rmvpgmmg(sds.pgmname);

  // - Benutzervoreinstellungen
  exsr getusrsetg;

  // - Bildschirmfelder füllen
  exsr fill##;

  o_msgid = *blanks;
  o_msgdta = *blanks;

  //  Löschen der Cursorosition
  csrrow = *zeros;
  csrcol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

  // - Copyright
  p_sndpgmmg('USR9999': i_copyright: sds.pgmname);

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

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');
  peek25_name = f_pgmcalln('PEEK25');

  //  0 statt NBR_F_KEYS: Keinen Platz für "F24=Weitere Tasten"
  //  reservieren, damit F3 und F5 nebeneinander in die Tastenleiste
  //  passen. Die übrigen Tasten (z.B. F12) erscheinen nach F24.
  peek23(sds.pgmname: '*ALL': 0
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

