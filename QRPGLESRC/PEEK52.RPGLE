**free
//===============================================================*
//                                                               *
//  (c) Thomas Raddatz                                           *
//                                                               *
//  Bereich  : PEEK, Version 2.1.0                               *
//  Programm : PEEK52                                            *
//  Typ      : RPG                                               *
//                                                               *
//  erstellt : 20.01.99  Raddatz                                 *
//  geändert : 27.04.99  2.1.0                                   *
//                                                               *
//===============================================================*
//                                                               *
//  Kurzdokumentation :                                          *
//                                                               *
//  Peek/400 - Abfrage "Programm erstellen"                      *
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

dcl-f peek52fm workstn(*ext) usage(*input: *output) usropn infds(workstn);

dcl-ds workstn likeds(workstn_t);

/copy QCOPYLE,D_VARDEF
/copy QCOPYLE,FLDL0100
/copy QCOPYLE,D_WORKSTN
/copy QCOPYLE,ShortCmd_D
/copy QCOPYLE,SET0012
/copy QCOPYLE,SDS
/copy QCOPYLE,SCRNFKEYS
/copy QCOPYLE,CEECNDHDLR

/copy QCOPYLE,USR8100
/copy QCOPYLE,USR8216
/copy QCOPYLE,USR8219

/define internal_prototype
/copy QCOPYLE,PPEEK52
/undefine internal_prototype

/copy QCOPYLE,PPEEK21
/copy QCOPYLE,PPEEK23

/copy QCOPYLE,PPEEK53
/copy QCOPYLE,PPEEK58

dcl-s yfkeys char(18) dim(32) inz;
dcl-s ynbrofkeys like(int4_t) inz;
dcl-s ymsgid char(7) inz;
dcl-s ymsgdta char(512) inz;
dcl-s ypgmcmd char(10) inz;
dcl-s ycmddta like(pgmcmddt_t) inz;

dcl-s sfbot like(int4_t) inz;
dcl-c nbrfkeys 2;

dcl-s peek21_name like(pgmcalln_t) inz;
dcl-s peek23_name like(pgmcalln_t) inz;

dcl-s dogenerate ind inz(bFalse);

dcl-ds set0012 likeds(set0012_t) inz;

dcl-s isInzSr like(bool_t) inz(bFalse);

//*******************************************************************
//                 S T E U E R  -  R O U T I N E                    *
//*******************************************************************
dcl-pi peek52;
  i_dsp80     like(dsp80_t) const;
  i_copyright like(copyrght_t) const;
  o_alwlc     like(bool_t);
  o_case      like(bool_t);
  o_cdlock    like(bool_t);
  o_nulldft   like(bool_t);
  o_keepcrs   like(bool_t);
  o_msgid     like(msgid_t);
  o_msgdta    like(msgdta_t);
  i_isunload  like(msgid_t) const;
end-pi;

dcl-s do_x1 packed(7);
//---------------------------------------------------*

//  Register error handler
ceehdlr(%paddr('errorHandler')
       : *null: *omit);

exsr inzsr;

if (i_isunload = bTrue);
  close peek52fm;
  *inlr = *on;
  return;
endif;

exsr first;

//---------------------------------------------------*
//  Schleife für Programmbearbeitung

dow ('1');

  //  Nachrichten anzeigen
  *in89 = '0';
  write msgctl;

  //  Anzeigen der Befehlstasten
  dogenerate = bFalse;
  exsr dspcmdkeys;

  //  Anzeigen Bildschirm
  exfmt bild01;

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

  //  Abfragen der Programmbefehle
  select;
  //  F3  - Ende
  when (ypgmcmd = '*EXIT');
    exsr c_endpgm;
    leave;

  //  F5  - Aktualisieren
  when (ypgmcmd = '*REFRESH');
    exsr c_refresh;
    iter;

  //  F12 - Ende
  when (ypgmcmd = '*CANCEL');
    exsr c_endpgm;
    leave;

  //  F24 - Weitere Tasten
  when (ypgmcmd = '*MOREKEYS');
    exsr c_morekeys;

  //  Datenfreigabe
  when (ypgmcmd = '*ENTER');
    exsr c_enter;
    if (*in99 = *off);
      o_msgid = 'USR8112';
      o_msgdta = *blanks;

      write msgctl2;
      dogenerate = bTrue;
      exsr dspcmdkeys;
      write bild02;

      leave;
    endif;

  other;
    //  Falsche Taste gedrückt
    p_wrongkey(workstn.aid: sds.pgmname);
    iter;
  endsl;

