**free
      //%METADATA                                                      *
      // %TEXT Peek/400 - Auswahl einer Farbe                          *
      //%EMETADATA                                                     *
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 1.4.0                               *
//  Programm : PEEK25                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 31.10.97  Raddatz                                 *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Auswahl einer Farbe                                          *
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

dcl-f peek25fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

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

/define internal_prototype
/copy 'qcopyle/ppeek25.rpgleinc'
/undefine internal_prototype

/copy 'qcopyle/usr8100.rpgleinc'

/copy 'qcopyle/ppeek21.rpgleinc'
/copy 'qcopyle/ppeek23.rpgleinc'

/copy 'qcopyle/ppeek53.rpgleinc'
/copy 'qcopyle/ppeek58.rpgleinc'

dcl-s yFKeys char(18) dim(32);
dcl-s yNbrOfKeys like(int4_t);
dcl-s yMsgID char(7);
dcl-s yMsgDta char(512);

dcl-s yPgmCmd char(10);
dcl-s yCmdDta like(pgmCmdDt_t);

dcl-s sfBot like(int4_t);
dcl-c NbrFKeys 2;

dcl-c CHAR 'x';

//  Farbtabelle: Bildschirmfeld, Farbattribut, Bezugszahl für
//  DSPATR(PC) und Adresse des Bildschirmfelds
dcl-c MAX_COLORS 28;
dcl-s colorName char(10) dim(MAX_COLORS);
dcl-s colorAttr char(1) dim(MAX_COLORS);
dcl-s colorInd int(5) dim(MAX_COLORS);
dcl-s colorField pointer dim(MAX_COLORS);
dcl-s nbrColors like(int4_t) inz(0);

dcl-s pScnColor pointer inz(*null);
dcl-s scnColor char(3) based(pScnColor);
dcl-s i like(int4_t);

