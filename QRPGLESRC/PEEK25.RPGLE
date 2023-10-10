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
/COPY QCOPYLE,H_SPEC
/COPY QCOPYLE,COPYRIGHT

dcl-f peek25fm workstn(*ext) usage(*input:*output)
      usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);
dcl-ds cursorPosition likeds(cursorPosition_t) inz;

/COPY QCOPYLE,D_VARDEF
/COPY QCOPYLE,FLDL0100
/COPY QCOPYLE,D_WORKSTN
/COPY QCOPYLE,D_COLORATR
/COPY QCOPYLE,ShortCmd_D
/COPY QCOPYLE,SDS
/COPY QCOPYLE,SCRNFKEYS
/COPY QCOPYLE,CEECNDHDLR

/define internal_prototype
/COPY QCOPYLE,PPEEK25
/undefine internal_prototype

/COPY QCOPYLE,USR8100

/COPY QCOPYLE,PPEEK21
/COPY QCOPYLE,PPEEK23

/COPY QCOPYLE,PPEEK53
/COPY QCOPYLE,PPEEK58

dcl-s yfkeys          char(18) dim(32);
dcl-s ynbrofkeys      like(int4_t);
dcl-s ymsgid          char(7);
dcl-s ymsgdta         char(512);

dcl-s ypgmcmd         char(10);
dcl-s ycmddta         like(pgmcmddt_t);

dcl-s sfbot           like(int4_t);
dcl-c nbrfkeys const(2);

dcl-s wrk_field       char(10);

dcl-c CHAR const('x');

dcl-s peek21_name     like(pgmcalln_t) inz;
dcl-s peek23_name     like(pgmcalln_t) inz;

dcl-s isInzSr         like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************

dcl-pi peek25;
  i_dsp80         const like(dsp80_t);
  o_colorattr           like(color_t);
  o_msgid               like(msgid_t);
  o_msgdta              like(msgdta_t);
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
  if ymsgid <> *blanks;
    p_sndpgmmg(ymsgid: ymsgdta: sds.pgmname);
    ymsgid = '';
    ymsgdta = '';
    iter;
  endif;

  //  Abfragen der Befehlstasten
  select;
  when ypgmcmd = '*EXIT';
    exsr c_endpgm;
    leave;
  when ypgmcmd = '*REFRESH';
    exsr c_refresh;
    iter;
  when ypgmcmd = '*CANCEL';
    exsr c_endpgm;
    leave;
  when ypgmcmd = '*MOREKEYS';
    exsr c_morekeys;
  when ypgmcmd = '*ENTER';
    exsr c_enter;
    if *in99 = *off;
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

  dou ('1');

    if (scnfld <> '');
      exsr extrcolor;
    else;
      *in99 = '1';
      p_sndpgmmg('USR8147': '': sds.pgmname);
      leave;
    endif;

  enddo;

  if *in99 = *on;
  //               ??????????
  endif;

endsr;

//============================================================*
//    C_EndPgm      F12    - Programm beenden                 *
//============================================================*