enddo;

return;

//============================================================*
//    dspCmdKeys    Anzeigen der Befehlstasten                *
//============================================================*

begsr dspcmdkeys;

  if (dogenerate);
    sfbot = 1;
  endif;

  select;
  when ((sfbot = 2) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#2;
  when ((sfbot = 3) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#3;
  when ((sfbot = 4) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#4;
  when ((sfbot = 5) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#5;
  when ((sfbot = 6) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#6;
  when ((sfbot = 7) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#7;
  when ((sfbot = 8) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#8;
  when ((sfbot = 9) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#9;
  when ((sfbot = 10) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#10;
  when ((sfbot = 11) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#11;
  when ((sfbot = 12) and
     (ynbrofkeys > nbrfkeys * (sfbot - 1)));
    write pbbot#12;
  other;
    if (not dogenerate);
      write pbbot#1;
    else;
      write pbbot2#1;
    endif;
    sfbot = 1;
  endsl;

endsr;

//============================================================*
//    C_Enter       "Datenfreigabetaste"                      *
//============================================================*

begsr c_enter;

  exsr prfb1;

  if (*in99 = *off);
    o_alwlc = ##alwlc;
    o_case = ##case;
    o_cdlock = ##rcdlck;
    o_nulldft = ##nulldft;
    o_keepcrs = ##keepcrs;
    if (##save = bTrue);
      exsr savusrsetg;
    endif;
  endif;

endsr;

//============================================================*
//    PRFB1         Prüfen der Eingaben                       *
//============================================================*

begsr prfb1;

  dou ('1');

    exsr prf22;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf20;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf24;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf23;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf25;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf26;
    if (*in99 = bTrue);
      leave;
    endif;

    exsr prf21;
    if (*in99 = bTrue);
      leave;
    endif;

  enddo;

endsr;

//============================================================*
//    PRF20         Prüfen:  case-sensitive                   *
//============================================================*

begsr prf20;

  dou ('1');

    if (##case <> bTrue and ##case <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##case;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
  endif;

endsr;

//============================================================*
//    PRF21         Prüfen:  save                             *
//============================================================*

begsr prf21;

  dou ('1');

    if (##save <> bTrue and ##save <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##save;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in21 = '1';
    *in31 = '1';
  endif;

endsr;

//============================================================*
//    PRF22         Prüfen:  alwlc                            *
//============================================================*

begsr prf22;

  dou ('1');

    if (##alwlc <> bTrue and ##alwlc <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##alwlc;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    PRF23         Prüfen:  Satz gesperrt einlesen           *
//============================================================*

begsr prf23;

  dou ('1');

    if (##rcdlck <> bTrue and ##rcdlck <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##rcdlck;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in23 = '1';
    *in33 = '1';
  endif;

endsr;

//============================================================*
//    PRF24         Prüfen:  case-sensitive                   *
//============================================================*

begsr prf24;

  dou ('1');

    if (##alwlc = bFalse and ##case  = bTrue);
      *in99 = '1';
      clear usr8216;
      p_sndpgmmg('USR8216': usr8216: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in20 = '1';
    *in30 = '1';
    *in22 = '1';
    *in32 = '1';
  endif;

endsr;

//============================================================*
//    PRF25         Prüfen:  nullDft                          *
//============================================================*

begsr prf25;

  dou ('1');

    if (##nulldft <> bTrue and ##nulldft <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##nulldft;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in25 = '1';
    *in35 = '1';
  endif;

endsr;

//============================================================*
//    PRF26         Prüfen:  keepCrs                          *
//============================================================*

begsr prf26;

  dou ('1');

    if (##keepcrs <> bTrue and ##keepcrs <> bFalse);
      *in99 = '1';
      clear usr8219;
      usr8219.var1 = ##keepcrs;
      p_sndpgmmg('USR8219': usr8219: sds.pgmname);
      leave;
    endif;

  enddo;

  if (*in99 = *on);
    *in26 = '1';
    *in36 = '1';
  endif;

endsr;

//============================================================*
//    BZOFF1        Ausschalten aller Fehlerbezugszahlen      *
//============================================================*

begsr bzoff1;

  //  DSPATR(PC)
  *in20 = '0';  // ##CASE
  *in21 = '0';  // ##SAVE
  *in22 = '0';  // ##ALWLC
  *in23 = '0';  // ##RCDLCK
  *in25 = '0';  // ##NULLDFT
  *in26 = '0';  // ##KEEPCRS

  //  DSPATR(RI)
  *in30 = '0';  // ##CASE
  *in31 = '0';  // ##SAVE
  *in32 = '0';  // ##ALWLC
  *in33 = '0';  // ##RCDLCK
  *in35 = '0';  // ##NULLDFT
  *in36 = '0';  // ##KEEPCRS

  //  Fehler
  *in99 = '0';

endsr;

//============================================================*
//    C_EndPgm      F3/F12 - Programm beenden                 *
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

  exsr bzoff1;
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

  ##alwlc   = set0012.set_alwlc;
  ##case    = set0012.set_case;
  ##rcdlck  = set0012.set_rcd_lock;
  ##nulldft = set0012.set_null_dft;
  ##keepcrs = set0012.set_keep_crs;
  ##save    = bFalse;

endsr;

//============================================================*
//    SetScreen     Einstellen 132/80-Zeichen Auflösung       *
//============================================================*

begsr setscreen;

  if (i_dsp80 = '0');
    //   132-Zeichen Anzeige
    *in88 = '0';
    zei = 1;
    pos = 40;
  else;
    //    80-Zeichen Anzeige
    *in88 = '1';
    zei = 3;
    pos = 7;
  endif;

endsr;

//============================================================*
//    GetUsrSetg    Ermitteln der Benutzervoreinstellungen    *
//============================================================*

begsr getusrsetg;

  //  *CRTPGM
  set0012 = f_getusrsg('*CRTPGM');

endsr;

//============================================================*
//    SavUsrSetg    Sichern der Benutzervoreinstellungen      *
//============================================================*

begsr savusrsetg;

  //  *CRTPGM
  set0012.set_case = ##case;
  set0012.set_rcd_lock = ##rcdlck;
  set0012.set_alwlc = ##alwlc;
  set0012.set_null_dft = ##nulldft;
  set0012.set_keep_crs = ##keepcrs;
  p_updusrsg('*CRTPGM': set0012);

endsr;

//============================================================*
//    First         Initialisierung                           *
//============================================================*

begsr first;

  // - Öffnen der Dateien
  open peek52fm;

  // - Benutzervoreinstellungen
  exsr getusrsetg;

  // - Füllen der Bildschirmfelder
  exsr bzoff1;
  exsr fill##;

  // - Programm initialisieren
  p_rmvpgmmg(sds.pgmname);

  o_msgid = '';
  o_msgdta = '';

  // - Darstellung der Befehlstasten
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
  dcl-pi *n;
    i_condtoken    likeds(cee_fc_t) value;
    i_pcommarea    int(10) value;
    o_action       int(10);
    o_newcondtoken likeds(cee_fc_t);
  end-pi;

  dump;
  o_action = cee_percolate;

end-proc;

