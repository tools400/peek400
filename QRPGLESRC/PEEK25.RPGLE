**free
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
/copy QCOPYLE,H_SPEC
/copy QCOPYLE,COPYRIGHT

dcl-f peek25fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

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

/define internal_prototype
/copy QCOPYLE,PPEEK25
/undefine internal_prototype

/copy QCOPYLE,USR8100

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yfkeys char(18) dim(32);
dcl-s ynbrofkeys like(int4_t);
dcl-s ymsgid char(7);
dcl-s ymsgdta char(512);

dcl-s ypgmcmd char(10);
dcl-s ycmddta like(pgmcmddt_t);

dcl-s sfbot like(int4_t);
dcl-c nbrfkeys 2;

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

dcl-s peek21_name like(pgmcalln_t) inz;
dcl-s peek23_name like(pgmcalln_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek25;
  i_dsp80     like(dsp80_t) const;
  o_colorattr like(color_t);
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
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#2;
  when (sfbot = 3) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#3;
  when (sfbot = 4) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#4;
  when (sfbot = 5) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
    write pbbot#5;
  when (sfbot = 6) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1));
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
    if (*in99 = *off);
      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

close peek25fm;

return;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfb1;

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

  exsr extrcolor;

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
//    C_Refresh     F5  - Aktualisieren der Subfile           *
//============================================================*

begsr c_refresh;

  exsr fill##;
  exsr poscsr;

  //  Cursor auf die aktuelle Farbe (DSPATR(PC)). Mit einer Position
  //  in CSRROW/CSRCOL hätte CSRLOC Vorrang.
  csrrow = 0;
  csrcol = 0;

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

  //  Farbattribut und zwei Zeichen in der Farbe
  for i = 1 to nbrColors;
    pScnColor = colorField(i);
    scnColor = colorAttr(i) + CHAR + CHAR;
  endfor;

endsr;

//============================================================*
//    PosCsr        Positionieren Cursor auf aktuelle Farbe   *
//============================================================*

begsr poscsr;

  for i = 1 to nbrColors;
    *in(colorInd(i)) = *off;
  endfor;

  //  Ein unbekanntes Attribut, z.B. aus alten Einstellungen, wird
  //  nicht vorausgewählt.
  i = %lookup(o_colorattr: colorAttr: 1: nbrColors);
  if (i > 0);
    *in(colorInd(i)) = *on;
  endif;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

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
//    ExtrColor     Extrahieren Farbattribut                  *
//============================================================*

begsr extrcolor;

  i = %lookup(scnfld: colorName: 1: nbrColors);
  if (i > 0);
    o_colorattr = colorAttr(i);
  else;
    //  Cursor steht auf keiner Farbe, z.B. auf der Zeilenbeschriftung
    *in99 = '1';
    p_sndpgmmg('USR8146': '': sds.pgmname);
  endif;

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek25fm;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  // - Bildschirmfelder füllen
  exsr fill##;
  exsr poscsr;

  o_msgid = *blanks;
  o_msgdta = *blanks;

  //  Löschen der Cursorosition
  csrrow = *zeros;
  csrcol = *zeros;

  // - Einstellen Darstellung der Funktionstasten
  sfbot = 1;

  // - Einstellen der Bildschirmauflösung 80/132-Zeichen
  exsr setscreen;

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

  //  Farbtabelle (Bezugszahlen aus PEEK25FM)
  addColor('$GREEN'    : COLOR_green    : 10: %addr($green));
  addColor('$GREEN_R'  : COLOR_green_r  : 11: %addr($green_r));
  addColor('$GREEN_U'  : COLOR_green_u  : 12: %addr($green_u));
  addColor('$GREEN_RU' : COLOR_green_ru : 13: %addr($green_ru));
  addColor('$WHITE'    : COLOR_white    : 20: %addr($white));
  addColor('$WHITE_R'  : COLOR_white_r  : 21: %addr($white_r));
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

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');

  //  0 statt nbrfkeys: Keinen Platz für "F24=Weitere Tasten"
  //  reservieren, damit F3 und F5 nebeneinander in die Tastenleiste
  //  passen. Die übrigen Tasten (z.B. F12) erscheinen nach F24.
  peek23(sds.pgmname: '*ALL': 0
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

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