begsr c_endpgm;

  p_rmvpgmmg(sds.pgmname);

  o_msgid = 'USR8100';

  select;
  when workstn.aid = k_f3;
    usr8100.var1 = 'F3';
  when workstn.aid = k_f12;
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

  $green = COLOR_green;
  $green = %xlate(' ': CHAR: $green);
  $green_r = COLOR_green_r;
  $green_r = %xlate(' ': CHAR: $green_r);
  $green_u = COLOR_green_u;
  $green_u = %xlate(' ': CHAR: $green_u);
  $green_ru = COLOR_green_ru;
  $green_ru = %xlate(' ': CHAR: $green_ru);

  $white = COLOR_white;
  $white = %xlate(' ': CHAR: $white);
  $white_r = COLOR_white_r;
  $white_r = %xlate(' ': CHAR: $white_r);
  $white_u = COLOR_white_u;
  $white_u = %xlate(' ': CHAR: $white_u);

  $red = COLOR_red;
  $red = %xlate(' ': CHAR: $red);
  $red_r = COLOR_red_r;
  $red_r = %xlate(' ': CHAR: $red_r);
  $red_u = COLOR_red_u;
  $red_u = %xlate(' ': CHAR: $red_u);
  $red_ru = COLOR_red_ru;
  $red_ru = %xlate(' ': CHAR: $red_ru);
  $red_b = COLOR_red_b;
  $red_b = %xlate(' ': CHAR: $red_b);
  $red_rb = COLOR_red_rb;
  $red_rb = %xlate(' ': CHAR: $red_rb);
  $red_ub = COLOR_red_ub;
  $red_ub = %xlate(' ': CHAR: $red_ub);

  $turkis = COLOR_turkis;
  $turkis = %xlate(' ': CHAR: $turkis);
  $turkis_r = COLOR_turkis_r;
  $turkis_r = %xlate(' ': CHAR: $turkis_r);
  $turkis_u = COLOR_turkis_u;
  $turkis_u = %xlate(' ': CHAR: $turkis_u);
  $turkis_ru = COLOR_turkis_ru;
  $turkis_ru = %xlate(' ': CHAR: $turkis_ru);

  $yellow = COLOR_yellow;
  $yellow = %xlate(' ': CHAR: $yellow);
  $yellow_r = COLOR_yellow_r;
  $yellow_r = %xlate(' ': CHAR: $yellow_r);
  $yellow_u = COLOR_yellow_u;
  $yellow_u = %xlate(' ': CHAR: $yellow_u);

  $pink = COLOR_pink;
  $pink = %xlate(' ': CHAR: $pink);
  $pink_r = COLOR_pink_r;
  $pink_r = %xlate(' ': CHAR: $pink_r);
  $pink_u = COLOR_pink_u;
  $pink_u = %xlate(' ': CHAR: $pink_u);
  $pink_ru = COLOR_pink_ru;
  $pink_ru = %xlate(' ': CHAR: $pink_ru);

  $blue = COLOR_blue;
  $blue = %xlate(' ': CHAR: $blue);
  $blue_r = COLOR_blue_r;
  $blue_r = %xlate(' ': CHAR: $blue_r);
  $blue_u = COLOR_blue_u;
  $blue_u = %xlate(' ': CHAR: $blue_u);

endsr;

//============================================================*
//    PosCsr        Positionieren Cursor auf aktuelle Farbe   *
//============================================================*