dcl-s peek21_name like(pgmCallN_t) inz;
dcl-s peek23_name like(pgmCallN_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek25;
  i_dsp80     like(dsp80_t) const;
  o_colorAttr like(color_t);
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
    if (*in99 = *off);
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongKey(workstn.aid: sds.pgmName);
    iter;
  endsl;

enddo;

close peek25fm;

return;

//============================================================*
//    c_enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfB1;

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

  exsr extrColor;

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
//    c_refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;
  exsr posCsr;

  //  Cursor auf die aktuelle Farbe (DSPATR(PC)). Mit einer Position
  //  in CSRROW/CSRCOL hätte CSRLOC Vorrang.
  csrRow = 0;
  csrCol = 0;

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

  //  Farbattribut und zwei Zeichen in der Farbe
  for i = 1 to nbrColors;
    pScnColor = colorField(i);
    scnColor = colorAttr(i) + CHAR + CHAR;
  endfor;

endsr;

//============================================================*
//    posCsr        Positionieren Cursor auf aktuelle Farbe   *
//============================================================*

begsr posCsr;

  for i = 1 to nbrColors;
    *in(colorInd(i)) = *off;
  endfor;

  //  Ein unbekanntes Attribut, z.B. aus alten Einstellungen, wird
  //  nicht vorausgewählt.
  i = %lookup(o_colorAttr: colorAttr: 1: nbrColors);
  if (i > 0);
    *in(colorInd(i)) = *on;
  endif;

endsr;

//============================================================*
//    setScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setScreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 8;
    pos = 41;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 6;
    pos = 22;
  endif;

endsr;

//============================================================*
//    extrColor     Extrahieren Farbattribut                  *
//============================================================*

begsr extrColor;

  i = %lookup(scnFld: colorName: 1: nbrColors);
  if (i > 0);
    o_colorAttr = colorAttr(i);
  else;
    //  Cursor steht auf keiner Farbe, z.B. auf der Zeilenbeschriftung
    *in99 = '1';
    p_sndPgmMg('USR8146': '': sds.pgmName);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek25fm;

  // - Programm initialisieren
  p_rmvPgmMg(sds.pgmName);

  // - Bildschirmfelder füllen
  exsr fill##;
  exsr posCsr;

  o_msgID = *blanks;
  o_msgDta = *blanks;

  //  Löschen der Cursorosition
  csrRow = *zeros;
  csrCol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfBot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setScreen;

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

  //  Farbtabelle (Bezugszahlen aus PEEK25FM)
  addColor('$GREEN'    : COLOR_green    : 10: %addr($green));
  addColor('$GREEN_R'  : COLOR_green_r  : 11: %addr($green_r));
  addColor('$GREEN_U'  : COLOR_green_u  : 12: %addr($green_u));
  addColor('$GREEN_RU' : COLOR_green_ru : 13: %addr($green_ru));
  addColor('$WHITE'    : COLOR_white    : 20: %addr($white));
  addColor('$WHITE_R'  : COLOR_White_R  : 21: %addr($white_r));
  addColor('$WHITE_U'  : COLOR_white_u  : 22: %addr($white_u));
  addColor('$RED'      : COLOR_red      : 30: %addr($red));
  addColor('$RED_R'    : COLOR_red_r    : 31: %addr($red_r));
  addColor('$RED_U'    : COLOR_red_u    : 32: %addr($red_u));
  addColor('$RED_RU'   : COLOR_red_ru   : 33: %addr($red_ru));
  addColor('$RED_B'    : COLOR_red_b    : 34: %addr($red_b));
  addColor('$RED_RB'   : COLOR_red_rb   : 35: %addr($red_rb));
  addColor('$RED_UB'   : COLOR_red_ub   : 36: %addr($red_ub));
  addColor('$TURKIS'   : COLOR_turkis   : 40: %addr($turkis));
  addColor('$TURKIS_R' : COLOR_turkis_r : 41: %addr($turkis_r));
  addColor('$TURKIS_U' : COLOR_turkis_u : 42: %addr($turkis_u));
  addColor('$TURKIS_RU': COLOR_turkis_ru: 43: %addr($turkis_ru));
  addColor('$YELLOW'   : COLOR_yellow   : 50: %addr($yellow));
  addColor('$YELLOW_R' : COLOR_yellow_r : 51: %addr($yellow_r));
  addColor('$YELLOW_U' : COLOR_yellow_u : 52: %addr($yellow_u));
  addColor('$PINK'     : COLOR_pink     : 60: %addr($pink));
  addColor('$PINK_R'   : COLOR_pink_r   : 61: %addr($pink_r));
  addColor('$PINK_U'   : COLOR_pink_u   : 62: %addr($pink_u));
  addColor('$PINK_RU'  : COLOR_pink_ru  : 63: %addr($pink_ru));
  addColor('$BLUE'     : COLOR_blue     : 70: %addr($blue));
  addColor('$BLUE_R'   : COLOR_blue_r   : 71: %addr($blue_r));
  addColor('$BLUE_U'   : COLOR_blue_u   : 72: %addr($blue_u));

  peek21_name = f_pgmCallN('PEEK21');
  peek23_name = f_pgmCallN('PEEK23');

  //  0 statt nbrfkeys: Keinen Platz für "F24=Weitere Tasten"
  //  reservieren, damit F3 und F5 nebeneinander in die Tastenleiste
  //  passen. Die übrigen Tasten (z.B. F12) erscheinen nach F24.
  peek23(sds.pgmName: '*ALL': 0
        : yFKeys: yNbrOfKeys);
  scrnFKeys = %subarr(yFKeys: 1);

endsr;

//============================================================*
//  Farbe in die Farbtabelle aufnehmen                        *
//============================================================*
dcl-proc addColor;
  dcl-pi *n;
    i_name  char(10) const;
    i_attr  char(1) const;
    i_ind   int(5) const;
    i_field pointer const;
  end-pi;

  nbrColors += 1;
  colorName(nbrColors) = i_name;
  colorAttr(nbrColors) = i_attr;
  colorInd(nbrColors) = i_ind;
  colorField(nbrColors) = i_field;

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