begsr poscsr;

  %subarr(*in: 10: 10) = '0'; // - Green
  %subarr(*in: 20: 10) = '0'; // - White
  %subarr(*in: 30: 10) = '0'; // - Red
  %subarr(*in: 40: 10) = '0'; // - Türkis
  %subarr(*in: 50: 10) = '0'; // - Yellow
  %subarr(*in: 60: 10) = '0'; // - Pink
  %subarr(*in: 70: 10) = '0'; // - Blue

  // Green
  select;
  when o_colorattr = COLOR_green;
    *in10 = '1';
  when o_colorattr = COLOR_green_r;
    *in11 = '1';
  when o_colorattr = COLOR_green_u;
    *in12 = '1';
  when o_colorattr = COLOR_green_ru;
    *in13 = '1';
  // White
  when o_colorattr = COLOR_white;
    *in20 = '1';
  when o_colorattr = COLOR_white_r;
    *in21 = '1';
  when o_colorattr = COLOR_white_u;
    *in22 = '1';
  // Red
  when o_colorattr = COLOR_red;
    *in30 = '1';
  when o_colorattr = COLOR_red_r;
    *in31 = '1';
  when o_colorattr = COLOR_red_u;
    *in32 = '1';
  when o_colorattr = COLOR_red_ru;
    *in33 = '1';
  when o_colorattr = COLOR_red_b;
    *in34 = '1';
  when o_colorattr = COLOR_red_rb;
    *in35 = '1';
  when o_colorattr = COLOR_red_ub;
    *in36 = '1';
  // Türkis
  when o_colorattr = COLOR_turkis;
    *in40 = '1';
  when o_colorattr = COLOR_turkis_r;
    *in41 = '1';
  when o_colorattr = COLOR_turkis_u;
    *in42 = '1';
  when o_colorattr = COLOR_turkis_ru;
    *in43 = '1';
  // Yellow
  when o_colorattr = COLOR_yellow;
    *in50 = '1';
  when o_colorattr = COLOR_yellow_r;
    *in51 = '1';
  when o_colorattr = COLOR_yellow_u;
    *in52 = '1';
  // Pink
  when o_colorattr = COLOR_pink;
    *in60 = '1';
  when o_colorattr = COLOR_pink_r;
    *in61 = '1';
  when o_colorattr = COLOR_pink_u;
    *in62 = '1';
  when o_colorattr = COLOR_pink_ru;
    *in63 = '1';
  // Blue
  when o_colorattr = COLOR_blue;
    *in70 = '1';
  when o_colorattr = COLOR_blue_r;
    *in71 = '1';
  when o_colorattr = COLOR_blue_u;
    *in72 = '1';

  other;
    p_kill('Illegal color attribute.');
  endsl;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  if i_dsp80 = '0';
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

  select;
  //  Green
  when scnfld = '$GREEN';
    wrk_field = $green;
  when scnfld = '$GREEN_R';
    wrk_field = $green_r;
  when scnfld = '$GREEN_U';
    wrk_field = $green_u;
  when scnfld = '$GREEN_RU';
    wrk_field = $green_ru;
  //  White
  when scnfld = '$WHITE';
    wrk_field = $white;
  when scnfld = '$WHITE_R';
    wrk_field = $white_r;
  when scnfld = '$WHITE_U';
    wrk_field = $white_u;
  //  Red
  when scnfld = '$RED';
    wrk_field = $red;
  when scnfld = '$RED_R';
    wrk_field = $red_r;
  when scnfld = '$RED_U';
    wrk_field = $red_u;
  when scnfld = '$RED_RU';
    wrk_field = $red_ru;
  when scnfld = '$RED_B';
    wrk_field = $red_b;
  when scnfld = '$RED_RB';
    wrk_field = $red_rb;
  when scnfld = '$RED_UB';
    wrk_field = $red_ub;
  //  Turquoise
  when scnfld = '$TURKIS';
    wrk_field = $turkis;
  when scnfld = '$TURKIS_R';
    wrk_field = $turkis_r;
  when scnfld = '$TURKIS_U';
    wrk_field = $turkis_u;
  when scnfld = '$TURKIS_RU';
    wrk_field = $turkis_ru;
  //  Yellow
  when scnfld = '$YELLOW';
    wrk_field = $yellow;
  when scnfld = '$YELLOW_R';
    wrk_field = $yellow_r;
  when scnfld = '$YELLOW_U';
    wrk_field = $yellow_u;
  //  Pink
  when scnfld = '$PINK';
    wrk_field = $pink;
  when scnfld = '$PINK_R';
    wrk_field = $pink_r;
  when scnfld = '$PINK_U';
    wrk_field = $pink_u;
  when scnfld = '$PINK_RU';
    wrk_field = $pink_ru;
  //  Blue
  when scnfld = '$BLUE';
    wrk_field = $blue;
  when scnfld = '$BLUE_R';
    wrk_field = $blue_r;
  when scnfld = '$BLUE_U';
    wrk_field = $blue_u;

  other;
    wrk_field = *blanks;
  endsl;

  if wrk_field <> *blanks;
    o_colorattr = %subst(wrk_field:1:1);
  else;
  //                ????????
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

  peek21_name = f_pgmcalln('PEEK21');
  peek23_name = f_pgmcalln('PEEK23');

  peek23(sds.pgmname: '*ALL': 0
        : yfkeys: ynbrofkeys);
  scrnfkeys = %subarr(yfkeys: 1);

endsr;

//============================================================*
//  Program error handler                                     *
//============================================================*

dcl-proc errorhandler;
  dcl-pi *N;
    i_condtoken     value likeds(cee_fc_t);
    i_pcommarea     int(10) value;
    o_action        int(10);
    o_newcondtoken  likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

